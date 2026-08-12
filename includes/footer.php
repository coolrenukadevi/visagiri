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
            <p class="site-footer__muted">Technology-enabled visa consultancy and document attestation assistance for travellers, students, professionals, and businesses. A Unit of Tripgation Pvt Ltd.</p>
        </div>

        <div class="site-footer__col">
            <h3>Visa Services</h3>
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
            <h3>Attestation</h3>
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
            <h3>Countries</h3>
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
            <h3>Company</h3>
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
            <h3>Resources</h3>
            <ul>
                <li><a href="/enquire/">Submit a Visa Enquiry</a></li>
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
</body>
</html>
