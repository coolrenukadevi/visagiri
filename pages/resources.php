<?php
declare(strict_types=1);

/**
 * Resources Hub — /resources/. Links out to genuinely existing pages
 * only (documentation, document templates, visa information, tools,
 * updates, FAQs) — the same real destinations as the header's
 * Resources mega-menu (includes/header.php's $resourcesMenu). No
 * fabricated per-category content or search/filter engine: those
 * require a real Resource data model that doesn't exist yet (see
 * AUDIT.md's Resources Hub entry).
 */

$resourceCategories = [
    [
        'title' => 'Guides & Documents',
        'desc' => 'Document requirements, ready-made templates and checklists for your visa application.',
        'icon' => '&#128196;',
        'links' => [
            ['label' => 'Documentation Assistance', 'href' => '/documentation/'],
            ['label' => 'Document Templates', 'href' => '/document-templates/'],
            ['label' => 'Document Checklists (Coming Soon)', 'href' => '/document-checklists/'],
        ],
    ],
    [
        'title' => 'Visa Information',
        'desc' => 'Visa types, destinations we serve and embassy/consulate contact details.',
        'icon' => '&#127760;',
        'links' => [
            ['label' => 'Visa Types', 'href' => '/visa-type/'],
            ['label' => 'Countries We Serve', 'href' => '/countries/'],
            ['label' => 'Embassy Directory', 'href' => '/embassy-directory/'],
        ],
    ],
    [
        'title' => 'Tools',
        'desc' => 'Track an existing application or check your visa status online.',
        'icon' => '&#128295;',
        'links' => [
            ['label' => 'Track Your Application', 'href' => '/track-visa/'],
            ['label' => 'Check Visa Status', 'href' => '/visa-status/'],
            ['label' => 'Visa Tools (Coming Soon)', 'href' => '/resources/tools/'],
        ],
    ],
    [
        'title' => 'Updates & Help',
        'desc' => 'Visa news and updates, answers to common questions, and how to reach our team.',
        'icon' => '&#128276;',
        'links' => [
            ['label' => 'Visa Updates & News', 'href' => '/blog/'],
            ['label' => 'FAQs', 'href' => '/faq/'],
            ['label' => 'Submit an Enquiry', 'href' => '/enquire/'],
        ],
    ],
];

$pageTitle = 'Visa Resources - Guides, Tools & Information | Visagiri';
$pageDescription = 'Visa guides, document templates, application tools and FAQs — everything you need to prepare and track your visa application with Visagiri.';
$canonicalUrl = APP_URL . '/resources/';
$structuredData = [[
    '@context' => 'https://schema.org',
    '@type' => 'BreadcrumbList',
    'itemListElement' => [
        ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => APP_URL . '/'],
        ['@type' => 'ListItem', 'position' => 2, 'name' => 'Resources', 'item' => $canonicalUrl],
    ],
]];
require __DIR__ . '/../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:760px;text-align:center">
        <span class="section-eyebrow">Resources</span>
        <h1>Visa Resources</h1>
        <p>Guides, document templates, tools and answers to help you prepare, submit and track your visa application.</p>
    </div>
</section>
<section class="section" style="padding-top:0">
    <div class="container">
        <div class="card-grid">
            <?php foreach ($resourceCategories as $category): ?>
            <div class="card service-card">
                <div class="service-card__icon"><?= $category['icon'] ?></div>
                <div class="card-title"><?= e($category['title']) ?></div>
                <p><?= e($category['desc']) ?></p>
                <ul style="margin-top:var(--space-3)">
                    <?php foreach ($category['links'] as $link): ?>
                    <li><a href="<?= e($link['href']) ?>"><?= e($link['label']) ?></a></li>
                    <?php endforeach; ?>
                </ul>
            </div>
            <?php endforeach; ?>
        </div>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
