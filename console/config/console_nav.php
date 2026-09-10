<?php

// Full intended navigation from the Unified CMS architecture doc. Each item
// is only rendered for a user who actually holds `permission`. Items whose
// module has no routes built yet point at the shared "coming soon" screen so
// the true information architecture is visible without pretending the
// module works — Milestone 1 ships the shell and the permission engine,
// not the modules themselves (see the console/ README).

return [
    ['label' => 'Dashboard', 'route' => 'dashboard', 'icon' => 'home', 'permission' => 'dashboard.view', 'built' => true],
    ['label' => 'Sales CRM', 'route' => 'sales-crm.index', 'icon' => 'chart', 'permission' => 'enquiries.access', 'built' => true],
    ['label' => 'General Enquiry', 'route' => 'general-enquiry.index', 'icon' => 'inbox', 'permission' => 'enquiries.access', 'built' => true],
    ['label' => 'Attestation', 'route' => 'attestation.index', 'icon' => 'stamp', 'permission' => 'attestation.access', 'built' => true],
    ['label' => 'B2B Partners', 'route' => 'b2b.index', 'icon' => 'handshake', 'permission' => 'b2b.partners.view', 'built' => true],
    ['label' => 'HRMS', 'route' => 'hrms.index', 'icon' => 'users', 'permission' => 'hrms.access', 'built' => true],
    ['label' => 'Finance', 'route' => 'finance.index', 'icon' => 'currency', 'permission' => 'finance.access', 'built' => true],
    ['label' => 'Website CMS', 'route' => 'cms.index', 'icon' => 'document', 'permission' => 'cms.pages.view', 'built' => true],
    ['label' => 'Reports &amp; Analytics', 'route' => 'modules.comingSoon', 'params' => ['module' => 'reports'], 'icon' => 'bar-chart', 'permission' => 'enquiries.export', 'built' => false],
    ['label' => 'Audit Logs', 'route' => 'modules.comingSoon', 'params' => ['module' => 'audit-logs'], 'icon' => 'shield', 'permission' => 'audit.view', 'built' => false],
    ['label' => 'Administration', 'route' => 'modules.comingSoon', 'params' => ['module' => 'administration'], 'icon' => 'settings', 'permission' => 'users.manage', 'built' => false],
];
