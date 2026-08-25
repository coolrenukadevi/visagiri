<?php
/**
 * Role-based permission helpers for the Forex module, matching the existing
 * boolean-helper-function convention in admin/includes/admin-auth.php
 * (admin_can_view_all(), admin_can_manage_users()) rather than introducing a
 * separate generic permissions table — the base CRM has no such table either.
 */
require_once __DIR__ . '/admin-auth.php';

/** True for roles that can see and manage every forex request, not just their own assignments. */
function forex_can_view_all(): bool
{
    return in_array(admin_role(), ['Super Admin', 'Forex Manager', 'Compliance / Audit', 'Accounts'], true);
}

function forex_can_create_request(): bool
{
    return in_array(admin_role(), ['Super Admin', 'Forex Manager', 'Forex Executive', 'Travel Consultant', 'Sales Manager'], true);
}

/** Master buy/sell rate maintenance — deliberately restricted per spec §12. */
function forex_can_manage_rates(): bool
{
    return in_array(admin_role(), ['Super Admin', 'Forex Manager'], true);
}

/** Drafting/preparing a quotation (not the same as approving one). */
function forex_can_prepare_quotation(): bool
{
    return in_array(admin_role(), ['Super Admin', 'Forex Manager', 'Forex Executive'], true);
}

function forex_can_approve_quotation(): bool
{
    return in_array(admin_role(), ['Super Admin', 'Forex Manager'], true);
}

function forex_can_verify_documents(): bool
{
    return in_array(admin_role(), ['Super Admin', 'Forex Manager', 'Forex Executive', 'Compliance / Audit'], true);
}

function forex_can_verify_compliance(): bool
{
    return in_array(admin_role(), ['Super Admin', 'Forex Manager', 'Compliance / Audit'], true);
}

function forex_can_manage_payments(): bool
{
    return in_array(admin_role(), ['Super Admin', 'Forex Manager', 'Accounts'], true);
}

function forex_can_manage_delivery(): bool
{
    return in_array(admin_role(), ['Super Admin', 'Forex Manager'], true);
}

/** Overriding a blocked delivery/compliance check — deliberately the narrowest permission in the module. */
function forex_can_override_compliance(): bool
{
    return in_array(admin_role(), ['Super Admin'], true);
}

function forex_can_export_audit(): bool
{
    return in_array(admin_role(), ['Super Admin', 'Forex Manager', 'Compliance / Audit'], true);
}

function forex_can_manage_settings(): bool
{
    return in_array(admin_role(), ['Super Admin', 'Forex Manager'], true);
}

function forex_can_manage_country_rules(): bool
{
    return in_array(admin_role(), ['Super Admin', 'Forex Manager', 'Compliance / Audit'], true);
}
