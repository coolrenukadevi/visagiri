<?php
require __DIR__ . '/includes/config.php';

header('Content-Type: application/xml; charset=UTF-8');

$pages = [
    ['index.php', '1.0', 'daily'],
    ['visa-information/', '0.7', 'monthly'],
    ['visa-information/visa-requirements/', '0.6', 'monthly'],
    ['visa-information/visa-documents/', '0.6', 'monthly'],
    ['visa-information/visa-checklist/', '0.6', 'monthly'],
    ['visa-information/visa-fees/', '0.6', 'monthly'],
    ['visa-information/processing-time/', '0.6', 'monthly'],
    ['visa-information/visa-appointment/', '0.6', 'monthly'],
    ['visa-information/visa-faqs/', '0.6', 'monthly'],
    ['blog/', '0.6', 'weekly'],
    ['track-application/', '0.4', 'monthly'],
    ['about-us/', '0.6', 'monthly'],
    ['leadership/', '0.4', 'yearly'],
    ['why-choose-us/', '0.5', 'monthly'],
    ['careers/', '0.4', 'monthly'],
    ['partners/', '0.4', 'monthly'],
    ['support-24x7/', '0.5', 'monthly'],
    ['contact/', '0.6', 'monthly'],
    ['privacy-policy/', '0.2', 'yearly'],
    ['terms-and-conditions/', '0.2', 'yearly'],
    ['refund-policy/', '0.2', 'yearly'],
    ['cookie-policy/', '0.2', 'yearly'],
    ['disclaimer/', '0.2', 'yearly'],
    ['accessibility/', '0.2', 'yearly'],
    ['login.php', '0.3', 'yearly'],
    ['signup.php', '0.3', 'yearly'],
];

echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n";
echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' . "\n";
foreach ($pages as [$path, $priority, $freq]) {
    echo '  <url>';
    echo '<loc>' . htmlspecialchars(SITE_URL . '/' . $path, ENT_XML1) . '</loc>';
    echo '<changefreq>' . $freq . '</changefreq>';
    echo '<priority>' . $priority . '</priority>';
    echo '</url>' . "\n";
}
echo '</urlset>';
