<?php
/**
 * Role-based permission helpers for the B2B Partner Portal module, matching
 * the existing boolean-helper-function convention (admin_can_view_all(),
 * forex_can_*()) rather than introducing a separate generic permissions
 * table — the base CRM has no such table either.
 *
 * Role mapping per spec §23: "Visa Manager" -> existing 'Visa Consultant'
 * role, "Accounts Manager" -> existing 'Accounts' role, "Sales Manager" ->
 * existing 'Sales Manager' role (all functionally identical to roles that
 * already exist, so no duplicate role was added for these three).
 */
require_once __DIR__ . '/admin-auth.php';

/** True for roles that can see and manage every partner, not just their own assignments. */
function b2b_can_view_all(): bool
{
    return in_array(admin_role(), ['Super Admin', 'B2B Admin', 'Sales Manager', 'Accounts'], true);
}

/** Enrollment review: approve / reject / request info / suspend / deactivate a partner application. */
function b2b_can_manage_enrollment(): bool
{
    return in_array(admin_role(), ['Super Admin', 'B2B Admin'], true);
}

/** Verifying partner KYC documents (not the same as approving the whole application). */
function b2b_can_verify_documents(): bool
{
    return in_array(admin_role(), ['Super Admin', 'B2B Admin', 'B2B Relationship Manager'], true);
}

function b2b_can_manage_quotations(): bool
{
    return in_array(admin_role(), ['Super Admin', 'B2B Admin', 'B2B Relationship Manager', 'Visa Consultant'], true);
}

function b2b_can_approve_quotation(): bool
{
    return in_array(admin_role(), ['Super Admin', 'B2B Admin'], true);
}

/** Invoices, payments and wallet — financial data, deliberately narrower than general partner access. */
function b2b_can_manage_finance(): bool
{
    return in_array(admin_role(), ['Super Admin', 'B2B Admin', 'Accounts'], true);
}

/** Gate for showing revenue/wallet/invoice figures anywhere in the UI — spec §23: never expose financial data to roles without permission. */
function b2b_can_view_financials(): bool
{
    return in_array(admin_role(), ['Super Admin', 'B2B Admin', 'Accounts'], true);
}

function b2b_can_manage_tiers_pricing(): bool
{
    return in_array(admin_role(), ['Super Admin', 'B2B Admin'], true);
}

function b2b_can_assign_manager(): bool
{
    return in_array(admin_role(), ['Super Admin', 'B2B Admin'], true);
}

function b2b_can_communicate(): bool
{
    return in_array(admin_role(), ['Super Admin', 'B2B Admin', 'B2B Relationship Manager', 'Support Executive'], true);
}

function b2b_can_manage_announcements(): bool
{
    return in_array(admin_role(), ['Super Admin', 'B2B Admin'], true);
}

function b2b_can_export_audit(): bool
{
    return in_array(admin_role(), ['Super Admin', 'B2B Admin', 'Compliance / Audit'], true);
}

function b2b_can_manage_settings(): bool
{
    return in_array(admin_role(), ['Super Admin', 'B2B Admin'], true);
}

/**
 * SQL fragment + bound value for scoping a partners query to "only my
 * assigned partners" when the current role can't view all — mirrors the
 * $scopeSql pattern in forex-requests.php. Usage:
 *   [$sql, $params] = b2b_scope_sql();
 *   $stmt = $pdo->prepare("SELECT ... FROM b2b_partners WHERE archived_at IS NULL $sql");
 *   $stmt->execute($params);
 */
function b2b_scope_sql(): array
{
    if (b2b_can_view_all()) {
        return ['', []];
    }
    return [' AND assigned_manager_id = :me', ['me' => admin_user_id()]];
}
