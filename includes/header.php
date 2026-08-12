<?php
declare(strict_types=1);

/**
 * Shared page head + sticky global header. Included by every page
 * handler (directly, or via render_scaffold_page() for now). Expects
 * $pageTitle, $pageDescription, $canonicalUrl to already be set by
 * the caller; falls back to sane defaults if a handler forgets to.
 */

$pageTitle ??= 'Visagiri - Visa Management';
$pageDescription ??= 'Technology-enabled visa consultancy and application management from Visagiri, a unit of Tripgation Pvt Ltd.';
$canonicalUrl ??= APP_URL . ($_SERVER['REQUEST_URI'] ?? '/');
$noindex ??= false;
$ogImage ??= APP_URL . '/assets/images/og-image.png';
/** @var list<array<string,mixed>> $structuredData */
$structuredData ??= [];

// Sitewide Organization schema — confirmed facts only (see AUDIT.md
// §1/§7): no invented address, ratings, employee counts, or awards.
// Skipped on noindexed pages; there's no reason to describe the
// organization on a login form or an empty placeholder.
if (!$noindex) {
    array_unshift($structuredData, [
        '@context' => 'https://schema.org',
        '@type' => 'Organization',
        'name' => 'Visagiri',
        'url' => APP_URL . '/',
        'logo' => $ogImage,
        'description' => 'Visagiri is a visa consultancy and document-attestation brand under Tripgation Pvt Ltd, serving visa and travel-related requirements since April 2015.',
        'foundingDate' => '2015-04',
        'email' => 'info@visagiri.com',
        'parentOrganization' => ['@type' => 'Organization', 'name' => 'Tripgation Pvt Ltd'],
    ]);
}

$currentPath = parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH) ?? '/';

$navLinks = [
    ['label' => 'Visa Process', 'href' => '/visa-process/'],
    ['label' => 'Visa Updates', 'href' => '/blog/'],
];

// Country mega-menu — see includes/data.php's country_mega_menu_data().
$countryMenuData = country_mega_menu_data();
// "Find Visa By Purpose" reuses the same source $visaServiceLinks was
// built from, just kept as the raw rows too so icons are available.
$visaTypesRaw = visa_types_all();

// Per-region shortlist for the mega-menu columns (popular destinations
// first, then alphabetical — PHP's usort is stable since 8.0, so the
// query's existing ORDER BY name is preserved within each group).
// "View All {Region} (N) →" links to the real, unabridged full list
// on /countries/ for everything not shown here.
$topCountries = static function (array $countries, int $limit): array {
    usort($countries, static fn(array $a, array $b): int => ((int) $b['is_popular_destination']) <=> ((int) $a['is_popular_destination']));
    return array_slice($countries, 0, $limit);
};
$asiaTop = $topCountries($countryMenuData['by_region']['Asia'] ?? [], 6);
// Excludes the 'schengen' aggregate row itself — it already has its
// own highlight box below, so listing it again here as a plain
// country link would just duplicate it.
$europeNonSchengenTop = $topCountries(
    array_values(array_filter(
        $countryMenuData['by_region']['Europe'] ?? [],
        static fn(array $c): bool => !$c['is_schengen'] && $c['slug'] !== 'schengen'
    )),
    5
);
$africaTop = $topCountries($countryMenuData['by_region']['Africa'] ?? [], 6);
$northAmericaTop = $topCountries($countryMenuData['by_region']['North America'] ?? [], 3);
$southAmericaTop = $topCountries($countryMenuData['by_region']['South America'] ?? [], 3);
$oceaniaTop = $topCountries($countryMenuData['by_region']['Oceania'] ?? [], 3);

// Company mega-menu. Reused/linked pages only where real content
// already exists (About, its Why-Us/Our-Story sections, and the
// existing Contact/Careers/Partners stub routes) — Leadership, Our
// Team, and Affiliations & Accreditations are new but stay honest
// "content pending" stubs (pages/leadership.php etc.) since real
// names, bios, and accrediting bodies aren't available to author
// generically; see AUDIT.md for the flagged follow-up.
$companyMenu = [
    'Discover' => [
        ['label' => 'About Us', 'desc' => 'Who we are, our mission, vision and values', 'href' => '/about/', 'icon' => 'about'],
        ['label' => 'Why Us', 'desc' => 'Our expertise, technology, transparency and service advantage', 'href' => '/about/#why-visagiri', 'icon' => 'shield'],
        ['label' => 'Our Story', 'desc' => 'Our journey and evolution', 'href' => '/about/#our-story', 'icon' => 'compass'],
    ],
    'People' => [
        ['label' => 'Leadership', 'desc' => 'Leadership and management', 'href' => '/leadership/', 'icon' => 'star'],
        ['label' => 'Our Team', 'desc' => 'Meet our visa and travel professionals', 'href' => '/our-team/', 'icon' => 'users'],
        ['label' => 'Careers', 'desc' => 'Opportunities to join our team', 'href' => '/careers/', 'icon' => 'briefcase'],
    ],
    'Trust & Connect' => [
        ['label' => 'Partners', 'desc' => 'Our business and strategic partners', 'href' => '/partners/', 'icon' => 'link'],
        ['label' => 'Affiliations & Accreditations', 'desc' => 'Industry relationships and credentials', 'href' => '/affiliations/', 'icon' => 'award'],
        ['label' => 'Contact Us', 'desc' => 'Speak with our experts', 'href' => '/contact/', 'icon' => 'mail'],
    ],
];
$companyIsActive = static function () use ($companyMenu, $currentPath): bool {
    foreach ($companyMenu as $group) {
        foreach ($group as $item) {
            $path = strtok($item['href'], '#');
            if ($path !== '/' && str_starts_with($currentPath, $path)) {
                return true;
            }
        }
    }
    return false;
};

// Pulled from the real visa type catalog rather than hardcoded — a
// hardcoded copy of this list had previously fallen out of sync
// (missing Medical and Conference Visa, then Sports Visa) more than
// once, so every consumer reads from the same source now.
$visaServiceLinks = array_map(
    static fn(array $t) => ['label' => $t['name'], 'href' => "/visa-type/{$t['slug']}/"],
    visa_types_all()
);

// Attestation mega-menu — reads from the same attestation_categories()
// source of truth as attestation/index.php and includes/footer.php,
// so the nav can never fall out of sync with the routable services
// the way the old hardcoded visa-type arrays did.
$attestationCategories = attestation_categories();

$isActive = static fn(string $href): bool => $href !== '/' && str_starts_with($currentPath, $href);
?>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><?= e($pageTitle) ?></title>
<meta name="description" content="<?= e($pageDescription) ?>">
<link rel="canonical" href="<?= e($canonicalUrl) ?>">
<meta name="robots" content="<?= $noindex ? 'noindex, nofollow' : 'index, follow' ?>">
<meta property="og:type" content="website">
<meta property="og:title" content="<?= e($pageTitle) ?>">
<meta property="og:description" content="<?= e($pageDescription) ?>">
<meta property="og:url" content="<?= e($canonicalUrl) ?>">
<meta property="og:image" content="<?= e($ogImage) ?>">
<meta property="og:site_name" content="Visagiri">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:image" content="<?= e($ogImage) ?>">
<link rel="icon" href="<?= e(asset_url('/assets/images/favicon.svg')) ?>" type="image/svg+xml">
<link rel="icon" href="<?= e(asset_url('/favicon.ico')) ?>" sizes="any">
<link rel="icon" href="<?= e(asset_url('/assets/images/favicon-32x32.png')) ?>" type="image/png" sizes="32x32">
<link rel="icon" href="<?= e(asset_url('/assets/images/favicon-16x16.png')) ?>" type="image/png" sizes="16x16">
<link rel="apple-touch-icon" href="<?= e(asset_url('/assets/images/apple-touch-icon.png')) ?>">
<?php
// Phase 3 originally loaded these through main.css's @import chain,
// which is correct in a bundler but wrong served raw: the browser
// has to fetch main.css, parse it, discover each @import, and only
// then start fetching those — serially, one round trip at a time.
// Individual <link> tags are all discoverable from the HTML itself,
// so the browser's preloader fires every request in parallel the
// moment it sees <head>. main.css itself is left in place for
// docs/design-system-preview.html, which still wants one bundled
// file; the live site no longer goes through it.
foreach ([
    'tokens', 'base', 'components', 'layout', 'home',
    'visa', 'countries',
] as $cssFile): ?>
<link rel="stylesheet" href="<?= e(asset_url("/assets/css/$cssFile.css")) ?>">
<?php endforeach; ?>
<?php foreach ($structuredData as $block): ?>
<script type="application/ld+json"><?= json_encode($block, JSON_UNESCAPED_SLASHES) ?></script>
<?php endforeach; ?>
</head>
<body>
<a class="skip-link" href="#main">Skip to content</a>

<header class="site-header" id="site-header">
    <div class="container site-header__bar">
        <a href="/" class="site-header__logo" aria-label="Visagiri home">
            <span class="site-header__logo-mark">VISA<span>GIRI</span></span>
            <span class="site-header__logo-sub">Visa Management</span>
        </a>

        <nav class="site-header__nav" aria-label="Primary">
            <ul>
                <li class="has-dropdown">
                    <a href="/visa-type/" aria-haspopup="true"<?= $isActive('/visa-type/') ? ' class="is-active"' : '' ?>>Visa Services</a>
                    <ul class="dropdown-menu">
                        <?php foreach ($visaServiceLinks as $link): ?>
                        <li><a href="<?= e($link['href']) ?>"><?= e($link['label']) ?></a></li>
                        <?php endforeach; ?>
                    </ul>
                </li>
                <li class="has-dropdown has-mega-menu">
                    <a href="/attestation/" id="attestation-mega-trigger" aria-haspopup="true" aria-expanded="false" aria-controls="attestation-mega-menu"<?= $isActive('/attestation/') ? ' class="is-active"' : '' ?>>Attestation</a>
                    <div class="mega-menu" id="attestation-mega-menu" aria-labelledby="attestation-mega-trigger">
                        <div class="mega-menu__columns">
                            <?php foreach ($attestationCategories as $megaCategoryName => $megaCategoryServices): ?>
                            <div class="mega-menu__col">
                                <div class="mega-menu__col-heading"><span class="mega-menu__col-icon" aria-hidden="true"><?= attestation_category_icon($megaCategoryName) ?></span><?= e($megaCategoryName) ?></div>
                                <ul>
                                    <?php foreach ($megaCategoryServices as $megaService): ?>
                                    <li><a href="/attestation/<?= e($megaService['slug']) ?>/"><span class="mega-menu__icon" aria-hidden="true"><?= $megaService['icon'] ?></span><?= e($megaService['menu_label']) ?></a></li>
                                    <?php endforeach; ?>
                                </ul>
                            </div>
                            <?php endforeach; ?>
                        </div>
                        <div class="mega-menu__cta">
                            <div class="mega-menu__cta-copy">
                                <strong>Need Document Attestation?</strong>
                                <p>Get professional assistance with document attestation, apostille and legalization.</p>
                            </div>
                            <a href="<?= e(whatsapp_enquiry_href('Hi Visagiri, I would like to get a quote for document attestation services.')) ?>" class="btn btn-gold btn-sm" target="_blank" rel="noopener noreferrer">Get Attestation Quote &rarr;</a>
                        </div>
                    </div>
                </li>
                <li class="has-dropdown has-mega-menu has-mega-menu--countries">
                    <a href="/countries/" id="countries-mega-trigger" aria-haspopup="true" aria-expanded="false" aria-controls="countries-mega-menu"<?= ($isActive('/countries/') || $isActive('/visa/')) ? ' class="is-active"' : '' ?>>Countries <?= nav_chevron_icon() ?></a>
                    <div class="mega-menu mega-menu--countries" id="countries-mega-menu" aria-labelledby="countries-mega-trigger">
                        <div class="mega-menu__countries-search">
                            <svg width="16" height="16" viewBox="0 0 20 20" fill="none" aria-hidden="true"><circle cx="9" cy="9" r="6.5" stroke="currentColor" stroke-width="1.6"/><path d="M17 17L13.6 13.6" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/></svg>
                            <input type="search" id="mega-country-filter" class="form-input" placeholder="Search country, visa or destination&hellip;" aria-label="Search countries">
                        </div>

                        <div class="mega-menu__col-heading">Popular Destinations</div>
                        <div class="mega-menu__chip-row" data-mega-country-col>
                            <?php foreach ($countryMenuData['popular'] as $c): ?>
                            <a href="/visa/<?= e($c['slug']) ?>/" class="mega-menu__chip" data-mega-country-name="<?= e(strtolower($c['name'])) ?>">
                                <span aria-hidden="true"><?= flag_emoji($c['iso2']) ?></span> <?= e($c['name']) ?>
                            </a>
                            <?php endforeach; ?>
                        </div>

                        <div class="mega-menu__countries-columns" id="mega-country-results">
                            <div class="mega-menu__col mega-menu__col--popular">
                                <div class="mega-menu__col-heading">Find Visa By Purpose</div>
                                <div class="mega-menu__purpose-grid">
                                    <?php foreach ($visaTypesRaw as $vt): ?>
                                    <a href="/visa-type/<?= e($vt['slug']) ?>/"><span class="mega-menu__icon" aria-hidden="true"><?= visa_type_icon($vt['slug']) ?></span><?= e($vt['name']) ?></a>
                                    <?php endforeach; ?>
                                </div>
                            </div>

                            <div class="mega-menu__col">
                                <div class="mega-menu__col-heading">Asia</div>
                                <div data-mega-country-col>
                                    <ul>
                                        <?php foreach ($asiaTop as $c): ?>
                                        <li data-mega-country-name="<?= e(strtolower($c['name'])) ?>"><a href="/visa/<?= e($c['slug']) ?>/"><span aria-hidden="true"><?= flag_emoji($c['iso2']) ?></span> <?= e($c['name']) ?></a></li>
                                        <?php endforeach; ?>
                                    </ul>
                                </div>
                                <a href="/countries/#region-asia" class="mega-menu__viewall">View All Asia (<?= count($countryMenuData['by_region']['Asia'] ?? []) ?>) &rarr;</a>
                            </div>

                            <div class="mega-menu__col">
                                <div class="mega-menu__col-heading">Europe</div>
                                <div class="mega-menu__schengen-box" data-mega-country-name="schengen area schengen visa">
                                    <div class="mega-menu__schengen-title">🇪🇺 Schengen Visa</div>
                                    <p class="mega-menu__schengen-copy"><?= count($countryMenuData['schengen']) ?> European countries, one visa.</p>
                                    <a href="/visa/schengen/" class="mega-menu__schengen-link">Explore Schengen &rarr;</a>
                                </div>
                                <div data-mega-country-col style="margin-top:var(--space-3)">
                                    <ul>
                                        <?php foreach ($europeNonSchengenTop as $c): ?>
                                        <li data-mega-country-name="<?= e(strtolower($c['name'])) ?>"><a href="/visa/<?= e($c['slug']) ?>/"><span aria-hidden="true"><?= flag_emoji($c['iso2']) ?></span> <?= e($c['name']) ?></a></li>
                                        <?php endforeach; ?>
                                    </ul>
                                </div>
                                <a href="/countries/#region-europe" class="mega-menu__viewall">View All Europe (<?= count($countryMenuData['by_region']['Europe'] ?? []) ?>) &rarr;</a>
                            </div>

                            <div class="mega-menu__col">
                                <div class="mega-menu__col-heading">Africa</div>
                                <div data-mega-country-col>
                                    <ul>
                                        <?php foreach ($africaTop as $c): ?>
                                        <li data-mega-country-name="<?= e(strtolower($c['name'])) ?>"><a href="/visa/<?= e($c['slug']) ?>/"><span aria-hidden="true"><?= flag_emoji($c['iso2']) ?></span> <?= e($c['name']) ?></a></li>
                                        <?php endforeach; ?>
                                    </ul>
                                </div>
                                <a href="/countries/#region-africa" class="mega-menu__viewall">View All Africa (<?= count($countryMenuData['by_region']['Africa'] ?? []) ?>) &rarr;</a>
                            </div>

                            <div class="mega-menu__col">
                                <div class="mega-menu__col-heading">Americas &amp; Oceania</div>
                                <div data-mega-country-col>
                                    <ul>
                                        <?php foreach ($northAmericaTop as $c): ?>
                                        <li data-mega-country-name="<?= e(strtolower($c['name'])) ?>"><a href="/visa/<?= e($c['slug']) ?>/"><span aria-hidden="true"><?= flag_emoji($c['iso2']) ?></span> <?= e($c['name']) ?></a></li>
                                        <?php endforeach; ?>
                                    </ul>
                                </div>
                                <a href="/countries/#region-north-america" class="mega-menu__viewall">View All N. America (<?= count($countryMenuData['by_region']['North America'] ?? []) ?>) &rarr;</a>
                                <div class="mega-menu__col-heading" style="margin-top:var(--space-4)">South America</div>
                                <div data-mega-country-col>
                                    <ul>
                                        <?php foreach ($southAmericaTop as $c): ?>
                                        <li data-mega-country-name="<?= e(strtolower($c['name'])) ?>"><a href="/visa/<?= e($c['slug']) ?>/"><span aria-hidden="true"><?= flag_emoji($c['iso2']) ?></span> <?= e($c['name']) ?></a></li>
                                        <?php endforeach; ?>
                                    </ul>
                                </div>
                                <a href="/countries/#region-south-america" class="mega-menu__viewall">View All S. America (<?= count($countryMenuData['by_region']['South America'] ?? []) ?>) &rarr;</a>
                                <div class="mega-menu__col-heading" style="margin-top:var(--space-4)">Oceania</div>
                                <div data-mega-country-col>
                                    <ul>
                                        <?php foreach ($oceaniaTop as $c): ?>
                                        <li data-mega-country-name="<?= e(strtolower($c['name'])) ?>"><a href="/visa/<?= e($c['slug']) ?>/"><span aria-hidden="true"><?= flag_emoji($c['iso2']) ?></span> <?= e($c['name']) ?></a></li>
                                        <?php endforeach; ?>
                                    </ul>
                                </div>
                                <a href="/countries/#region-oceania" class="mega-menu__viewall">View All Oceania (<?= count($countryMenuData['by_region']['Oceania'] ?? []) ?>) &rarr;</a>
                            </div>
                        </div>

                        <p id="mega-country-empty" class="mega-menu__countries-empty" hidden>No matches &mdash; try a different destination, or <a href="/countries/">browse the full directory</a>.</p>

                        <div class="mega-menu__featured-row">
                            <a href="/visa/schengen/" class="mega-menu__featured-card mega-menu__featured-card--highlight" data-mega-country-name="schengen">
                                <span class="mega-menu__featured-card-flag" aria-hidden="true">🇪🇺</span>
                                <span class="mega-menu__featured-card-title">Schengen Visa</span>
                                <span class="mega-menu__featured-card-copy"><?= count($countryMenuData['schengen']) ?> European countries</span>
                                <span class="mega-menu__featured-card-link">Explore Schengen &rarr;</span>
                            </a>
                            <a href="/visa/usa/" class="mega-menu__featured-card" data-mega-country-name="usa united states">
                                <span class="mega-menu__featured-card-flag" aria-hidden="true">🇺🇸</span>
                                <span class="mega-menu__featured-card-title">USA Visa</span>
                                <span class="mega-menu__featured-card-copy">Tourist, business, student &amp; more</span>
                                <span class="mega-menu__featured-card-link">Explore USA Visa &rarr;</span>
                            </a>
                            <a href="/visa/canada/" class="mega-menu__featured-card" data-mega-country-name="canada">
                                <span class="mega-menu__featured-card-flag" aria-hidden="true">🇨🇦</span>
                                <span class="mega-menu__featured-card-title">Canada Visa</span>
                                <span class="mega-menu__featured-card-copy">Visitor, business, study &amp; work</span>
                                <span class="mega-menu__featured-card-link">Explore Canada Visa &rarr;</span>
                            </a>
                            <a href="/visa/uk/" class="mega-menu__featured-card" data-mega-country-name="uk united kingdom">
                                <span class="mega-menu__featured-card-flag" aria-hidden="true">🇬🇧</span>
                                <span class="mega-menu__featured-card-title">UK Visa</span>
                                <span class="mega-menu__featured-card-copy">Visitor, business, student &amp; work</span>
                                <span class="mega-menu__featured-card-link">Explore UK Visa &rarr;</span>
                            </a>
                        </div>

                        <div class="mega-menu__countries-footer">
                            <div class="mega-menu__guided-search">
                                <strong>Not sure which visa you need?</strong>
                                <p>Tell us your destination and purpose of travel &mdash; we'll help you find the right visa type.</p>
                                <a href="/#visa-search" class="btn btn-outline btn-sm">Find My Visa &rarr;</a>
                            </div>
                            <div class="mega-menu__directory-cta">
                                <strong>&#127760; Explore All Countries</strong>
                                <p>Visa requirements, application procedures, and document checklists for <?= (int) $countryMenuData['total'] ?>+ countries worldwide.</p>
                                <a href="/countries/" class="btn btn-gold btn-sm">View Complete Country Directory &rarr;</a>
                            </div>
                        </div>
                    </div>
                </li>
                <?php foreach ($navLinks as $link): ?>
                <li><a href="<?= e($link['href']) ?>"<?= $isActive($link['href']) ? ' class="is-active"' : '' ?>><?= e($link['label']) ?></a></li>
                <?php endforeach; ?>
                <li class="has-dropdown has-mega-menu has-mega-menu--company">
                    <a href="/about/" id="company-mega-trigger" aria-haspopup="true" aria-expanded="false" aria-controls="company-mega-menu"<?= $companyIsActive() ? ' class="is-active"' : '' ?>>Company <?= nav_chevron_icon() ?></a>
                    <div class="mega-menu mega-menu--company" id="company-mega-menu" aria-labelledby="company-mega-trigger">
                        <div class="mega-menu__columns mega-menu__columns--company">
                            <?php foreach ($companyMenu as $groupName => $groupItems): ?>
                            <div class="mega-menu__col">
                                <div class="mega-menu__col-heading"><?= e($groupName) ?></div>
                                <ul>
                                    <?php foreach ($groupItems as $item): ?>
                                    <li>
                                        <a href="<?= e($item['href']) ?>" class="mega-menu__company-link">
                                            <span class="mega-menu__company-icon" aria-hidden="true"><?= company_nav_icon($item['icon']) ?></span>
                                            <span class="mega-menu__company-text">
                                                <span class="mega-menu__company-label"><?= e($item['label']) ?></span>
                                                <span class="mega-menu__company-desc"><?= e($item['desc']) ?></span>
                                            </span>
                                            <span class="mega-menu__company-arrow" aria-hidden="true">&rarr;</span>
                                        </a>
                                    </li>
                                    <?php endforeach; ?>
                                </ul>
                            </div>
                            <?php endforeach; ?>
                            <div class="mega-menu__featured">
                                <div class="mega-menu__featured-visual"><?= company_featured_illustration() ?></div>
                                <div class="mega-menu__featured-title">Visa Management, Reimagined.</div>
                                <p class="mega-menu__featured-copy">Technology-driven visa solutions backed by experienced professionals.</p>
                                <a href="/about/#why-visagiri" class="mega-menu__featured-link">Explore Our Approach &rarr;</a>
                            </div>
                        </div>
                    </div>
                </li>
            </ul>
        </nav>

        <div class="site-header__actions">
            <a href="/countries/" class="site-header__icon-btn" aria-label="Search visas">
                <svg width="20" height="20" viewBox="0 0 20 20" fill="none" aria-hidden="true"><circle cx="9" cy="9" r="6.5" stroke="currentColor" stroke-width="1.6"/><path d="M17 17L13.6 13.6" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/></svg>
            </a>
            <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like to know more about your visa services.")) ?>" class="btn btn-gold btn-sm site-header__cta" target="_blank" rel="noopener noreferrer">Enquire Now</a>
        </div>

        <button type="button" class="site-header__burger" id="site-header-burger" aria-expanded="false" aria-controls="site-header-mobile" aria-label="Open menu">
            <span></span><span></span><span></span>
        </button>
    </div>

    <div class="site-header__mobile" id="site-header-mobile">
        <nav aria-label="Mobile primary">
            <ul>
                <li><a href="/visa-type/">Visa Services</a></li>
                <li class="site-header__mobile-accordion">
                    <details>
                        <summary>Attestation</summary>
                        <div class="site-header__mobile-accordion-body">
                            <?php foreach ($attestationCategories as $megaCategoryName => $megaCategoryServices): ?>
                            <div class="site-header__mobile-subgroup">
                                <span class="site-header__mobile-subheading"><span aria-hidden="true"><?= attestation_category_icon($megaCategoryName) ?></span> <?= e($megaCategoryName) ?></span>
                                <ul>
                                    <?php foreach ($megaCategoryServices as $megaService): ?>
                                    <li><a href="/attestation/<?= e($megaService['slug']) ?>/"><span aria-hidden="true"><?= $megaService['icon'] ?></span> <?= e($megaService['menu_label']) ?></a></li>
                                    <?php endforeach; ?>
                                </ul>
                            </div>
                            <?php endforeach; ?>
                            <a href="/attestation/" class="site-header__mobile-viewall">View All Attestation Services &rarr;</a>
                        </div>
                    </details>
                </li>
                <li class="site-header__mobile-accordion">
                    <details>
                        <summary>Countries</summary>
                        <div class="site-header__mobile-accordion-body">
                            <div class="site-header__mobile-subgroup">
                                <span class="site-header__mobile-subheading">Popular Destinations</span>
                                <ul>
                                    <?php foreach ($countryMenuData['popular'] as $c): ?>
                                    <li><a href="/visa/<?= e($c['slug']) ?>/"><span aria-hidden="true"><?= flag_emoji($c['iso2']) ?></span> <?= e($c['name']) ?></a></li>
                                    <?php endforeach; ?>
                                </ul>
                            </div>
                            <div class="site-header__mobile-subgroup">
                                <span class="site-header__mobile-subheading">Asia</span>
                                <ul>
                                    <?php foreach ($asiaTop as $c): ?>
                                    <li><a href="/visa/<?= e($c['slug']) ?>/"><span aria-hidden="true"><?= flag_emoji($c['iso2']) ?></span> <?= e($c['name']) ?></a></li>
                                    <?php endforeach; ?>
                                </ul>
                                <a href="/countries/#region-asia" class="site-header__mobile-viewall">View All Asia (<?= count($countryMenuData['by_region']['Asia'] ?? []) ?>) &rarr;</a>
                            </div>
                            <div class="site-header__mobile-subgroup">
                                <span class="site-header__mobile-subheading">Europe</span>
                                <ul>
                                    <li><a href="/visa/schengen/" class="site-header__mobile-schengen">🇪🇺 Schengen Visa <span>(<?= count($countryMenuData['schengen']) ?> countries)</span></a></li>
                                </ul>
                                <span class="site-header__mobile-subheading" style="margin-top:var(--space-3)">Other Europe</span>
                                <ul>
                                    <?php foreach ($europeNonSchengenTop as $c): ?>
                                    <li><a href="/visa/<?= e($c['slug']) ?>/"><span aria-hidden="true"><?= flag_emoji($c['iso2']) ?></span> <?= e($c['name']) ?></a></li>
                                    <?php endforeach; ?>
                                </ul>
                                <a href="/countries/#region-europe" class="site-header__mobile-viewall">View All Europe (<?= count($countryMenuData['by_region']['Europe'] ?? []) ?>) &rarr;</a>
                            </div>
                            <div class="site-header__mobile-subgroup">
                                <span class="site-header__mobile-subheading">Africa</span>
                                <ul>
                                    <?php foreach ($africaTop as $c): ?>
                                    <li><a href="/visa/<?= e($c['slug']) ?>/"><span aria-hidden="true"><?= flag_emoji($c['iso2']) ?></span> <?= e($c['name']) ?></a></li>
                                    <?php endforeach; ?>
                                </ul>
                                <a href="/countries/#region-africa" class="site-header__mobile-viewall">View All Africa (<?= count($countryMenuData['by_region']['Africa'] ?? []) ?>) &rarr;</a>
                            </div>
                            <div class="site-header__mobile-subgroup">
                                <span class="site-header__mobile-subheading">North America</span>
                                <ul>
                                    <?php foreach ($northAmericaTop as $c): ?>
                                    <li><a href="/visa/<?= e($c['slug']) ?>/"><span aria-hidden="true"><?= flag_emoji($c['iso2']) ?></span> <?= e($c['name']) ?></a></li>
                                    <?php endforeach; ?>
                                </ul>
                                <a href="/countries/#region-north-america" class="site-header__mobile-viewall">View All N. America (<?= count($countryMenuData['by_region']['North America'] ?? []) ?>) &rarr;</a>
                            </div>
                            <div class="site-header__mobile-subgroup">
                                <span class="site-header__mobile-subheading">South America</span>
                                <ul>
                                    <?php foreach ($southAmericaTop as $c): ?>
                                    <li><a href="/visa/<?= e($c['slug']) ?>/"><span aria-hidden="true"><?= flag_emoji($c['iso2']) ?></span> <?= e($c['name']) ?></a></li>
                                    <?php endforeach; ?>
                                </ul>
                                <a href="/countries/#region-south-america" class="site-header__mobile-viewall">View All S. America (<?= count($countryMenuData['by_region']['South America'] ?? []) ?>) &rarr;</a>
                            </div>
                            <div class="site-header__mobile-subgroup">
                                <span class="site-header__mobile-subheading">Oceania</span>
                                <ul>
                                    <?php foreach ($oceaniaTop as $c): ?>
                                    <li><a href="/visa/<?= e($c['slug']) ?>/"><span aria-hidden="true"><?= flag_emoji($c['iso2']) ?></span> <?= e($c['name']) ?></a></li>
                                    <?php endforeach; ?>
                                </ul>
                                <a href="/countries/#region-oceania" class="site-header__mobile-viewall">View All Oceania (<?= count($countryMenuData['by_region']['Oceania'] ?? []) ?>) &rarr;</a>
                            </div>
                            <div class="site-header__mobile-subgroup">
                                <span class="site-header__mobile-subheading">Visa By Purpose</span>
                                <ul>
                                    <?php foreach ($visaTypesRaw as $vt): ?>
                                    <li><a href="/visa-type/<?= e($vt['slug']) ?>/"><span aria-hidden="true"><?= visa_type_icon($vt['slug']) ?></span> <?= e($vt['name']) ?></a></li>
                                    <?php endforeach; ?>
                                </ul>
                            </div>
                            <a href="/countries/" class="site-header__mobile-viewall">&#127760; Complete Country Directory &rarr;</a>
                        </div>
                    </details>
                </li>
                <?php foreach ($navLinks as $link): ?>
                <li><a href="<?= e($link['href']) ?>"><?= e($link['label']) ?></a></li>
                <?php endforeach; ?>
                <li class="site-header__mobile-accordion">
                    <details>
                        <summary>Company</summary>
                        <div class="site-header__mobile-accordion-body">
                            <ul class="site-header__mobile-flat">
                                <?php foreach ($companyMenu as $groupItems): ?>
                                <?php foreach ($groupItems as $item): ?>
                                <li><a href="<?= e($item['href']) ?>">&rarr; <?= e($item['label']) ?></a></li>
                                <?php endforeach; ?>
                                <?php endforeach; ?>
                            </ul>
                        </div>
                    </details>
                </li>
            </ul>
        </nav>
        <div class="site-header__mobile-actions">
            <a href="<?= e(whatsapp_enquiry_href("Hi Visagiri, I'd like to know more about your visa services.")) ?>" class="btn btn-gold" target="_blank" rel="noopener noreferrer">Enquire Now</a>
        </div>
    </div>
</header>

<main id="main">
