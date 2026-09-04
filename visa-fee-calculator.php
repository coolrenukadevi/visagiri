<?php
$page_title = "Visa Fee Calculator &ndash; Estimate Government &amp; Service Fees | Visa Agency";
$page_description = "Understand how visa fees typically break down &mdash; government/embassy fee vs Visa Agency service fee &mdash; by category. Always confirmed against the current official fee before you apply.";
$page_canonical = 'https://visaagency.in/visa-fee-calculator';
include __DIR__ . '/includes/header.php';
?>
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape"><img src="assets/img/inner-page/shape.png" alt="img"></div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Visa Fee Calculator</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="resources">Resources</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Fee Calculator</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="console-intro">
            <div class="console-intro-inner">
                <div class="console-tag"><span class="blink"></span> visa-fee.estimate() &middot; fee structure tool</div>
                <p class="lede">Choose a destination and visa category to see how the fee typically breaks down &mdash; a government/embassy fee, plus a separate Visa Agency service fee. We show structure, not invented numbers &mdash; exact current fees are confirmed before you apply.</p>
                <div class="console-cta-row">
                    <a class="console-btn console-btn-primary" href="visa-fee-calculator#calculator">See Fee Structure</a>
                    <a class="console-btn console-btn-outline-dark" href="contact">Get An Exact Quote</a>
                </div>
            </div>
        </section>

        <section class="section-padding fix" id="calculator">
            <div class="container">
                <div class="console-section-head">
                    <p class="console-eyebrow">Fee structure</p>
                    <h2>Check A Destination</h2>
                    <p>Government/embassy fees are set and collected by the relevant authority &mdash; we never mark those up. Our service fee covers document review, application preparation and support, and is quoted separately and transparently.</p>
                </div>

                <div class="console-tool-panel">
                    <div class="console-tool-panel-bar"><span class="dot"></span><span class="dot"></span><span class="dot"></span><span class="path">visa-agency / fee-structure</span></div>
                    <div class="console-tool-panel-body">
                        <div class="console-field-row">
                            <div class="console-field">
                                <label for="feeDestination">Destination</label>
                                <select id="feeDestination">
                                    <option value="">Select a country&hellip;</option>
                                </select>
                            </div>
                            <div class="console-field">
                                <label for="feeCategory">Visa category</label>
                                <select id="feeCategory">
                                    <option value="tourist">Tourist</option>
                                    <option value="business">Business</option>
                                    <option value="family">Family</option>
                                    <option value="transit">Transit</option>
                                </select>
                            </div>
                        </div>
                        <button class="console-btn console-btn-primary" id="feeCheckBtn" type="button">Show Fee Structure</button>

                        <div class="console-result-box" id="feeResultBox">
                            <span class="console-status-badge console-status-neutral" id="feeStatusBadge"><span class="sw"></span><span id="feeStatusText">Two-part fee</span></span>
                            <h4 id="feeResultTitle">&nbsp;</h4>
                            <p id="feeResultBody">&nbsp;</p>
                            <p class="console-fine">Indicative structure only &mdash; exact current government fee and our service fee are confirmed together before you apply.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="console-section-head">
                    <p class="console-eyebrow">How visa fees work</p>
                    <h2>Two Separate Charges, Every Time</h2>
                </div>
                <div class="console-card-grid">
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><rect x="4" y="3" width="16" height="18"/><path d="M9 8h1M9 12h1M9 16h1M14 8h1M14 12h1M14 16h1"/></svg></div>
                        <h3>Government / Embassy Fee</h3>
                        <p>Set and collected by the destination's embassy, consulate or immigration authority. This is non-negotiable and paid directly to them &mdash; we never add a markup to it.</p>
                    </div>
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M4 12l5 5L20 6"/></svg></div>
                        <h3>Visa Agency Service Fee</h3>
                        <p>Covers eligibility review, document preparation, application support and, where applicable, appointment assistance. Quoted upfront, separately from the government fee.</p>
                    </div>
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M12 3l7 3v6c0 5-3.5 8-7 9-3.5-1-7-4-7-9V6l7-3z"/></svg></div>
                        <h3>Optional Add-Ons</h3>
                        <p>Courier, translation, apostille/attestation or expedited processing are separate optional services, only charged if you need them.</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="console-cta-band">
                    <div class="console-cta-inner">
                        <div>
                            <h3>Want An Exact, Current Fee Quote?</h3>
                            <p>Government fees change without notice &mdash; we confirm the exact current fee for your destination and category before you pay anything.</p>
                        </div>
                        <div class="console-cta-buttons">
                            <a class="console-btn console-btn-primary" href="contact">Get A Fee Quote</a>
                            <a class="console-btn console-btn-outline-dark" href="tel:+917844819819">Talk to a Visa Expert</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

<script>
var FEE_COUNTRIES = ["United States","United Kingdom","Canada","Australia","Schengen Area","UAE","Singapore","Thailand","Japan"];
var FEE_NOTES = {
  tourist: "Tourist visas typically carry a standard embassy fee for the category, plus our service fee for document review and application preparation.",
  business: "Business visas often carry a similar or slightly higher embassy fee than tourist, reflecting additional document review (invitation letters, company documents).",
  family: "Family visas can involve category-specific embassy fees and, for longer-stay categories, additional government charges beyond the base visa fee.",
  transit: "Transit visas, where required, are usually the lowest embassy fee tier, with a correspondingly lighter service scope."
};
(function(){
  var destSelect = document.getElementById('feeDestination');
  FEE_COUNTRIES.forEach(function(name){
    var opt = document.createElement('option');
    opt.value = name; opt.textContent = name;
    destSelect.appendChild(opt);
  });

  var btn = document.getElementById('feeCheckBtn');
  var box = document.getElementById('feeResultBox');
  var title = document.getElementById('feeResultTitle');
  var body = document.getElementById('feeResultBody');

  btn.addEventListener('click', function(){
    var dest = destSelect.value;
    var cat = document.getElementById('feeCategory').value;
    box.classList.add('show');
    if(!dest){
      title.textContent = 'Choose a destination above';
      body.textContent = 'Pick a country to see how its visa fee typically breaks down.';
      return;
    }
    title.innerHTML = dest + ' &mdash; ' + cat.charAt(0).toUpperCase() + cat.slice(1) + ' Visa Fee Structure';
    body.innerHTML = FEE_NOTES[cat] + ' We\'ll confirm the exact current government fee for ' + dest + ' and our service fee together, before you apply.';
  });
})();
</script>

<script type="application/ld+json">
<?php echo json_encode([
    '@context' => 'https://schema.org',
    '@type' => 'WebPage',
    'name' => 'Visa Fee Calculator',
    'url' => $page_canonical,
    'description' => $page_description,
    'isPartOf' => ['@id' => 'https://visaagency.in/#website'],
], JSON_UNESCAPED_SLASHES); ?>
</script>
<script type="application/ld+json">
<?php echo json_encode([
    '@context' => 'https://schema.org',
    '@type' => 'BreadcrumbList',
    'itemListElement' => [
        ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => 'https://visaagency.in/'],
        ['@type' => 'ListItem', 'position' => 2, 'name' => 'Resources', 'item' => 'https://visaagency.in/resources'],
        ['@type' => 'ListItem', 'position' => 3, 'name' => 'Fee Calculator', 'item' => $page_canonical],
    ],
], JSON_UNESCAPED_SLASHES); ?>
</script>

<?php include __DIR__ . '/includes/footer.php'; ?>
