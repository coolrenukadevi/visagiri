<?php
declare(strict_types=1);

// Proves the auth guard is wired end-to-end; the real dashboard UI is
// built in Phase 10. An unauthenticated request should redirect to
// /login/ rather than reach the stub below.
require_login();

render_scaffold_page(
    title: 'Dashboard',
    description: 'Manage your Visagiri visa applications, documents, and payments.',
    canonicalPath: '/dashboard/',
    handlerPath: 'dashboard/index.php',
    plannedInPhase: 'Phase 10 — Customer dashboard'
);
