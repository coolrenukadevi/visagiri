<?php
/**
 * Sessions, the user store, and CSRF for Convercession sign-in.
 *
 * Storage is SQLite (pdo_sqlite ships with every mainstream PHP build and needs
 * no server), in /cache/auth.sqlite — a directory .htaccess already denies to
 * the web. Two tables:
 *
 *   users     one row per person
 *   identities  one row per (provider, provider_user_id) -> user
 *
 * The split matters: signing in with Google and later with Facebook on the same
 * verified email links to ONE user rather than silently creating a second
 * account with the same inbox. Linking is only ever done on a provider-VERIFIED
 * email — an unverified one is attacker-controllable, and trusting it would let
 * anyone claim an existing account by registering that address elsewhere.
 *
 * Nothing here trusts the browser: the session holds a user id, and every
 * request re-reads the user from the database.
 */
declare(strict_types=1);

require_once __DIR__ . '/../includes/config.php';

const AUTH_DB_FILE      = 'auth.sqlite';
const AUTH_SESSION_NAME = 'cvsession';
/** Re-issue the session id this often, to cap the value of a stolen cookie. */
const AUTH_REGENERATE_AFTER = 1800;   // 30 min
/** Absolute sign-in lifetime. After this the user signs in again. */
const AUTH_MAX_LIFETIME     = 30 * 86400;

// ---------------------------------------------------------------------
// Session
// ---------------------------------------------------------------------

function auth_is_https(): bool
{
    return (($_SERVER['HTTPS'] ?? '') !== '' && ($_SERVER['HTTPS'] ?? '') !== 'off')
        || (($_SERVER['HTTP_X_FORWARDED_PROTO'] ?? '') === 'https')
        || ((int) ($_SERVER['SERVER_PORT'] ?? 0) === 443);
}

/**
 * Starts the session with hardened cookie flags.
 *
 * SameSite=Lax rather than Strict: the OAuth callback is a cross-site
 * top-level GET back from Google/Facebook/X, and Strict would drop the cookie
 * on exactly that request — losing the `state` we need to verify. Lax still
 * blocks the cross-site POST/subresource cases CSRF actually uses.
 */
function auth_session_start(): void
{
    if (session_status() === PHP_SESSION_ACTIVE) {
        return;
    }
    if (headers_sent($file, $line)) {
        log_error("auth: headers already sent at {$file}:{$line}; session not started");
        return;
    }
    session_name(AUTH_SESSION_NAME);
    session_set_cookie_params([
        'lifetime' => 0,            // browser session; the DB holds the real lifetime
        'path'     => '/',
        'secure'   => auth_is_https(),
        'httponly' => true,         // never readable from JS
        'samesite' => 'Lax',
    ]);
    session_start();

    $now = time();
    // Expire an absolutely-old session even if it is still being used.
    if (isset($_SESSION['created_at']) && $now - (int) $_SESSION['created_at'] > AUTH_MAX_LIFETIME) {
        auth_logout();
        session_start();
    }
    $_SESSION['created_at'] ??= $now;
    $_SESSION['rotated_at'] ??= $now;
    if ($now - (int) $_SESSION['rotated_at'] > AUTH_REGENERATE_AFTER) {
        session_regenerate_id(true);
        $_SESSION['rotated_at'] = $now;
    }
}

// ---------------------------------------------------------------------
// Store
// ---------------------------------------------------------------------

function auth_db(): ?PDO
{
    static $pdo = null;
    static $tried = false;
    if ($tried) {
        return $pdo;
    }
    $tried = true;

    if (!in_array('sqlite', PDO::getAvailableDrivers(), true)) {
        log_error('auth: pdo_sqlite is not available; sign-in disabled');
        return null;
    }
    if (!is_dir(CACHE_PATH) && !@mkdir(CACHE_PATH, 0775, true) && !is_dir(CACHE_PATH)) {
        log_error('auth: cannot create ' . CACHE_PATH);
        return null;
    }
    try {
        $pdo = new PDO('sqlite:' . CACHE_PATH . '/' . AUTH_DB_FILE, null, null, [
            PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES   => false,
        ]);
        // WAL keeps a read during a write from blocking, which matters as soon
        // as more than one visitor signs in at the same moment.
        $pdo->exec('PRAGMA journal_mode = WAL');
        $pdo->exec('PRAGMA foreign_keys = ON');
        auth_migrate($pdo);
        @chmod(CACHE_PATH . '/' . AUTH_DB_FILE, 0640);
    } catch (Throwable $e) {
        log_error('auth: database unavailable — ' . $e->getMessage());
        $pdo = null;
    }
    return $pdo;
}

function auth_migrate(PDO $pdo): void
{
    $pdo->exec("
        CREATE TABLE IF NOT EXISTS users (
            id              INTEGER PRIMARY KEY AUTOINCREMENT,
            email           TEXT UNIQUE,
            email_verified  INTEGER NOT NULL DEFAULT 0,
            name            TEXT NOT NULL DEFAULT '',
            avatar_url      TEXT NOT NULL DEFAULT '',
            created_at      INTEGER NOT NULL,
            last_login_at   INTEGER NOT NULL
        )");
    $pdo->exec("
        CREATE TABLE IF NOT EXISTS identities (
            id               INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id          INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
            provider         TEXT NOT NULL,
            provider_user_id TEXT NOT NULL,
            email            TEXT,
            created_at       INTEGER NOT NULL,
            UNIQUE (provider, provider_user_id)
        )");
    $pdo->exec('CREATE INDEX IF NOT EXISTS idx_identities_user ON identities(user_id)');
}

/**
 * Finds or creates the user behind an OAuth profile, and links the identity.
 *
 * @param array{provider:string,id:string,email:?string,email_verified:bool,name:string,avatar:string} $p
 * @return array{0:?array,1:string} [user, outcome] — outcome is one of
 *         'signed_in' | 'linked' | 'created' | '' (on failure)
 */
function auth_upsert_user(array $p): array
{
    $pdo = auth_db();
    if (!$pdo) {
        return [null, ''];
    }
    $now = time();
    $email = $p['email'] !== null && $p['email'] !== '' ? mb_strtolower(trim($p['email'])) : null;

    try {
        $pdo->beginTransaction();

        // 1. Known identity -> that user, always. (An identity is the strongest
        //    signal we have; the email on it may since have changed upstream.)
        $st = $pdo->prepare('SELECT user_id FROM identities WHERE provider = ? AND provider_user_id = ?');
        $st->execute([$p['provider'], $p['id']]);
        $userId = $st->fetchColumn();
        $outcome = 'signed_in';

        if ($userId === false) {
            // 2. Same VERIFIED email as an existing account -> link, don't duplicate.
            //    Unverified emails are deliberately not matched: they are
            //    attacker-supplied and would be an account-takeover path.
            $userId = false;
            if ($email !== null && $p['email_verified']) {
                $st = $pdo->prepare('SELECT id FROM users WHERE email = ? AND email_verified = 1');
                $st->execute([$email]);
                $userId = $st->fetchColumn();
            }
            if ($userId === false) {
                $st = $pdo->prepare(
                    'INSERT INTO users (email, email_verified, name, avatar_url, created_at, last_login_at)
                     VALUES (?, ?, ?, ?, ?, ?)'
                );
                // An UNVERIFIED email is never written to the user row. It is
                // attacker-supplied, users.email is UNIQUE, and storing it
                // would both squat on an address the person may not own and
                // make this insert fail whenever a real account already holds
                // it. The raw value is still kept on the identity row below.
                $st->execute([
                    $p['email_verified'] ? $email : null,
                    $p['email_verified'] ? 1 : 0,
                    $p['name'], $p['avatar'], $now, $now,
                ]);
                $userId = (int) $pdo->lastInsertId();
                $outcome = 'created';
            } else {
                $outcome = 'linked';
            }
            $st = $pdo->prepare(
                'INSERT INTO identities (user_id, provider, provider_user_id, email, created_at)
                 VALUES (?, ?, ?, ?, ?)'
            );
            $st->execute([$userId, $p['provider'], $p['id'], $email, $now]);
        }

        // Refresh the display fields, but never blank out something we already
        // have because this provider returned less than the last one did.
        $st = $pdo->prepare(
            "UPDATE users SET
                 last_login_at = ?,
                 name       = CASE WHEN ? <> '' THEN ? ELSE name END,
                 avatar_url = CASE WHEN ? <> '' THEN ? ELSE avatar_url END
             WHERE id = ?"
        );
        $st->execute([$now, $p['name'], $p['name'], $p['avatar'], $p['avatar'], $userId]);

        // Adopt a verified email if the account has none recorded yet.
        if ($email !== null && $p['email_verified']) {
            $st = $pdo->prepare(
                'UPDATE users SET email = ?, email_verified = 1
                 WHERE id = ? AND (email IS NULL OR email_verified = 0)'
            );
            try {
                $st->execute([$email, $userId]);
            } catch (PDOException $e) {
                // UNIQUE(email) collision: another account already owns it.
                // Keep this account as-is rather than merging on our own.
                log_error('auth: email already claimed, left unset for user ' . $userId);
            }
        }

        $pdo->commit();
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) {
            $pdo->rollBack();
        }
        log_error('auth: upsert failed — ' . $e->getMessage());
        return [null, ''];
    }

    return [auth_find_user((int) $userId), $outcome];
}

function auth_find_user(int $id): ?array
{
    $pdo = auth_db();
    if (!$pdo) {
        return null;
    }
    $st = $pdo->prepare('SELECT * FROM users WHERE id = ?');
    $st->execute([$id]);
    $row = $st->fetch();
    return $row ?: null;
}

/** Providers already linked to a user, for the account page. */
function auth_user_identities(int $userId): array
{
    $pdo = auth_db();
    if (!$pdo) {
        return [];
    }
    $st = $pdo->prepare('SELECT provider, email, created_at FROM identities WHERE user_id = ? ORDER BY created_at');
    $st->execute([$userId]);
    return $st->fetchAll();
}

// ---------------------------------------------------------------------
// Sign in / out
// ---------------------------------------------------------------------

function auth_login(array $user): void
{
    auth_session_start();
    // New privilege level, new session id — closes session fixation, where an
    // attacker plants a known id before sign-in and reuses it after.
    session_regenerate_id(true);
    $_SESSION['user_id']    = (int) $user['id'];
    $_SESSION['created_at'] = time();
    $_SESSION['rotated_at'] = time();
}

function auth_logout(): void
{
    if (session_status() !== PHP_SESSION_ACTIVE) {
        auth_session_start();
    }
    $_SESSION = [];
    if (ini_get('session.use_cookies') && !headers_sent()) {
        $p = session_get_cookie_params();
        setcookie(session_name(), '', [
            'expires'  => time() - 42000,
            'path'     => $p['path'],
            'domain'   => $p['domain'],
            'secure'   => $p['secure'],
            'httponly' => $p['httponly'],
            'samesite' => 'Lax',
        ]);
    }
    session_destroy();
}

/** The signed-in user, or null. Re-read from the database on every request. */
function auth_user(): ?array
{
    static $cached = false;
    static $user = null;
    if ($cached) {
        return $user;
    }
    $cached = true;
    auth_session_start();
    $id = $_SESSION['user_id'] ?? null;
    if (!$id) {
        return null;
    }
    $user = auth_find_user((int) $id);
    if (!$user) {
        // Account deleted underneath the session — drop the session too.
        auth_logout();
    }
    return $user;
}

/** Send an anonymous visitor to sign in, then back to where they were. */
function auth_require_login(string $returnTo): void
{
    if (auth_user()) {
        return;
    }
    header('Location: ' . url('/login') . '?next=' . rawurlencode(auth_safe_next($returnTo)), true, 302);
    exit;
}

/**
 * Only ever redirect to our OWN paths.
 *
 * "//evil.com" and "https://evil.com" are both absolute to a browser, so a
 * naive `startsWith('/')` check is an open redirect — the classic way a
 * phishing page gets to wear your domain in the link.
 */
function auth_safe_next(?string $next): string
{
    $next = trim((string) $next);
    if ($next === '' || $next[0] !== '/' || str_starts_with($next, '//') || str_contains($next, "\\")) {
        return '/account';
    }
    if (preg_match('#^/[a-z0-9\-/]*(\?[^\#]*)?$#i', $next) !== 1) {
        return '/account';
    }
    return $next;
}

// ---------------------------------------------------------------------
// CSRF (for our own forms — the OAuth `state` value is separate, in oauth.php)
// ---------------------------------------------------------------------

function auth_csrf_token(): string
{
    auth_session_start();
    if (empty($_SESSION['csrf'])) {
        $_SESSION['csrf'] = bin2hex(random_bytes(32));
    }
    return $_SESSION['csrf'];
}

function auth_csrf_valid(?string $token): bool
{
    auth_session_start();
    return is_string($token)
        && !empty($_SESSION['csrf'])
        && hash_equals($_SESSION['csrf'], $token);
}

/** First name, or a friendly fallback — used in the header and greetings. */
function auth_display_name(?array $user): string
{
    if (!$user) {
        return '';
    }
    $name = trim((string) ($user['name'] ?? ''));
    if ($name !== '') {
        return explode(' ', $name)[0];
    }
    $email = (string) ($user['email'] ?? '');
    return $email !== '' ? explode('@', $email)[0] : 'Account';
}
