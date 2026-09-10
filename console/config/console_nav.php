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
    ['label' => 'B2B Partners', 'route' => 'modules.comingSoon', 'params' => ['module' => 'b2b-partners'], 'icon' => 'handshake', 'permission' => 'enquiries.view.all', 'built' => false],
    ['label' => 'HRMS', 'route' => 'modules.comingSoon', 'params' => ['module' => 'hrms'], 'icon' => 'users', 'permission' => 'users.manage', 'built' => false],
    ['label' => 'Finance', 'route' => 'modules.comingSoon', 'params' => ['module' => 'finance'], 'icon' => 'currency', 'permission' => 'enquiries.view.all', 'built' => false],
    ['label' => 'Website CMS', 'route' => 'modules.comingSoon', 'params' => ['module' => 'website-cms'], 'icon' => 'document', 'permission' => 'users.manage', 'built' => false],
    ['label' => 'Reports &amp; Analytics', 'route' => 'modules.comingSoon', 'params' => ['module' => 'reports'], 'icon' => 'bar-chart', 'permission' => 'enquiries.export', 'built' => false],
    ['label' => 'Audit Logs', 'route' => 'modules.comingSoon', 'params' => ['module' => 'audit-logs'], 'icon' => 'shield', 'permission' => 'audit.view', 'built' => false],
    ['label' => 'Administration', 'route' => 'modules.comingSoon', 'params' => ['module' => 'administration'], 'icon' => 'settings', 'permission' => 'users.manage', 'built' => false],
];
