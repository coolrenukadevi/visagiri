<?php
declare(strict_types=1);

/**
 * Phase 6 — Visa search entry point. Validates the submitted country
 * and visa-type slugs against the real catalog (never trusts raw
 * input for a redirect target) and sends the visitor to the
 * canonical /visa/{country}/ or /visa/{country}/{type}/ page.
 * Nationality and travel date are passed through as query params so
 * the destination page can echo the search context back; they don't
 * change which page is resolved.
 */

$countrySlug = trim((string) ($_GET['country'] ?? ''));
$visaTypeSlug = trim((string) ($_GET['visa_type'] ?? ''));
$carrySearchParams = array_filter([
    'nationality' => $_GET['nationality'] ?? '',
    'travel_date' => $_GET['travel_date'] ?? '',
]);
$queryString = $carrySearchParams ? ('?' . http_build_query($carrySearchParams)) : '';

if ($countrySlug === '') {
    flash_set('notice', 'Select a destination country to check visa requirements.');
    redirect('/countries/');
}

$country = country_by_slug($countrySlug);

if (!$country) {
    flash_set('notice', "We couldn't find that destination. Browse the full list below.");
    redirect('/countries/');
}

if ($visaTypeSlug !== '') {
    $visaType = visa_type_by_slug($visaTypeSlug);

    if ($visaType) {
        redirect("/visa/{$country['slug']}/{$visaType['slug']}/" . $queryString);
    }

    flash_set('notice', "We couldn't find that visa type. Here's what's available for {$country['slug']}.");
}

redirect("/visa/{$country['slug']}/" . $queryString);
