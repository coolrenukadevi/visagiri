<?php
declare(strict_types=1);

// The other 7 slugs that used to share this stub now have their own
// real pages (see public/index.php) — /disclaimer/ is the only one
// left here, since it isn't one of the Legal & Support Centre's 9
// target URLs.
$legalTitles = [
    'disclaimer' => 'Disclaimer',
];

$path = trim(parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH) ?? '/', '/');
$title = $legalTitles[$path] ?? 'Legal';

render_scaffold_page(
    title: $title,
    description: "Visagiri's $title.",
    canonicalPath: "/$path/",
    handlerPath: 'pages/legal.php',
    plannedInPhase: 'Phase 5 — Header/Footer + core pages (Privacy/Terms/Refund/Cookie/Grievance/Disclaimer)'
);
