<?php
declare(strict_types=1);

require_once __DIR__ . '/db.php';

function crm_login(string $email, string $password): bool
{
    $stmt = db()->prepare(
        'SELECT u.id, u.name, u.email, u.password_hash, u.status, r.slug AS role_slug, r.name AS role_name
         FROM users u JOIN roles r ON r.id = u.role_id WHERE u.email = ?'
    );
    $stmt->execute([strtolower(trim($email))]);
    $user = $stmt->fetch();

    if (!$user || $user['status'] !== 'active' || !password_verify($password, $user['password_hash'])) {
        return false;
    }

    session_regenerate_id(true);
    $_SESSION['crm_user'] = [
        'id' => (int) $user['id'],
        'name' => $user['name'],
        'email' => $user['email'],
        'role_slug' => $user['role_slug'],
        'role_name' => $user['role_name'],
    ];

    crm_audit_log('login', 'user', (int) $user['id']);
    return true;
}

function crm_current_user(): ?array
{
    return $_SESSION['crm_user'] ?? null;
}

function crm_require_login(): void
{
    if (!crm_current_user()) {
        header('Location: ' . url('crm/login.php'));
        exit;
    }
}

/** Roles that can see and act on every enquiry regardless of service type. */
function crm_has_full_access(string $role): bool
{
    return in_array($role, ['super_admin', 'admin', 'sales_manager', 'operations'], true);
}

/** Service types a given role is scoped to; null means unrestricted. */
function crm_visible_service_types(string $role): ?array
{
    return match ($role) {
        'visa_consultant' => ['visa'],
        'forex_consultant' => ['forex'],
        'travel_consultant' => ['hotel', 'flight', 'tour', 'insurance', 'general', 'corporate'],
        default => null,
    };
}

function crm_audit_log(string $action, ?string $entityType = null, ?int $entityId = null, array $meta = []): void
{
    $userId = crm_current_user()['id'] ?? null;
    db()->prepare('INSERT INTO audit_logs (user_id, action, entity_type, entity_id, meta) VALUES (?, ?, ?, ?, ?)')
        ->execute([$userId, $action, $entityType, $entityId, $meta ? json_encode($meta) : null]);
}
