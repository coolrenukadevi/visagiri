<?php

declare(strict_types=1);

namespace App\Services\Permissions;

use App\Contracts\Permissions\PermissionRegistry;

/**
 * LOCAL DEVELOPMENT SCAFFOLDING — not the production permission store.
 *
 * PostgreSQL 18.x is unavailable in this environment (Architecture
 * Wave 0/1, see WAVE1_IMPLEMENTATION.md), so this seeds the *real*
 * role/permission inventory verified directly against the existing
 * PHP application's database during Wave 0 (source files under
 * database/seed-*.sql, cross-checked against a live query) as an
 * in-memory array, instead of a database-backed store.
 *
 * This is intentionally NOT the illustrative "module.view"/
 * "module.manage" convention used in early architecture drafts —
 * every key here matches what Wave 0 actually found. When PostgreSQL
 * 18.x is available, this class is replaced by a database-backed
 * implementation of the same PermissionRegistry contract; nothing
 * that depends on the contract needs to change.
 */
final class LocalArrayPermissionRegistry implements PermissionRegistry
{
    /** @var array<string, list<string>> role slug => granted permission_key list */
    private array $rolePermissions;

    public function __construct()
    {
        $all = self::allPermissionKeys();

        $this->rolePermissions = [
            // Super Admin: every permission, granted explicitly — never
            // a code-level bypass (verified in Wave 0: includes/rbac.php
            // has no hardcoded role-name shortcut).
            'super-admin' => $all,

            'admin' => array_values(array_diff($all, ['users.manage', 'settings.manage'])),

            'visa-consultant' => [
                'customers.view', 'visa.view', 'visa.manage',
                'general_enquiries.view', 'documents.upload',
                'enquiries.view', 'enquiries.manage',
                'forex.dashboard.view', 'forex.requests.view', 'forex.requests.manage', 'forex.documents.upload',
            ],

            'b2b-admin' => ['partners.view', 'partners.view_all', 'partners.manage'],
            'b2b-relationship-manager' => ['partners.view'],
            'b2b-visa-manager' => ['partners.view', 'partners.view_all'],
            'b2b-accounts-manager' => ['partners.view', 'partners.view_all'],
            'b2b-sales-manager' => ['partners.view', 'partners.view_all'],
            'b2b-support-executive' => ['partners.view', 'partners.view_all'],

            'forex-manager' => array_values(array_filter($all, static fn (string $k) => str_starts_with($k, 'forex.'))),
            'forex-executive' => [
                'forex.dashboard.view', 'forex.requests.view', 'forex.requests.view_all',
                'forex.requests.manage', 'forex.documents.upload', 'forex.quotations.create',
            ],
            'compliance-audit' => [
                'forex.dashboard.view', 'forex.requests.view', 'forex.requests.view_all',
                'forex.documents.verify', 'forex.compliance.view',
            ],
            'accounts' => [
                'forex.dashboard.view', 'forex.requests.view', 'forex.requests.view_all',
                'forex.payments.manage', 'forex.reports.view',
            ],

            'hr-admin' => array_values(array_filter($all, static fn (string $k) => str_starts_with($k, 'hrms.'))),
            'hr-executive' => [
                'hrms.dashboard.view', 'hrms.candidates.view', 'hrms.candidates.manage',
                'hrms.documents.download', 'hrms.interviews.manage',
            ],
        ];
    }

    public function permissionsForRole(string $roleSlug): array
    {
        return $this->rolePermissions[$roleSlug] ?? [];
    }

    public function roleHasPermission(string $roleSlug, string $permissionKey): bool
    {
        return in_array($permissionKey, $this->permissionsForRole($roleSlug), true);
    }

    /** @return list<string> the full verified permission_key inventory (Wave 0) */
    public static function allPermissionKeys(): array
    {
        return [
            'customers.view', 'customers.manage',
            'visa.view', 'visa.manage',
            'general_enquiries.view', 'general_enquiries.manage',
            'documents.upload', 'documents.verify',
            'content.manage', 'content.view',
            'users.manage', 'settings.manage', 'audit.view',
            'enquiries.view', 'enquiries.manage',
            'partners.view', 'partners.view_all', 'partners.manage',
            'b2b_travel_partners.view', 'b2b_travel_partners.manage', 'b2b_travel_partners.billing.view',
            'grievances.view', 'grievances.manage',
            'recycle_bin.manage', 'reminders.manage',
            'forex.dashboard.view', 'forex.requests.view', 'forex.requests.view_all', 'forex.requests.manage',
            'forex.documents.upload', 'forex.documents.verify',
            'forex.quotations.create', 'forex.quotations.approve',
            'forex.rates.manage', 'forex.payments.manage',
            'forex.delivery.manage', 'forex.delivery.override',
            'forex.compliance.view', 'forex.country_rules.manage', 'forex.reports.view',
            'hrms.dashboard.view', 'hrms.vacancies.manage',
            'hrms.candidates.view', 'hrms.candidates.manage', 'hrms.candidates.view_all',
            'hrms.documents.download', 'hrms.interviews.manage', 'hrms.reports.view',
        ];
    }
}
