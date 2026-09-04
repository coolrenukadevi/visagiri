<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/auth.php';
require __DIR__ . '/includes/db.php';
require __DIR__ . '/includes/seo.php';

$pdo = db();

$breadcrumbs = [['Home', url('index.php')], ['Resources', null]];
$pageTitle = 'Resources — Visa Tips, Travel Guides & Updates | Videshia';
$pageDescription = 'Practical visa tips, destination guides and how Videshia keeps you informed on embassy and policy changes relevant to your application.';
$schemaBlocks = [breadcrumb_schema($breadcrumbs)];
require __DIR__ . '/includes/header.php';

$guideCountrySlugs = ['usa', 'uk', 'canada', 'australia', 'france', 'singapore', 'uae', 'japan', 'new-zealand'];
$countryNameBySlug = array_column($megaCountries ?? [], 'name', 'slug');
?>

<section class="page-hero">
    <div class="container">
        <span class="eyebrow">Resources</span>
        <h1>Visa &amp; travel resources</h1>
        <p>Practical tips, destination guides and a clear explanation of how we keep you informed — without the guesswork.</p>
    </div>
</section>

<div class="container"><?= render_breadcrumbs($breadcrumbs) ?></div>

<section class="section" id="tips">
    <div class="container">
        <div class="section-head center"><span class="eyebrow">Visa Tips</span><h2>Practical tips before you apply</h2></div>
        <div class="grid-3">
            <?php foreach ([
                ['Apply well ahead of travel', 'Processing times and appointment availability both vary by destination and season — the earlier you start, the more options you have.'],
                ['Keep digital and physical copies', 'Scan every document you submit and keep physical originals safe — you\'ll often need them again for future applications.'],
                ['Don\'t book non-refundable travel early', 'Hold off on non-refundable flights or hotels until your visa is confirmed, unless your application specifically requires a booking.'],
                ['Check your passport validity first', 'Most destinations require 6+ months\' validity beyond your travel date and at least two blank pages.'],
                ['Be consistent across every document', 'Names, dates and addresses should match exactly across your passport, forms and supporting documents — small mismatches cause delays.'],
                ['Ask before you assume', 'Requirements change and vary by nationality — confirm your exact checklist with a consultant rather than relying on someone else\'s experience.'],
            ] as [$title, $desc]): ?>
            <div class="card">
                <h3 style="font-size:15.5px"><?= e($title) ?></h3>
                <p><?= e($desc) ?></p>
            </div>
            <?php endforeach; ?>
        </div>
    </div>
</section>

<section class="section section-alt" id="guides">
    <div class="container">
        <div class="section-head center"><span class="eyebrow">Travel Guides</span><h2>Destination guides</h2></div>
        <p style="text-align:center;max-width:640px;margin:0 auto 24px">Each destination page covers visa categories, documents, fees and processing time for that country.</p>
        <div style="display:flex;flex-wrap:wrap;gap:8px;justify-content:center">
            <?php foreach ($guideCountrySlugs as $slug): if (!isset($countryNameBySlug[$slug])) continue; ?>
            <a href="<?= url('visa-by-country/' . $slug . '/') ?>" style="padding:8px 16px;border:1px solid var(--border);border-radius:var(--radius-full);font-size:13.5px;color:var(--navy-800);background:var(--surface)"><?= e($countryNameBySlug[$slug]) ?></a>
            <?php endforeach; ?>
        </div>
        <p style="text-align:center;margin-top:20px"><a href="<?= url('visa-by-country/') ?>" style="color:var(--teal-500);font-weight:600">View all destinations &rarr;</a></p>
    </div>
</section>

<section class="section" id="news">
    <div class="container grid-2" style="align-items:center">
        <div>
            <span class="eyebrow">Visa News</span>
            <h2>How we handle visa &amp; policy news</h2>
            <p>Governments and embassies update visa rules periodically — sometimes with little notice, and not always reported accurately elsewhere. Rather than publish unverified news, Videshia briefs applicants directly once a change is confirmed and relevant to their case.</p>
            <p>If you have an active enquiry, your consultant will flag anything that affects your application as soon as it's confirmed.</p>
        </div>
        <div class="card">
            <h3>Have an active application?</h3>
            <p>Track its status any time, or reach out to your consultant directly.</p>
            <a href="<?= url('track-application/') ?>" class="btn btn-primary" style="margin-top:8px">Track Application</a>
        </div>
    </div>
</section>

<section class="section section-alt" id="updates">
    <div class="container grid-2" style="align-items:center">
        <div class="card" style="order:2">
            <h3>Questions about a specific destination?</h3>
            <p>Embassy processes and documentation rules differ by country — ask us directly rather than relying on a general update.</p>
            <a href="<?= url('contact/') ?>" class="btn btn-primary" style="margin-top:8px">Contact Us</a>
        </div>
        <div style="order:1">
            <span class="eyebrow">Embassy Updates</span>
            <h2>Embassy &amp; policy updates</h2>
            <p>Because embassy processes and requirements can change by nationality and category, we don't publish a generic changelog that could be inaccurate for your specific case. Instead, updates are shared through your assigned consultant and reflected directly on the relevant country and visa-type pages once confirmed.</p>
        </div>
    </div>
</section>

<section class="section">
    <div class="container" style="max-width:720px;text-align:center">
        <div class="card card-dark" style="padding:36px">
            <h3>Ready to start your visa application?</h3>
            <p>Share your destination and purpose of travel — a Videshia consultant will confirm your exact requirements.</p>
            <a href="<?= url('enquiry/') ?>" class="btn btn-primary" style="margin-top:10px">Start Your Visa Enquiry</a>
        </div>
    </div>
</section>

<?php require __DIR__ . '/includes/footer.php'; ?>
