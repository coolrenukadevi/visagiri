<?php

declare(strict_types=1);

namespace Tests\Unit\Permissions;

use App\Services\Permissions\LocalArrayPermissionRegistry;
use PHPUnit\Framework\Attributes\Test;
use Tests\TestCase;

final class LocalArrayPermissionRegistryTest extends TestCase
{
    #[Test]
    public function super_admin_holds_every_verified_permission(): void
    {
        $registry = new LocalArrayPermissionRegistry;

        foreach (LocalArrayPermissionRegistry::allPermissionKeys() as $key) {
            $this->assertTrue(
                $registry->roleHasPermission('super-admin', $key),
                "Super Admin should hold every permission, missing: {$key}",
            );
        }
    }

    #[Test]
    public function admin_holds_everything_except_users_manage_and_settings_manage(): void
    {
        $registry = new LocalArrayPermissionRegistry;

        $this->assertFalse($registry->roleHasPermission('admin', 'users.manage'));
        $this->assertFalse($registry->roleHasPermission('admin', 'settings.manage'));
        $this->assertTrue($registry->roleHasPermission('admin', 'customers.manage'));
        $this->assertTrue($registry->roleHasPermission('admin', 'content.manage'));
    }

    #[Test]
    public function permissions_are_flat_with_no_implicit_inheritance(): void
    {
        // ADR-004, locked: holding a "manage" key must never imply a
        // "view" key that wasn't explicitly granted. Visa Consultant
        // does not hold forex.rates.manage — confirm it doesn't
        // silently gain forex.rates.* just because it holds other
        // forex.* keys.
        $registry = new LocalArrayPermissionRegistry;

        $this->assertTrue($registry->roleHasPermission('visa-consultant', 'forex.requests.manage'));
        $this->assertFalse($registry->roleHasPermission('visa-consultant', 'forex.rates.manage'));
        $this->assertFalse($registry->roleHasPermission('visa-consultant', 'forex.requests.view_all'));
    }

    #[Test]
    public function b2b_relationship_manager_is_scoped_by_the_absence_of_view_all(): void
    {
        // Mirrors current_admin_b2b_scoped_to_assigned() in the
        // existing app: scoping is expressed as "lacks the view_all
        // key", not a separate boolean flag.
        $registry = new LocalArrayPermissionRegistry;

        $this->assertTrue($registry->roleHasPermission('b2b-relationship-manager', 'partners.view'));
        $this->assertFalse($registry->roleHasPermission('b2b-relationship-manager', 'partners.view_all'));
        $this->assertFalse($registry->roleHasPermission('b2b-relationship-manager', 'partners.manage'));
    }

    #[Test]
    public function unknown_role_has_no_permissions(): void
    {
        $registry = new LocalArrayPermissionRegistry;

        $this->assertSame([], $registry->permissionsForRole('does-not-exist'));
        $this->assertFalse($registry->roleHasPermission('does-not-exist', 'content.view'));
    }
}
