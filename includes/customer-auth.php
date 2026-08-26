<?php
declare(strict_types=1);

/**
 * Customer self-service auth. Mirrors includes/auth.php's admin
 * pattern (same hash_password()/verify_password()/login_rate_limited()
 * helpers, reused as-is) but scoped to the `customers` table via its
 * own $_SESSION key ('customer_id') so a browser can never be
 * ambiguously "logged in as both admin and customer" through session
 * key collision. Customers carry no RBAC role — every customer sees
 * only their own records, enforced by scoping every query to
 * current_customer_id(), never by a permission check.
 */

function current_customer_id(): ?int
{
    return $_SESSION['customer_id'] ?? null;
}

function current_customer(): ?array
{
    $customerId = current_customer_id();
    if ($customerId === null) {
        return null;
    }

    static $cached = null;
    if ($cached !== null && $cached['id'] === $customerId) {
        return $cached;
    }

    $stmt = db()->prepare(
        "SELECT * FROM customers WHERE id = :id AND status = 'active' AND deleted_at IS NULL"
    );
    $stmt->execute(['id' => $customerId]);
    $customer = $stmt->fetch();

    $cached = $customer ?: null;
    return $cached;
}

function is_customer_logged_in(): bool
{
    return current_customer() !== null;
}

function require_customer_login(): void
{
    if (!is_customer_logged_in()) {
        $_SESSION['customer_redirect_after_login'] = $_SERVER['REQUEST_URI'] ?? '/dashboard/';
        redirect('/login/');
    }
}

function log_in_customer(int $customerId): void
{
    session_regenerate_id(true);
    $_SESSION['customer_id'] = $customerId;
}

/**
 * Issues a persistent "remember me" cookie: a random token whose hash
 * (never the plaintext) is stored on the customer's row, and an
 * expiry the DB itself enforces on the next lookup. Deliberately not
 * just extending the session cookie's browser-side expiry — PHP's
 * default file-based session store still garbage-collects the
 * server-side session after session.gc_maxlifetime regardless of what
 * expiry the cookie claims, so that approach silently stops working
 * long before 30 days. This survives that because resume_customer_
 * session_from_remember_cookie() re-authenticates from the DB token,
 * not from the old session.
 */
function remember_customer(int $customerId): void
{
    $token = bin2hex(random_bytes(32));
    $stmt = db()->prepare(
        'UPDATE customers SET remember_token_hash = :hash, remember_token_expires_at = :expires WHERE id = :id'
    );
    $stmt->execute([
        'hash' => hash('sha256', $token),
        'expires' => date('Y-m-d H:i:s', time() + 60 * 60 * 24 * 30),
        'id' => $customerId,
    ]);

    setcookie('visagiri_remember', $customerId . ':' . $token, [
        'expires' => time() + 60 * 60 * 24 * 30,
        'path' => '/',
        'secure' => SESSION_SECURE_COOKIE,
        'httponly' => true,
        'samesite' => 'Lax',
    ]);
}

/**
 * Called early on every request (see public/index.php). If there's no
 * active session but a valid remember-me cookie, re-establishes the
 * session from it. No-op if the customer is already logged in or no
 * cookie is present.
 */
function resume_customer_session_from_remember_cookie(): void
{
    if (is_customer_logged_in()) {
        return;
    }

    $cookie = $_COOKIE['visagiri_remember'] ?? '';
    if (!str_contains($cookie, ':')) {
        return;
    }

    [$customerId, $token] = explode(':', $cookie, 2);
    if (!ctype_digit($customerId)) {
        return;
    }

    $stmt = db()->prepare(
        "SELECT id, remember_token_hash FROM customers
         WHERE id = :id AND remember_token_expires_at IS NOT NULL AND remember_token_expires_at > NOW()
           AND status = 'active' AND deleted_at IS NULL"
    );
    $stmt->execute(['id' => (int) $customerId]);
    $customer = $stmt->fetch();

    if ($customer && hash_equals($customer['remember_token_hash'], hash('sha256', $token))) {
        log_in_customer((int) $customer['id']);
    }
}

function forget_customer_remember_cookie(?int $customerId): void
{
    if ($customerId !== null) {
        $stmt = db()->prepare('UPDATE customers SET remember_token_hash = NULL, remember_token_expires_at = NULL WHERE id = :id');
        $stmt->execute(['id' => $customerId]);
    }
    setcookie('visagiri_remember', '', ['expires' => time() - 42000, 'path' => '/']);
}

function log_out_customer(): void
{
    forget_customer_remember_cookie(current_customer_id());
    unset($_SESSION['customer_id']);
}

/**
 * 1-hour, single-use password reset token. Only the token's hash is
 * stored — a database read alone can never be used to reset a
 * password. No email-sending integration exists in this project (see
 * AUDIT.md); the caller is responsible for surfacing the reset link.
 */
function create_customer_password_reset_token(int $customerId): string
{
    $token = bin2hex(random_bytes(32));
    $stmt = db()->prepare(
        'UPDATE customers SET password_reset_token_hash = :hash, password_reset_expires_at = :expires WHERE id = :id'
    );
    $stmt->execute([
        'hash' => hash('sha256', $token),
        'expires' => date('Y-m-d H:i:s', time() + 3600),
        'id' => $customerId,
    ]);
    return $token;
}

function verify_customer_password_reset_token(string $token): ?array
{
    $stmt = db()->prepare(
        "SELECT * FROM customers
         WHERE password_reset_token_hash = :hash
           AND password_reset_expires_at IS NOT NULL
           AND password_reset_expires_at > NOW()
           AND deleted_at IS NULL"
    );
    $stmt->execute(['hash' => hash('sha256', $token)]);
    $customer = $stmt->fetch();
    return $customer ?: null;
}

function reset_customer_password(int $customerId, string $newPlainPassword): void
{
    $stmt = db()->prepare(
        'UPDATE customers SET password_hash = :hash, password_reset_token_hash = NULL, password_reset_expires_at = NULL WHERE id = :id'
    );
    $stmt->execute(['hash' => hash_password($newPlainPassword), 'id' => $customerId]);
}
