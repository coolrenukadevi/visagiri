<?php
/**
 * Employee accounts: the CRM operations side, as separate from Customer
 * accounts (customer_auth.php) as Customer is from OAuth (auth.php) — a
 * third identity, its own $_SESSION key ($_SESSION['employee_id']), same
 * shared session and same shared SQLite file.
 *
 * There is no self-registration. Nothing in the spec wants a public sign-up
 * form for staff accounts. The CLI bootstrap (tools/create-employee.php)
 * remains the only way to create the FIRST admin — the same "real but
 * manual until the real UI exists" approach already used for exchange-rate
 * refresh (tools/refresh-currency.php) — but every account after that can
 * be created from the admin console (employee-admin.php) once one admin
 * exists, which is what `is_admin` gates.
 *
 * `is_admin` is deliberately a separate column from `role`: role is a job
 * title for display (e.g. "Visa Consultant"), is_admin is a permission.
 * Conflating them would mean either every consultant becomes an admin or
 * "Admin" has to be invented as a fake job title — this keeps the two
 * questions ("what do you do" vs "what can you configure") independent.
 */
declare(strict_types=1);

require_once __DIR__ . '/auth.php';

function employee_migrate(PDO $pdo): void
{
    $pdo->exec("
        CREATE TABLE IF NOT EXISTS employees (
            id              INTEGER PRIMARY KEY AUTOINCREMENT,
            employee_code   TEXT UNIQUE NOT NULL,
            full_name       TEXT NOT NULL,
            email           TEXT UNIQUE NOT NULL,
            password_hash   TEXT NOT NULL,
            role            TEXT NOT NULL DEFAULT 'Consultant',
            status          TEXT NOT NULL DEFAULT 'active',
            is_admin        INTEGER NOT NULL DEFAULT 0,
            created_at      INTEGER NOT NULL,
            last_login_at   INTEGER
        )");
    // is_admin shipped in Phase 8, after Phase 7's employees table was
    // already live — add it to a database created before this column
    // existed, rather than requiring anyone to wipe and restart.
    $cols = $pdo->query('PRAGMA table_info(employees)')->fetchAll(PDO::FETCH_COLUMN, 1);
    if (!in_array('is_admin', $cols, true)) {
        $pdo->exec('ALTER TABLE employees ADD COLUMN is_admin INTEGER NOT NULL DEFAULT 0');
    }
}

/** Same SQLite file as everything else — just more tables in it. */
function employee_db(): ?PDO
{
    static $migrated = false;
    $pdo = auth_db();
    if (!$pdo) return null;
    if (!$migrated) {
        employee_migrate($pdo);
        $migrated = true;
    }
    return $pdo;
}

function employee_code_for(int $id): string
{
    return 'EMP' . str_pad((string) $id, 5, '0', STR_PAD_LEFT);
}

// ---------------------------------------------------------------------
// Lookup
// ---------------------------------------------------------------------

function employee_find(int $id): ?array
{
    $pdo = employee_db();
    if (!$pdo) return null;
    $st = $pdo->prepare('SELECT * FROM employees WHERE id = ?');
    $st->execute([$id]);
    return $st->fetch() ?: null;
}

function employee_find_by_email(string $email): ?array
{
    $pdo = employee_db();
    if (!$pdo) return null;
    $st = $pdo->prepare('SELECT * FROM employees WHERE email = ?');
    $st->execute([mb_strtolower(trim($email))]);
    return $st->fetch() ?: null;
}

/** Accepts an email or an employee code (EMP00007) in the same field. */
function employee_find_by_login(string $identifier): ?array
{
    $identifier = trim($identifier);
    if ($identifier === '') return null;
    $pdo = employee_db();
    if (!$pdo) return null;
    if (preg_match('/^EMP\d+$/i', $identifier)) {
        $st = $pdo->prepare('SELECT * FROM employees WHERE employee_code = ?');
        $st->execute([strtoupper($identifier)]);
        return $st->fetch() ?: null;
    }
    return employee_find_by_email($identifier);
}

// ---------------------------------------------------------------------
// Bootstrap (used only by tools/create-employee.php)
// ---------------------------------------------------------------------

/**
 * Creates an employee with a freshly generated password. The plaintext
 * password is returned exactly once — the caller (the CLI tool) is
 * responsible for showing it to whoever is running the script; it is never
 * logged or stored anywhere but the hash.
 *
 * @return array{0:?int,1:string,2:string} [employee id, plaintext password, error]
 */
function employee_create(string $fullName, string $email, string $role = 'Consultant', bool $isAdmin = false): array
{
    $pdo = employee_db();
    if (!$pdo) return [null, '', 'Database unavailable.'];
    if (employee_find_by_email($email)) {
        return [null, '', 'An employee already exists with that email address.'];
    }

    $password = bin2hex(random_bytes(9)); // 18 hex chars — printable, unambiguous, no cross-shell escaping issues
    try {
        $pdo->beginTransaction();
        $now = time();
        $pdo->prepare('
            INSERT INTO employees (employee_code, full_name, email, password_hash, role, status, is_admin, created_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)')
            ->execute(['PENDING', $fullName, mb_strtolower($email), password_hash($password, PASSWORD_DEFAULT), $role, 'active', $isAdmin ? 1 : 0, $now]);
        $id = (int) $pdo->lastInsertId();
        $pdo->prepare('UPDATE employees SET employee_code = ? WHERE id = ?')->execute([employee_code_for($id), $id]);
        $pdo->commit();
        return [$id, $password, ''];
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        log_error('employee_auth: create failed — ' . $e->getMessage());
        return [null, '', 'Something went wrong creating the account.'];
    }
}

// ---------------------------------------------------------------------
// Session (rides on the SAME session auth_session_start() opens)
// ---------------------------------------------------------------------

function employee_login(int $employeeId): void
{
    auth_session_start();
    session_regenerate_id(true);
    $_SESSION['employee_id'] = $employeeId;
    $pdo = employee_db();
    if ($pdo) {
        $pdo->prepare('UPDATE employees SET last_login_at = ? WHERE id = ?')->execute([time(), $employeeId]);
    }
}

function employee_logout(): void
{
    auth_session_start();
    unset($_SESSION['employee_id']);
}

/** The signed-in employee, or null. Independent of auth_user()/customer_current(). */
function employee_current(): ?array
{
    static $cached = false;
    static $row = null;
    if ($cached) return $row;
    $cached = true;
    auth_session_start();
    $id = $_SESSION['employee_id'] ?? null;
    if (!$id) return null;
    $row = employee_find((int) $id);
    if (!$row || $row['status'] !== 'active') {
        unset($_SESSION['employee_id']);
        $row = null;
    }
    return $row;
}

function employee_verify_password(array $employee, string $password): bool
{
    return password_verify($password, $employee['password_hash']);
}

// ---------------------------------------------------------------------
// Admin console (Phase 8) — employee directory, activation, admin grants
// ---------------------------------------------------------------------

function employees_all(): array
{
    $pdo = employee_db();
    if (!$pdo) return [];
    return $pdo->query('SELECT * FROM employees ORDER BY full_name')->fetchAll();
}

function employees_active(): array
{
    return array_values(array_filter(employees_all(), static fn($e) => $e['status'] === 'active'));
}

function employee_count_admins(): int
{
    $pdo = employee_db();
    if (!$pdo) return 0;
    return (int) $pdo->query("SELECT COUNT(*) FROM employees WHERE is_admin = 1 AND status = 'active'")->fetchColumn();
}

function employee_set_status(int $id, string $status): void
{
    $pdo = employee_db();
    if (!$pdo) return;
    $status = in_array($status, ['active', 'inactive'], true) ? $status : 'active';
    $pdo->prepare('UPDATE employees SET status = ? WHERE id = ?')->execute([$status, $id]);
}

function employee_set_admin(int $id, bool $isAdmin): void
{
    $pdo = employee_db();
    if (!$pdo) return;
    $pdo->prepare('UPDATE employees SET is_admin = ? WHERE id = ?')->execute([$isAdmin ? 1 : 0, $id]);
}
