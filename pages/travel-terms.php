<?php
declare(strict_types=1);

/**
 * /travel-terms/ — Travel Terms & Conditions. Part of the Legal &
 * Support Centre. Scoped honestly: this project has never confirmed a
 * standalone flight/hotel booking service (see AUDIT.md's repeated
 * "no fabricated services" discipline) — this page frames flight/
 * hotel/insurance sections as what applies WHEN such assistance is
 * provided alongside a visa/travel service, not as a standing promise
 * that Visagiri operates as a full travel agency.
 */


$pageTitle = 'Visa & Travel Terms | Visagiri';
$pageDescription = 'Terms covering flight, hotel, tour, travel insurance and travel-documentation assistance connected to a Visagiri visa or attestation service.';
$canonicalUrl = APP_URL . '/travel-terms/';
$structuredData = [[
    '@context' => 'https://schema.org',
    '@type' => 'BreadcrumbList',
    'itemListElement' => [
        ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => APP_URL . '/'],
        ['@type' => 'ListItem', 'position' => 2, 'name' => 'Legal & Support', 'item' => $canonicalUrl],
        ['@type' => 'ListItem', 'position' => 3, 'name' => 'Travel Terms', 'item' => $canonicalUrl],
    ],
]];
require __DIR__ . '/../includes/header.php';

$sections = [
    'scope' => 'Scope',
    'flight-bookings' => 'Flight Bookings',
    'hotel-bookings' => 'Hotel Bookings',
    'tours-travel-services' => 'Tours / Travel Services',
    'travel-insurance' => 'Travel Insurance',
    'travel-documentation' => 'Travel Documentation',
    'immigration' => 'Immigration',
    'contact' => 'Contact',
];

render_legal_hero(
    'travel-terms',
    'Travel Terms & Conditions',
    'Terms covering the travel-related assistance connected to your visa or attestation service.',
    'legal_travel_terms_updated_at',
    $sections
);
?>
<section id="scope">
    <h2>Scope</h2>
    <p>These Travel Terms apply whenever Visagiri assists with flight, hotel, tour or travel-insurance arrangements alongside your visa or attestation service. They supplement, rather than replace, our general <a href="/terms/">Terms &amp; Conditions</a>.</p>
</section>

<section id="flight-bookings">
    <h2>Flight Bookings</h2>
    <p>Where we assist with a flight booking or itinerary in support of your visa application, fare rules, cancellation, rescheduling, no-show, name-correction, baggage and schedule-change conditions are set by the operating airline, not by Visagiri. Airline fare rules may apply, and any change or cancellation fee charged by the airline is passed through to you in addition to our own service fee, where applicable.</p>
</section>

<section id="hotel-bookings">
    <h2>Hotel Bookings</h2>
    <p>Where we assist with a hotel booking, cancellation, no-show, check-in/check-out timing and refund conditions are set by the hotel's own policy, communicated to you at the time of booking. We pass on the hotel's terms as given; we do not set them.</p>
</section>

<section id="tours-travel-services">
    <h2>Tours / Travel Services</h2>
    <p>Where a tour or travel-package service is arranged through a third-party supplier, booking confirmation, cancellation, and change conditions follow that supplier's own terms. You're responsible for reviewing and accepting the supplier's terms before we confirm the booking on your behalf.</p>
</section>

<section id="travel-insurance">
    <h2>Travel Insurance</h2>
    <p>Where travel insurance is arranged as part of your service, the policy is subject to the insurer's own policy wording, coverage limits and exclusions. Visagiri facilitates the arrangement but is not the insurer, and any claim is handled directly between you and the insurance provider under their policy terms.</p>
</section>

<section id="travel-documentation">
    <h2>Travel Documentation</h2>
    <p>You remain responsible for carrying valid travel documents — a passport with sufficient validity, your visa, and any other document required for your trip. We help you prepare and check these documents, but the final responsibility for carrying valid documentation at the time of travel rests with you.</p>
</section>

<section id="immigration">
    <h2>Immigration</h2>
    <p>Admission into any country is determined solely by that country's immigration authority at the port of entry, regardless of a visa having been granted in advance. Visagiri has no role in, and no influence over, an immigration officer's decision on arrival.</p>
</section>

<section id="contact">
    <h2>Contact</h2>
    <p>Questions about a travel-related booking? Contact us at <a href="mailto:<?= e(setting('contact_email', 'info@visagiri.com')) ?>"><?= e(setting('contact_email', 'info@visagiri.com')) ?></a> or through our <a href="/contact/">Contact Us</a> page.</p>
</section>
<?php
render_legal_hero_close();
require __DIR__ . '/../includes/footer.php';
