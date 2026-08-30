<?php
/**
 * Customer accounts: registration, password sign-in and OTP verification.
 *
 * A deliberately SEPARATE identity from the OAuth users in auth.php — signing
 * in with Google does not create or unlock a customer record here, and vice
 * versa. They share one thing only: the PHP session started by
 * auth_session_start(), so both can coexist without two competing session
 * cookies. This module just adds its own key inside that session
 * ($_SESSION['customer_id']) and its own tables in the same SQLite file.
 *
 * OTP delivery: no SMS/email provider is configured anywhere in this repo
 * (see .env.example — there is no SMTP or SMS block). Sending is therefore
 * stubbed exactly like an unconfigured OAuth provider in login.php: the code
 * is generated and stored for real, verification is enforced for real, but
 * until a provider is wired up the code is shown on-screen behind an
 * unmissable "development mode" notice instead of being silently faked.
 */
declare(strict_types=1);

require_once __DIR__ . '/auth.php';

const CUSTOMER_OTP_TTL      = 600;  // 10 minutes
const CUSTOMER_OTP_RESEND_COOLDOWN = 60;
const CUSTOMER_OTP_MAX_ATTEMPTS    = 5;

function customer_migrate(PDO $pdo): void
{
    $pdo->exec("
        CREATE TABLE IF NOT EXISTS customers (
            id                 INTEGER PRIMARY KEY AUTOINCREMENT,
            customer_code      TEXT UNIQUE NOT NULL,
            full_name          TEXT NOT NULL,
            dob                TEXT NOT NULL,
            gender             TEXT NOT NULL,
            nationality        TEXT NOT NULL,
            mobile             TEXT NOT NULL,
            whatsapp           TEXT NOT NULL,
            email              TEXT UNIQUE NOT NULL,
            address_line       TEXT NOT NULL,
            city               TEXT NOT NULL,
            state              TEXT NOT NULL,
            country            TEXT NOT NULL,
            pin_code           TEXT NOT NULL,
            password_hash      TEXT NOT NULL,
            comms_consent      INTEGER NOT NULL DEFAULT 0,
            status             TEXT NOT NULL DEFAULT 'pending_verification',
            email_verified_at  INTEGER,
            created_at         INTEGER NOT NULL,
            last_login_at      INTEGER
        )");
    $pdo->exec("
        CREATE TABLE IF NOT EXISTS customer_passports (
            id                INTEGER PRIMARY KEY AUTOINCREMENT,
            customer_id       INTEGER NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
            passport_number   TEXT NOT NULL,
            issue_date        TEXT NOT NULL,
            expiry_date       TEXT NOT NULL,
            issuing_country   TEXT NOT NULL,
            place_of_issue    TEXT NOT NULL,
            created_at        INTEGER NOT NULL
        )");
    $pdo->exec('CREATE INDEX IF NOT EXISTS idx_customer_passports_customer ON customer_passports(customer_id)');
    $pdo->exec("
        CREATE TABLE IF NOT EXISTS customer_otp (
            id            INTEGER PRIMARY KEY AUTOINCREMENT,
            customer_id   INTEGER NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
            purpose       TEXT NOT NULL,
            code_hash     TEXT NOT NULL,
            attempts      INTEGER NOT NULL DEFAULT 0,
            expires_at    INTEGER NOT NULL,
            consumed_at   INTEGER,
            created_at    INTEGER NOT NULL
        )");
    $pdo->exec('CREATE INDEX IF NOT EXISTS idx_customer_otp_customer ON customer_otp(customer_id, purpose)');
}

/** Same SQLite file as OAuth users — just more tables in it. */
function customer_db(): ?PDO
{
    static $migrated = false;
    $pdo = auth_db();
    if (!$pdo) {
        return null;
    }
    if (!$migrated) {
        customer_migrate($pdo);
        $migrated = true;
    }
    return $pdo;
}

function customer_code_for(int $id): string
{
    return 'CUST' . str_pad((string) $id, 5, '0', STR_PAD_LEFT);
}

// ---------------------------------------------------------------------
// Lookup
// ---------------------------------------------------------------------

function customer_find(int $id): ?array
{
    $pdo = customer_db();
    if (!$pdo) return null;
    $st = $pdo->prepare('SELECT * FROM customers WHERE id = ?');
    $st->execute([$id]);
    return $st->fetch() ?: null;
}

function customer_find_by_email(string $email): ?array
{
    $pdo = customer_db();
    if (!$pdo) return null;
    $st = $pdo->prepare('SELECT * FROM customers WHERE email = ?');
    $st->execute([mb_strtolower(trim($email))]);
    return $st->fetch() ?: null;
}

/** Accepts an email or a customer code (CUST00045) in the same field. */
function customer_find_by_login(string $identifier): ?array
{
    $identifier = trim($identifier);
    if ($identifier === '') return null;
    $pdo = customer_db();
    if (!$pdo) return null;
    if (preg_match('/^CUST\d+$/i', $identifier)) {
        $st = $pdo->prepare('SELECT * FROM customers WHERE customer_code = ?');
        $st->execute([strtoupper($identifier)]);
        return $st->fetch() ?: null;
    }
    return customer_find_by_email($identifier);
}

// ---------------------------------------------------------------------
// Registration
// ---------------------------------------------------------------------

/**
 * @param array $p Validated field values (see register.php for the checks
 *                 run before this is ever called — this function trusts its
 *                 caller, not the request).
 * @return array{0:?int,1:string} [customer id, error]. Error is '' on success.
 */
function customer_register(array $p): array
{
    $pdo = customer_db();
    if (!$pdo) return [null, 'Registration is temporarily unavailable. Please try again shortly.'];

    if (customer_find_by_email($p['email'])) {
        return [null, 'An account already exists for that email address.'];
    }

    try {
        $pdo->beginTransaction();
        $now = time();
        $st = $pdo->prepare('
            INSERT INTO customers
                (customer_code, full_name, dob, gender, nationality, mobile, whatsapp, email,
                 address_line, city, state, country, pin_code, password_hash, comms_consent,
                 status, created_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)');
        $st->execute([
            'PENDING', $p['full_name'], $p['dob'], $p['gender'], $p['nationality'],
            $p['mobile'], $p['whatsapp'], mb_strtolower($p['email']),
            $p['address_line'], $p['city'], $p['state'], $p['country'], $p['pin_code'],
            password_hash($p['password'], PASSWORD_DEFAULT),
            $p['comms_consent'] ? 1 : 0, 'pending_verification', $now,
        ]);
        $id = (int) $pdo->lastInsertId();

        // The code embeds the row id, so it can only be assigned after the
        // insert — this two-step UPDATE (rather than a second INSERT) keeps
        // the customer and their passport on the same id.
        $code = customer_code_for($id);
        $pdo->prepare('UPDATE customers SET customer_code = ? WHERE id = ?')->execute([$code, $id]);

        $pdo->prepare('
            INSERT INTO customer_passports
                (customer_id, passport_number, issue_date, expiry_date, issuing_country, place_of_issue, created_at)
            VALUES (?, ?, ?, ?, ?, ?, ?)')
            ->execute([$id, $p['passport_number'], $p['passport_issue_date'], $p['passport_expiry_date'],
                       $p['passport_issuing_country'], $p['passport_place_of_issue'], $now]);

        $pdo->commit();
        return [$id, ''];
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        log_error('customer_auth: registration failed — ' . $e->getMessage());
        return [null, 'Something went wrong saving your details. Please try again.'];
    }
}

// ---------------------------------------------------------------------
// OTP
// ---------------------------------------------------------------------

/**
 * Issues a fresh OTP, invalidating any earlier unconsumed one for the same
 * purpose. Returns the plaintext code — the ONLY place it ever exists outside
 * the hash — so the caller can hand it to whatever channel is configured (or,
 * today, display it under the dev-mode notice).
 */
function customer_otp_issue(int $customerId, string $purpose = 'register'): ?string
{
    $pdo = customer_db();
    if (!$pdo) return null;
    $now = time();
    $pdo->prepare('UPDATE customer_otp SET consumed_at = ? WHERE customer_id = ? AND purpose = ? AND consumed_at IS NULL')
        ->execute([$now, $customerId, $purpose]);
    $code = str_pad((string) random_int(0, 999999), 6, '0', STR_PAD_LEFT);
    $pdo->prepare('INSERT INTO customer_otp (customer_id, purpose, code_hash, expires_at, created_at) VALUES (?, ?, ?, ?, ?)')
        ->execute([$customerId, $purpose, password_hash($code, PASSWORD_DEFAULT), $now + CUSTOMER_OTP_TTL, $now]);
    return $code;
}

/** Seconds until a resend is allowed again; 0 if allowed right now. */
function customer_otp_resend_wait(int $customerId, string $purpose = 'register'): int
{
    $pdo = customer_db();
    if (!$pdo) return 0;
    $st = $pdo->prepare('SELECT created_at FROM customer_otp WHERE customer_id = ? AND purpose = ? ORDER BY id DESC LIMIT 1');
    $st->execute([$customerId, $purpose]);
    $last = $st->fetchColumn();
    if ($last === false) return 0;
    $wait = CUSTOMER_OTP_RESEND_COOLDOWN - (time() - (int) $last);
    return max(0, $wait);
}

/** @return string '' on success, else a user-facing error message. */
function customer_otp_verify(int $customerId, string $code, string $purpose = 'register'): string
{
    $pdo = customer_db();
    if (!$pdo) return 'Verification is temporarily unavailable. Please try again shortly.';
    $st = $pdo->prepare('SELECT * FROM customer_otp WHERE customer_id = ? AND purpose = ? AND consumed_at IS NULL ORDER BY id DESC LIMIT 1');
    $st->execute([$customerId, $purpose]);
    $row = $st->fetch();
    if (!$row) return 'No pending code — request a new one.';
    if ($row['attempts'] >= CUSTOMER_OTP_MAX_ATTEMPTS) return 'Too many incorrect attempts. Request a new code.';
    if (time() > (int) $row['expires_at']) return 'That code has expired. Request a new one.';

    if (!password_verify($code, $row['code_hash'])) {
        $pdo->prepare('UPDATE customer_otp SET attempts = attempts + 1 WHERE id = ?')->execute([$row['id']]);
        return 'Incorrect code — please check and try again.';
    }
    $pdo->prepare('UPDATE customer_otp SET consumed_at = ? WHERE id = ?')->execute([time(), $row['id']]);
    return '';
}

// ---------------------------------------------------------------------
// Session (rides on the SAME session auth_session_start() opens)
// ---------------------------------------------------------------------

function customer_login(int $customerId): void
{
    auth_session_start();
    session_regenerate_id(true);
    $_SESSION['customer_id'] = $customerId;
    $pdo = customer_db();
    if ($pdo) {
        $pdo->prepare('UPDATE customers SET last_login_at = ? WHERE id = ?')->execute([time(), $customerId]);
    }
}

function customer_logout(): void
{
    auth_session_start();
    unset($_SESSION['customer_id']);
}

/** The signed-in customer, or null. Independent of auth_user(). */
function customer_current(): ?array
{
    static $cached = false;
    static $row = null;
    if ($cached) return $row;
    $cached = true;
    auth_session_start();
    $id = $_SESSION['customer_id'] ?? null;
    if (!$id) return null;
    $row = customer_find((int) $id);
    if (!$row || $row['status'] !== 'active') {
        unset($_SESSION['customer_id']);
        $row = null;
    }
    return $row;
}

function customer_activate(int $customerId): void
{
    $pdo = customer_db();
    if (!$pdo) return;
    $pdo->prepare("UPDATE customers SET status = 'active', email_verified_at = ? WHERE id = ?")
        ->execute([time(), $customerId]);
}

function customer_verify_password(array $customer, string $password): bool
{
    return password_verify($password, $customer['password_hash']);
}
