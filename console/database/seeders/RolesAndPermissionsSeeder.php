<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;
use Spatie\Permission\PermissionRegistrar;

/**
 * Seeds the same 7 roles that exist in the current PHP/SQLite `roles` table
 * (see includes/crm-auth.php in the main site repo), plus a starter
 * Module.Feature.Action permission set for the General Enquiry / CRM
 * module — the first module confirmed for Milestone 2. Every other module
 * in the architecture doc adds its own permissions the same way, without
 * touching this file's shape.
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
            'enquiries.assign',
            'enquiries.export',
            'enquiries.delete',
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
                'dashboard.view', 'enquiries.view.all', 'enquiries.create', 'enquiries.edit.team',
                'enquiries.assign', 'enquiries.export', 'enquiries.delete', 'users.manage', 'audit.view',
            ],
            'sales_manager' => [
                'dashboard.view', 'enquiries.view.team', 'enquiries.create', 'enquiries.edit.team',
                'enquiries.assign', 'enquiries.export',
            ],
            'operations' => [
                'dashboard.view', 'enquiries.view.all', 'enquiries.export',
            ],
            'visa_consultant' => [
                'dashboard.view', 'enquiries.view.own', 'enquiries.create', 'enquiries.edit.own',
            ],
            'forex_consultant' => [
                'dashboard.view', 'enquiries.view.own', 'enquiries.create', 'enquiries.edit.own',
            ],
            'travel_consultant' => [
                'dashboard.view', 'enquiries.view.own', 'enquiries.create', 'enquiries.edit.own',
            ],
        ];

        foreach ($roles as $roleName => $rolePermissions) {
            $role = Role::findOrCreate($roleName);
            $role->syncPermissions($rolePermissions);
        }
    }
}
