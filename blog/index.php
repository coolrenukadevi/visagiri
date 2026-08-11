<?php
declare(strict_types=1);
render_scaffold_page(
    title: 'Visa Updates',
    description: 'Visa updates, embassy updates, visa guides, document guides, and travel alerts.',
    canonicalPath: $_SERVER['REQUEST_URI'] ?? '/blog/',
    handlerPath: 'blog/index.php',
    plannedInPhase: 'Phase 5 — Homepage (Latest Visa Updates) + later content phase'
);
