<?php
declare(strict_types=1);

/**
 * Shared global footer + closing tags. Pairs with includes/header.php,
 * which opens <main> — this file closes it. Facts in the bottom bar
 * (founding date, CIN) are client-confirmed, not invented; see
 * AUDIT.md §7/§1 for sourcing.
 */
?>
</main>

<footer class="site-footer">
    <div class="container site-footer__grid">
        <div class="site-footer__brand">
            <div class="site-header__logo-mark">VISA<span>GIRI</span></div>
            <p class="site-footer__tagline">Seamless Visas. Limitless Journeys.</p>
            <p class="site-footer__muted">A Unit of Tripgation Pvt Ltd</p>
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
            <h3>Explore</h3>
            <ul>
                <li><a href="/countries/">Countries</a></li>
                <li><a href="/visa-process/">Visa Process</a></li>
                <li><a href="/blog/">Visa Updates</a></li>
                <li><a href="/faq/">FAQ</a></li>
                <li><a href="/track-visa/">Track Application</a></li>
            </ul>
        </div>

        <div class="site-footer__col">
            <h3>Company</h3>
            <ul>
                <li><a href="/about/">About</a></li>
                <li><a href="/contact/">Contact</a></li>
                <li><a href="/privacy/">Privacy Policy</a></li>
                <li><a href="/terms/">Terms &amp; Conditions</a></li>
                <li><a href="/refund-policy/">Refund Policy</a></li>
                <li><a href="/grievance/">Grievance Redressal</a></li>
            </ul>
        </div>
    </div>

    <div class="site-footer__disclaimer">
        <div class="container">
            <p>Visa decisions are made solely by the relevant embassy, consulate, or government immigration authority. Visagiri provides visa consultancy and application-management assistance and does not guarantee visa approval.</p>
        </div>
    </div>

    <div class="site-footer__bottom">
        <div class="container">
            <p>&copy; <?= date('Y') ?> Visagiri &mdash; A Unit of Tripgation Pvt Ltd. Serving visa and travel-related requirements since April 2015. CIN: U63030UP2020PTC128661. All rights reserved.</p>
        </div>
    </div>
</footer>

<script src="/assets/js/site.js"></script>
</body>
</html>
