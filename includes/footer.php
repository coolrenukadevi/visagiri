<?php
declare(strict_types=1);

/**
 * Shared global footer + closing tags. Pairs with includes/header.php,
 * which opens <main> — this file closes it. Facts in the bottom bar
 * (founding date, CIN) are client-confirmed, not invented; see
 * AUDIT.md §7/§1 for sourcing. Region slugs are hardcoded (not
 * DB-queried) since the 6-region taxonomy is fixed and matches the
 * anchors rendered on /countries/.
 */
?>
</main>

<footer class="site-footer">
    <div class="container site-footer__grid">
        <div class="site-footer__brand">
            <div class="site-header__logo-mark">VISA<span>GIRI</span></div>
            <p class="site-footer__tagline">Seamless Visas. Limitless Journeys.</p>
            <p class="site-footer__muted">Visagiri drives innovation with smart, future-ready digital solutions that empower growth and transformation. A Unit of Tripgation Pvt Ltd.</p>
            <div class="site-footer__social">
                <a href="https://www.facebook.com/Visagiri" target="_blank" rel="noopener noreferrer" aria-label="Visagiri on Facebook"><svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M13.5 21v-7.5h2.5l.4-3H13.5V8.4c0-.87.24-1.46 1.49-1.46H16.5V4.34C16.2 4.3 15.2 4.2 14 4.2c-2.4 0-4 1.46-4 4.15V10.5H7.5v3H10V21h3.5z"/></svg></a>
                <a href="https://www.instagram.com/hi_visagiri/" target="_blank" rel="noopener noreferrer" aria-label="Visagiri on Instagram"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" aria-hidden="true"><rect x="3.5" y="3.5" width="17" height="17" rx="4.5"/><circle cx="12" cy="12" r="3.8"/><circle cx="17.2" cy="6.8" r="1"/></svg></a>
                <a href="https://x.com/visagiri" target="_blank" rel="noopener noreferrer" aria-label="Visagiri on X"><svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M13.6 10.7 20.4 3h-1.6l-5.9 6.7L8.2 3H3l7.1 10.1L3 21h1.6l6.2-7.1 5 7.1H21l-7.4-10.3zm-2.2 2.5-.7-1L5 4.3h2.5l4.6 6.5.7 1 6 8.4h-2.5l-4.9-6.7z"/></svg></a>
                <a href="https://www.youtube.com/@visagiri" target="_blank" rel="noopener noreferrer" aria-label="Visagiri on YouTube"><svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M22 12s0-3.2-.4-4.7a2.7 2.7 0 0 0-1.9-1.9C18.2 5 12 5 12 5s-6.2 0-7.7.4a2.7 2.7 0 0 0-1.9 1.9C2 8.8 2 12 2 12s0 3.2.4 4.7a2.7 2.7 0 0 0 1.9 1.9C5.8 19 12 19 12 19s6.2 0 7.7-.4a2.7 2.7 0 0 0 1.9-1.9C22 15.2 22 12 22 12z"/><path d="M10 15.3V8.7L15.8 12z" fill="var(--visa-blue-dark)"/></svg></a>
            </div>
        </div>

        <div class="site-footer__col">
            <h3><span class="site-footer__col-icon"><?= primary_nav_icon('visa-services') ?></span>Visa Services</h3>
            <ul>
                <?php
                // Work Visa and Conference Visa kept out of the footer
                // by request — still real, active visa types, still
                // reachable via the header's Visa Services dropdown
                // and the /visa-type/ hub, just not repeated here.
                $footerVisaServiceLinks = array_filter(
                    $visaServiceLinks,
                    static fn(array $l): bool => !in_array($l['label'], ['Work Visa', 'Conference Visa'], true)
                );
                ?>
                <?php foreach ($footerVisaServiceLinks as $link): ?>
                <li><a href="<?= e($link['href']) ?>"><?= e($link['label']) ?></a></li>
                <?php endforeach; ?>
            </ul>
        </div>

        <div class="site-footer__col">
            <h3><span class="site-footer__col-icon"><?= primary_nav_icon('attestation') ?></span>Attestation</h3>
            <ul>
                <?php
                // One representative service per category, kept short
                // so the column doesn't outgrow the others now that
                // there are 13 real services — see /attestation/ for
                // the full, categorized list.
                $footerAttestationLinks = array_filter([
                    $attestationCategories['Apostille'][0] ?? null,
                    $attestationCategories['Attestation'][0] ?? null,
                    $attestationCategories['Documents'][0] ?? null,
                    $attestationCategories['Legalization'][0] ?? null,
                ]);
                ?>
                <?php foreach ($footerAttestationLinks as $service): ?>
                <li><a href="/attestation/<?= e($service['slug']) ?>/"><?= e($service['menu_label']) ?></a></li>
                <?php endforeach; ?>
                <li><a href="/attestation/">View All Attestation Services &rarr;</a></li>
            </ul>
        </div>

        <div class="site-footer__col">
            <h3><span class="site-footer__col-icon"><?= primary_nav_icon('countries') ?></span>Countries</h3>
            <ul>
                <li><a href="/countries/#region-asia">Asia</a></li>
                <li><a href="/countries/#region-europe">Europe</a></li>
                <li><a href="/countries/#region-north-america">North America</a></li>
                <li><a href="/countries/#region-south-america">South America</a></li>
                <li><a href="/countries/#region-africa">Africa</a></li>
                <li><a href="/countries/#region-oceania">Oceania</a></li>
                <li><a href="/countries/">View All &rarr;</a></li>
            </ul>
        </div>

        <div class="site-footer__col">
            <h3><span class="site-footer__col-icon"><?= primary_nav_icon('company') ?></span>Company</h3>
            <ul>
                <?php
                // Careers and Affiliations & Accreditations kept out of
                // the footer by request — still reachable via the
                // header's Company mega-menu.
                foreach ($companyMenu as $footerCompanyGroup):
                    foreach ($footerCompanyGroup as $footerCompanyItem):
                        if (in_array($footerCompanyItem['label'], ['Careers', 'Affiliations & Accreditations'], true)) {
                            continue;
                        }
                ?>
                <li><a href="<?= e($footerCompanyItem['href']) ?>"><?= e($footerCompanyItem['label']) ?></a></li>
                <?php
                    endforeach;
                endforeach;
                ?>
            </ul>
        </div>

        <div class="site-footer__col">
            <h3><span class="site-footer__col-icon"><?= primary_nav_icon('resources') ?></span>Resources</h3>
            <ul>
                <li><a href="/enquire/">Submit a Visa Enquiry</a></li>
                <li><a href="/partner-program/">Become a B2B Partner</a></li>
                <li><a href="/documentation/">Documentation Assistance</a></li>
                <li><a href="/visa-process/">Visa Information</a></li>
                <li><a href="/faq/">Visa FAQs</a></li>
                <li><a href="/blog/">Travel Guides</a></li>
                <li><a href="/blog/">Visa Updates</a></li>
                <li><a href="/blog/">Blog</a></li>
            </ul>
        </div>
    </div>

    <div class="site-footer__disclaimer">
        <div class="container">
            <p>Visa decisions are made solely by the relevant embassy, consulate, or government immigration authority. Visagiri provides visa consultancy and application-management assistance and does not guarantee visa approval.</p>
        </div>
    </div>

    <div class="site-footer__legal-row">
        <div class="container">
            <nav aria-label="Legal and support">
                <a href="/privacy/">Privacy Policy</a>
                <a href="/terms/">Terms &amp; Conditions</a>
                <a href="/travel-terms/">Travel Terms</a>
                <a href="/payment-policy/">Payment Policy</a>
                <a href="/refund-policy/">Refund Policy</a>
                <a href="/cookie-policy/">Cookie Policy</a>
                <a href="/grievance/">Grievance Redressal</a>
                <a href="/sitemap/">Sitemap</a>
                <a href="/contact/">Contact Us</a>
            </nav>
        </div>
    </div>

    <div class="site-footer__bottom">
        <div class="container">
            <p>&copy; <?= date('Y') ?> Visagiri &mdash; A Unit of Tripgation Pvt Ltd. Serving visa and travel-related requirements since April 2015. CIN: U63030UP2020PTC128661. All rights reserved.</p>
        </div>
    </div>
</footer>

<?php require __DIR__ . '/enquiry-widget.php'; ?>

<script src="<?= e(asset_url('/assets/js/site.js')) ?>"></script>
<script src="<?= e(asset_url('/assets/js/visa-search-widget.js')) ?>"></script>
</body>
</html>
