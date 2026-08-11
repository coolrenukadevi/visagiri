<?php
declare(strict_types=1);

// Proves the auth guard is wired end-to-end; the real dashboard UI is
// built in Phase 10. An unauthenticated request should redirect to
// /login/ rather than reach the stub below.
require_login();

render_scaffold_stub('dashboard/index.php', 'Phase 10 — Customer dashboard');
