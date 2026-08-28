<?php
/**
 * Authentication + role-based access control.
 */

declare(strict_types=1);

const DASHBOARD_BY_ROLE = [
    'customer'    => '/customer/dashboard',
    'partner'     => '/partner/dashboard',
    'employee'    => '/employee/dashboard',
    'hr'          => '/hrms/dashboard',
    'admin'       => '/admin/dashboard',
    'super_admin' => '/super-admin/dashboard',
];

/** Attempt to authenticate a user against a specific login "surface" (role group). */
function attempt_login(PDO $pdo, string $identifier, string $password, string $roleGroup): array
{
    $identifier = sanitize_input($identifier);

    // roleGroup: customer | partner | employee | hr (hrms uses the hr role)
    $allowedRoles = match ($roleGroup) {
        'customer' => ['customer'],
        'partner'  => ['partner'],
        'employee' => ['employee', 'admin', 'super_admin'],
        'hr'       => ['hr', 'admin', 'super_admin'],
        default    => [],
    };

    if (empty($allowedRoles)) {
        return ['ok' => false, 'error' => 'Invalid login type.'];
    }

    if (recent_failed_attempts($pdo, $identifier) >= LOGIN_MAX_ATTEMPTS) {
        return ['ok' => false, 'error' => 'Too many failed attempts. Please try again in ' . LOGIN_LOCKOUT_MINUTES . ' minutes or reset your password.'];
    }

    $placeholders = implode(',', array_fill(0, count($allowedRoles), '?'));
    $stmt = $pdo->prepare(
        "SELECT u.*, r.slug AS role_slug FROM users u
         JOIN roles r ON r.id = u.role_id
         WHERE (u.email = ? OR u.mobile = ?) AND r.slug IN ($placeholders)
         LIMIT 1"
    );
    $stmt->execute(array_merge([$identifier, $identifier], $allowedRoles));
    $user = $stmt->fetch();

    if (!$user || !password_verify($password, $user['password_hash'])) {
        record_login_attempt($pdo, $identifier, $roleGroup, false);
        return ['ok' => false, 'error' => 'Invalid credentials.'];
    }

    if ($user['status'] !== 'active') {
        record_login_attempt($pdo, $identifier, $roleGroup, false);
        return ['ok' => false, 'error' => 'This account is not active. Please contact support.'];
    }

    if (!empty($user['locked_until']) && strtotime($user['locked_until']) > time()) {
        return ['ok' => false, 'error' => 'Account temporarily locked. Please try again later.'];
    }

    record_login_attempt($pdo, $identifier, $roleGroup, true);

    // Successful login: regenerate the session ID to prevent fixation.
    session_regenerate_id(true);

    $_SESSION['user'] = [
        'id'       => (int) $user['id'],
        'uuid'     => $user['uuid'],
        'name'     => $user['full_name'],
        'email'    => $user['email'],
        'role'     => $user['role_slug'],
    ];

    $update = $pdo->prepare(
        'UPDATE users SET last_login_at = NOW(), last_login_ip = :ip, failed_login_count = 0 WHERE id = :id'
    );
    $update->execute(['ip' => client_ip(), 'id' => $user['id']]);

    return ['ok' => true, 'role' => $user['role_slug'], 'redirect' => DASHBOARD_BY_ROLE[$user['role_slug']] ?? '/'];
}

function current_user(): ?array
{
    return $_SESSION['user'] ?? null;
}

function is_logged_in(): bool
{
    return current_user() !== null;
}

/** Require one of the given roles; redirects to home (with login prompt) otherwise. */
function require_role(array $roles): array
{
    $user = current_user();
    if (!$user || !in_array($user['role'], $roles, true)) {
        header('Location: /?login=required');
        exit;
    }
    return $user;
}

function logout_user(): void
{
    $_SESSION = [];
    if (ini_get('session.use_cookies')) {
        $params = session_get_cookie_params();
        setcookie(session_name(), '', time() - 42000, $params['path'], $params['domain'], $params['secure'], $params['httponly']);
    }
    session_destroy();
}
