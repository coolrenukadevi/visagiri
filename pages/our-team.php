<?php
declare(strict_types=1);

/**
 * Our Team page. No individual team-member names/photos have been
 * confirmed beyond the two directors already on /leadership/, so this
 * describes the real functional roles behind Visagiri's actual
 * services (visa consultancy, document attestation, application
 * support) generically — the same discipline already applied to "Why
 * Visagiri" — rather than inventing headcounts, names, or bios.
 */

$teamRoles = [
    ['icon' => '&#129489;&#8205;&#128188;', 'title' => 'Visa Consultants', 'desc' => 'Assess eligibility, explain requirements, and guide you to the right visa category for your trip.'],
    ['icon' => '&#128196;', 'title' => 'Document & Attestation Specialists', 'desc' => 'Review your documents and manage apostille, MEA, and embassy attestation requirements.'],
    ['icon' => '&#128172;', 'title' => 'Application Support', 'desc' => 'Keep you updated on your application status and answer questions throughout the process.'],
];

$pageTitle = 'Meet the Visagiri Team - Visa & Attestation Experts';
$pageDescription = 'Meet the team behind Visagiri — visa consultants, document and attestation specialists, and application support dedicated to your visa journey.';
$canonicalUrl = APP_URL . '/our-team/';
$structuredData = [breadcrumb_schema([
    ['name' => 'Home', 'url' => APP_URL . '/'],
    ['name' => 'Our Team', 'url' => $canonicalUrl],
])];
require __DIR__ . '/../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8);padding-bottom:var(--space-6)">
    <div class="container" style="max-width:760px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">Our Team</span>
            <h1>The People Behind Visagiri</h1>
        </div>
        <p style="font-size:var(--font-size-lg);color:var(--text-dark)">
            Behind every application is a team dedicated to getting your visa and document attestation
            right — from your first eligibility question to the day your documents are approved.
        </p>
    </div>
</section>

<section class="section" style="padding-top:0">
    <div class="container">
        <div class="card-grid">
            <?php foreach ($teamRoles as $role): ?>
            <div class="card feature-card">
                <div class="feature-card__icon" aria-hidden="true"><?= $role['icon'] ?></div>
                <div class="card-title"><?= e($role['title']) ?></div>
                <p><?= e($role['desc']) ?></p>
            </div>
            <?php endforeach; ?>
        </div>
    </div>
</section>

<section class="section" style="padding-top:0">
    <div class="container" style="max-width:760px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <h2>How the team works together</h2>
        </div>
        <p>
            A typical case moves through all three roles: a visa consultant assesses your eligibility and
            requirements up front, a document and attestation specialist reviews the paperwork itself where
            apostille or attestation is involved, and application support keeps you posted as your case moves
            through submission and decision — with online status tracking rather than one-off phone updates.
        </p>
        <div class="alert alert-info">
            Individual team profiles are being added here soon. In the meantime, meet our
            <a href="/leadership/">leadership team</a>, or get in touch with any questions.
        </div>
    </div>
</section>

<section class="section" style="padding-top:0">
    <div class="container" style="max-width:640px;text-align:center">
        <div class="section-heading" style="max-width:none">
            <h2>Talk to the team</h2>
        </div>
        <div style="display:flex;gap:var(--space-3);flex-wrap:wrap;justify-content:center">
            <a href="/contact/" class="btn btn-outline">Contact Us &rarr;</a>
            <a href="/leadership/" class="btn btn-outline">Leadership &rarr;</a>
            <a href="/careers/" class="btn btn-outline">Careers &rarr;</a>
        </div>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
