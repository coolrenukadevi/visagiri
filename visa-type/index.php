<?php
declare(strict_types=1);
render_scaffold_page(
    title: 'Visa Services',
    description: 'Tourist, business, student, work, family, transit, medical, and conference visa assistance.',
    canonicalPath: $_SERVER['REQUEST_URI'] ?? '/visa-type/',
    handlerPath: 'visa-type/index.php',
    plannedInPhase: 'Phase 8 — Country pages (cross-country visa-type explainers)'
);
