<?php
declare(strict_types=1);

// Proves the role-gate is wired end-to-end; the real admin panel is
// built in Phase 13. An unauthenticated request should redirect to
// /login/, and a non-staff account should get a 403.
require_role(['super_admin', 'admin']);

render_scaffold_page(
    title: 'Admin',
    description: 'Visagiri admin panel.',
    canonicalPath: '/admin/',
    handlerPath: 'admin/index.php',
    plannedInPhase: 'Phase 13 — Admin panel'
);
