<?php

declare(strict_types=1);

namespace App\Contracts\Permissions;

/**
 * Flat RBAC lookup — mirrors includes/rbac.php's has_permission()/
 * require_permission() contract from the existing PHP application.
 * No implicit inheritance: holding "content.manage" never implies
 * "content.view" (that exact gap was found and fixed by hand in the
 * existing app; ADR-004 locks the flat model in on purpose).
 */
interface PermissionRegistry
{
    /** All permission_key strings granted to the given role. */
    public function permissionsForRole(string $roleSlug): array;

    /** True only if the role has been granted this exact key. */
    public function roleHasPermission(string $roleSlug, string $permissionKey): bool;
}
