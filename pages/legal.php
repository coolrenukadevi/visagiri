<?php
declare(strict_types=1);

$legalTitles = [
    'privacy' => 'Privacy Policy',
    'terms' => 'Terms & Conditions',
    'travel-terms' => 'Travel Terms',
    'payment-policy' => 'Payment Policy',
    'refund-policy' => 'Refund Policy',
    'cookie-policy' => 'Cookie Policy',
    'grievance' => 'Grievance Redressal',
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
