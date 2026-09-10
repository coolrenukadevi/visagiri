<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;
use Spatie\Permission\PermissionRegistrar;

/**
 * Seeds the same 7 roles that exist in the current PHP/SQLite `roles` table
 * (see includes/crm-auth.php in the main site repo), plus each shipped
 * module's own Module.Feature.Action permission set (enquiries.* from
 * Milestone 2, attestation.* from Milestone 3, finance.* and b2b.* from
 * Milestone 4). Every future module adds its own permissions the same
 * way, without touching this file's shape.
 *
 * finance_executive is a net-new role (Finance has no legacy equivalent
 * to migrate 1:1, unlike the other 7): it can raise and pay invoices but
 * deliberately cannot approve them — four-eyes needs a second role.
 */
class RolesAndPermissionsSeeder extends Seeder
{
    public function run(): void
    {
        $permissions = [
            'dashboard.view',
            'enquiries.view.own',
            'enquiries.view.team',
            'enquiries.view.all',
            'enquiries.create',
            'enquiries.edit.own',
            'enquiries.edit.team',
            'enquiries.edit.all',
            'enquiries.assign',
            'enquiries.export',
            'enquiries.delete',
            'attestation.view.own',
            'attestation.view.team',
            'attestation.view.all',
            'attestation.create',
            'attestation.edit.own',
            'attestation.edit.team',
            'attestation.edit.all',
            'attestation.assign',
            'attestation.documents.upload',
            'attestation.documents.download',
            'attestation.delete',
            'finance.invoices.view.own',
            'finance.invoices.view.department',
            'finance.invoices.view.all',
            'finance.invoices.create',
            'finance.invoices.approve',
            'finance.payments.record',
            'finance.export',
            'b2b.partners.view',
            'b2b.partners.manage',
            'users.manage',
            'roles.manage',
            'audit.view',
        ];

        foreach ($permissions as $permission) {
            Permission::findOrCreate($permission);
        }

        app()->make(PermissionRegistrar::class)->forgetCachedPermissions();

        $roles = [
            'super_admin' => $permissions, // everything
            'admin' => [
                'dashboard.view', 'enquiries.view.all', 'enquiries.create', 'enquiries.edit.all',
                'enquiries.assign', 'enquiries.export', 'enquiries.delete',
                'attestation.view.all', 'attestation.create', 'attestation.edit.all', 'attestation.assign',
                'attestation.documents.upload', 'attestation.documents.download', 'attestation.delete',
                'finance.invoices.view.all', 'finance.invoices.create', 'finance.invoices.approve',
                'finance.payments.record', 'finance.export', 'b2b.partners.view', 'b2b.partners.manage',
                'users.manage', 'audit.view',
            ],
            'sales_manager' => [
                'dashboard.view', 'enquiries.view.team', 'enquiries.create', 'enquiries.edit.team',
                'enquiries.assign', 'enquiries.export',
                'attestation.view.team', 'attestation.create', 'attestation.edit.team', 'attestation.assign',
                'attestation.documents.upload', 'attestation.documents.download',
            ],
            'operations' => [
                'dashboard.view', 'enquiries.view.all', 'enquiries.export',
                'finance.invoices.view.department', 'finance.invoices.approve', 'finance.payments.record',
                'b2b.partners.view',
            ],
            'visa_consultant' => [
                'dashboard.view', 'enquiries.view.own', 'enquiries.create', 'enquiries.edit.own',
                'attestation.view.own', 'attestation.create', 'attestation.edit.own',
                'attestation.documents.upload', 'attestation.documents.download',
            ],
            'forex_consultant' => [
                'dashboard.view', 'enquiries.view.own', 'enquiries.create', 'enquiries.edit.own',
            ],
            'travel_consultant' => [
                'dashboard.view', 'enquiries.view.own', 'enquiries.create', 'enquiries.edit.own',
            ],
            'finance_executive' => [
                'dashboard.view', 'finance.invoices.view.own', 'finance.invoices.create', 'finance.payments.record',
            ],
        ];

        foreach ($roles as $roleName => $rolePermissions) {
            $role = Role::findOrCreate($roleName);
            $role->syncPermissions($rolePermissions);
        }
    }
}
