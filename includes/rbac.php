<?php
declare(strict_types=1);

/**
 * Role-based access control. Enforced server-side on every admin page
 * that needs it (require_permission() at the top of the file, before
 * any output) — never relies on hiding a sidebar link as the actual
 * security boundary.
 */

/** All permission keys granted to the current admin's role, cached per request. */
function current_admin_permissions(): array
{
    static $cache = null;
    if ($cache !== null) {
        return $cache;
    }

    $admin = current_admin();
    if ($admin === null || empty($admin['role_id'])) {
        $cache = [];
        return $cache;
    }

    $stmt = db()->prepare(
        'SELECT p.permission_key FROM role_permissions rp
         JOIN permissions p ON p.id = rp.permission_id
         WHERE rp.role_id = :role_id'
    );
    $stmt->execute(['role_id' => $admin['role_id']]);
    $cache = $stmt->fetchAll(PDO::FETCH_COLUMN);
    return $cache;
}

function has_permission(string $key): bool
{
    return in_array($key, current_admin_permissions(), true);
}

/** Aborts with 403 if the current admin lacks the given permission. Call after require_admin_login(). */
function require_permission(string $key): void
{
    if (!has_permission($key)) {
        http_response_code(403);
        exit('You do not have permission to access this page.');
    }
}

/**
 * True if the "visa consultant" scoping rule applies to the current
 * admin: consultants only see enquiries/applications assigned to
 * them, everyone else with view access sees everything. Checked at
 * the query level by callers (WHERE assigned_user = ... when this is
 * true), not just used to hide rows client-side.
 */
function current_admin_scoped_to_assigned(): bool
{
    $admin = current_admin();
    return $admin !== null && ($admin['role_slug'] ?? null) === 'visa-consultant';
}

/**
 * Same idea as current_admin_scoped_to_assigned(), for the HRMS
 * recruitment module: an HR Executive only sees candidates assigned
 * to them (no hrms.candidates.view_all permission); HR Admin and
 * Super Admin see everything. Checked at the query level by every
 * HRMS admin page, not just used to hide rows.
 */
function current_admin_hrms_scoped_to_assigned(): bool
{
    return !has_permission('hrms.candidates.view_all');
}

/**
 * Forex module scoping — the "Sales/Travel Consultant" role from the
 * spec is the existing visa-consultant role reused (see
 * database/seed-forex.sql), so it shares the exact same scoping rule
 * as current_admin_scoped_to_assigned() rather than needing its own.
 */
function current_admin_forex_scoped_to_assigned(): bool
{
    return !has_permission('forex.requests.view_all');
}
