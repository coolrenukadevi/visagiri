<?php
declare(strict_types=1);
render_scaffold_page(
    title: 'Page Not Found',
    description: "The page you're looking for doesn't exist.",
    canonicalPath: $_SERVER['REQUEST_URI'] ?? '/',
    handlerPath: 'pages/404.php',
    plannedInPhase: 'Phase 5 — Header/Footer + core pages (real 404 design)',
    statusCode: 404
);
