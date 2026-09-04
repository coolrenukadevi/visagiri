<?php
/**
 * Shared helpers for the segmented XML sitemap set (sitemap.xml as a
 * <sitemapindex>, plus sitemap-pages.xml / sitemap-countries.xml /
 * sitemap-locations.xml as the actual <urlset> files it references) — see
 * brief section 26: split sitemaps by type, index only canonical/
 * indexable/200 URLs, never include noindex/redirect/404/duplicate URLs.
 */

const SITEMAP_BASE = 'https://visaagency.in';

/** [path, changefreq, priority] for every static (non-database-driven) indexable page. */
function sitemap_static_pages(): array
{
    return [
        ['', 'weekly', '1.0'],
        ['privacy-policy', 'yearly', '0.4'],
        ['terms-and-conditions', 'yearly', '0.4'],
        ['cookie-policy', 'yearly', '0.4'],
        ['disclaimer', 'yearly', '0.4'],
        ['refund-policy', 'yearly', '0.4'],
        ['data-security', 'yearly', '0.4'],
        ['sitemap', 'monthly', '0.3'],
        ['service', 'weekly', '0.9'],
        ['service-details', 'monthly', '0.7'],
        ['country-list', 'weekly', '0.9'],
        ['apostille', 'monthly', '0.8'],
        ['apostille-mea', 'monthly', '0.7'],
        ['apostille-embassy-attestation', 'monthly', '0.7'],
        ['apostille-certificate-attestation', 'monthly', '0.7'],
        ['apostille-document-legalisation', 'monthly', '0.7'],
        ['apostille-translation-services', 'monthly', '0.7'],
        ['forex', 'monthly', '0.8'],
        ['forex-enquiry', 'monthly', '0.7'],
        ['other-services', 'monthly', '0.6'],
        ['pricing', 'monthly', '0.7'],
        ['appointment', 'monthly', '0.7'],
        ['about', 'monthly', '0.7'],
        ['our-services', 'monthly', '0.8'],
        ['visa-requirements', 'monthly', '0.7'],
        ['visa-checklist', 'monthly', '0.7'],
        ['visa-appointment', 'monthly', '0.7'],
        ['visa-news', 'weekly', '0.6'],
        ['careers', 'monthly', '0.4'],
        ['b2b-partners', 'monthly', '0.5'],
        ['contact', 'monthly', '0.8'],
        ['news', 'weekly', '0.6'],
        ['news-grid', 'weekly', '0.5'],
        ['news-details', 'monthly', '0.5'],
        ['forex-track', 'monthly', '0.4'],
        ['locations', 'monthly', '0.7'],
        ['visa-consultant', 'monthly', '0.8'],
        ['payment', 'monthly', '0.5'],
        ['visa-refusal', 'monthly', '0.5'],
        ['visa-consultancy-services', 'weekly', '0.9'],
        ['visa-tourist', 'monthly', '0.8'],
        ['visa-business', 'monthly', '0.8'],
        ['visa-family', 'monthly', '0.8'],
        ['visa-transit', 'monthly', '0.7'],
        ['visa-sports', 'monthly', '0.7'],
        ['visa-medical', 'monthly', '0.7'],
        ['visa-crew', 'monthly', '0.7'],
        ['visa-extension', 'monthly', '0.7'],
    ];
}

function sitemap_url(string $loc, string $lastmod, string $changefreq, string $priority): string
{
    return "  <url>\n    <loc>" . htmlspecialchars($loc) . "</loc>\n    <lastmod>$lastmod</lastmod>\n    <changefreq>$changefreq</changefreq>\n    <priority>$priority</priority>\n  </url>\n";
}

function sitemap_open(): void
{
    header('Content-Type: application/xml; charset=UTF-8');
    echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n";
    echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' . "\n";
}

function sitemap_close(): void
{
    echo '</urlset>' . "\n";
}
