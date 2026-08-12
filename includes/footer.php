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
                <li><a href="/visa-type/tourist/">Tourist Visa</a></li>
                <li><a href="/visa-type/business/">Business Visa</a></li>
                <li><a href="/visa-type/student/">Student Visa</a></li>
                <li><a href="/visa-type/work/">Work Visa</a></li>
                <li><a href="/visa-type/family/">Family Visit Visa</a></li>
                <li><a href="/visa-type/transit/">Transit Visa</a></li>
            </ul>
        </div>

        <div class="site-footer__col">
            <h3>Attestation Services</h3>
            <ul>
                <li><a href="/attestation/apostille/">Apostille</a></li>
                <li><a href="/attestation/mea-attestation/">MEA Attestation</a></li>
                <li><a href="/attestation/embassy-attestation/">Embassy Attestation</a></li>
                <li><a href="/attestation/commercial-attestation/">Commercial Attestation</a></li>
            </ul>
        </div>

        <div class="site-footer__col">
            <h3>Explore Countries</h3>
            <ul>
                <li><a href="/countries/#region-asia">Asia</a></li>
                <li><a href="/countries/#region-europe">Europe</a></li>
                <li><a href="/countries/#region-north-america">North America</a></li>
                <li><a href="/countries/#region-south-america">South America</a></li>
                <li><a href="/countries/#region-africa">Africa</a></li>
                <li><a href="/countries/#region-oceania">Oceania</a></li>
                <li><a href="/countries/">Explore 200+ Countries &rarr;</a></li>
            </ul>
        </div>

        <div class="site-footer__col">
            <h3>Company</h3>
            <ul>
                <li><a href="/about/">About Visagiri</a></li>
                <li><a href="/about/#why-visagiri">Why Visagiri</a></li>
                <li><a href="/contact/">Contact Us</a></li>
                <li><a href="/careers/">Careers</a></li>
                <li><a href="/partners/">Partners</a></li>
                <li><a href="/corporate-services/">Corporate Services</a></li>
            </ul>
        </div>

        <div class="site-footer__col">
            <h3>Resources</h3>
            <ul>
                <li><a href="/visa-process/">Visa Information</a></li>
                <li><a href="/faq/">Visa FAQs</a></li>
                <li><a href="/blog/">Travel Guides</a></li>
                <li><a href="/blog/">Visa Updates</a></li>
                <li><a href="/document-checklists/">Document Checklists</a></li>
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
                <a href="/track-visa/">Track Application</a>
                <a href="/track-request/">Track Request</a>
                <a href="/payment-link/">Payment Link</a>
                <a href="/support/">Contact Support</a>
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
