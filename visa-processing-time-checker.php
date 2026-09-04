<?php
$page_title = "Visa Processing Time Checker &ndash; Typical Timelines | Visa Agency";
$page_description = "Indicative visa processing timelines by category and application location for Indian passport holders. General guidance, always confirmed against the current official estimate.";
$page_canonical = 'https://visaagency.in/visa-processing-time-checker';
include __DIR__ . '/includes/header.php';
?>
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape"><img src="assets/img/inner-page/shape.png" alt="img"></div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Visa Processing Time Checker</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="resources">Resources</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Processing Time Checker</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="console-intro">
            <div class="console-intro-inner">
                <div class="console-tag"><span class="blink"></span> visa-processing.estimate() &middot; timeline tool</div>
                <p class="lede">Choose a destination and visa category for a general read on how processing typically compares &mdash; faster, standard, or longer &mdash; so you can plan when to apply. We don't invent day-counts; the current official estimate is confirmed with you before you apply.</p>
                <div class="console-cta-row">
                    <a class="console-btn console-btn-primary" href="visa-processing-time-checker#checker">Check Timeline</a>
                    <a class="console-btn console-btn-outline-dark" href="visa-application-timing">Read The Full Timing Guide</a>
                </div>
            </div>
        </section>

        <section class="section-padding fix" id="checker">
            <div class="container">
                <div class="console-section-head">
                    <p class="console-eyebrow">Processing timeline</p>
                    <h2>Check A Destination &amp; Category</h2>
                    <p>Processing time depends on the destination, visa category, application volume and season &mdash; it is set entirely by the relevant authority, not by us. This tool gives a general band, not an exact promised date.</p>
                </div>

                <div class="console-tool-panel">
                    <div class="console-tool-panel-bar"><span class="dot"></span><span class="dot"></span><span class="dot"></span><span class="path">visa-agency / processing-timeline</span></div>
                    <div class="console-tool-panel-body">
                        <div class="console-field-row">
                            <div class="console-field">
                                <label for="procDestination">Destination</label>
                                <select id="procDestination">
                                    <option value="">Select a country&hellip;</option>
                                </select>
                            </div>
                            <div class="console-field">
                                <label for="procCategory">Visa category</label>
                                <select id="procCategory">
                                    <option value="tourist">Tourist</option>
                                    <option value="business">Business</option>
                                    <option value="family">Family</option>
                                    <option value="transit">Transit</option>
                                </select>
                            </div>
                        </div>
                        <button class="console-btn console-btn-primary" id="procCheckBtn" type="button">Check Timeline Band</button>

                        <div class="console-result-box" id="procResultBox">
                            <span class="console-status-badge console-status-neutral" id="procStatusBadge"><span class="sw"></span><span id="procStatusText">&mdash;</span></span>
                            <h4 id="procResultTitle">&nbsp;</h4>
                            <p id="procResultBody">&nbsp;</p>
                            <p class="console-fine">Indicative band only, based on generally observed patterns &mdash; we confirm the current official estimate with our team before you plan travel dates.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="console-section-head">
                    <p class="console-eyebrow">What affects timing</p>
                    <h2>Factors That Move Processing Time</h2>
                </div>
                <div class="console-card-grid">
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 3"/></svg></div>
                        <h3>Season &amp; Application Volume</h3>
                        <p>Peak travel seasons and destination-specific busy periods can extend processing well beyond the standard estimate.</p>
                    </div>
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M4 12l5 5L20 6"/></svg></div>
                        <h3>Document Completeness</h3>
                        <p>An incomplete or inconsistent application is a common cause of delay &mdash; a properly prepared application moves faster.</p>
                    </div>
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><rect x="4" y="3" width="16" height="18"/><path d="M9 8h1M9 12h1M9 16h1M14 8h1M14 12h1M14 16h1"/></svg></div>
                        <h3>Visa Category &amp; Checks</h3>
                        <p>Categories requiring additional verification, interviews or inter-agency checks generally take longer than a straightforward tourist application.</p>
                    </div>
                </div>
                <p class="visa-info-note text-center mt-4">Always apply well ahead of your travel date, especially in peak season &mdash; see our full <a href="visa-application-timing">application timing guide</a>.</p>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="console-cta-band">
                    <div class="console-cta-inner">
                        <div>
                            <h3>Planning Travel Dates Around Your Visa?</h3>
                            <p>We'll give you the current official processing estimate for your destination and category, and help you plan a safe application timeline.</p>
                        </div>
                        <div class="console-cta-buttons">
                            <a class="console-btn console-btn-primary" href="contact">Start Your Visa Enquiry</a>
                            <a class="console-btn console-btn-outline-dark" href="tel:+917844819819">Talk to a Visa Expert</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

<script>
var PROC_COUNTRIES = ["United States","United Kingdom","Canada","Australia","Schengen Area","UAE","Singapore","Thailand","Japan","Sri Lanka","Nepal"];
var PROC_BANDS = {
  tourist: {status:"ok", label:"Typically Faster", note:"Tourist categories are generally processed on the faster end for most destinations, outside of peak season."},
  business: {status:"warn", label:"Typically Standard", note:"Business categories often take a similar or slightly longer time than tourist, depending on document/company verification."},
  family: {status:"warn", label:"Typically Standard To Longer", note:"Family categories can take longer where relationship or sponsorship documents need closer verification."},
  transit: {status:"ok", label:"Typically Faster", note:"Transit categories, where required, are usually processed quickly given the shorter, more limited stay."}
};
(function(){
  var destSelect = document.getElementById('procDestination');
  PROC_COUNTRIES.forEach(function(name){
    var opt = document.createElement('option');
    opt.value = name; opt.textContent = name;
    destSelect.appendChild(opt);
  });

  var btn = document.getElementById('procCheckBtn');
  var box = document.getElementById('procResultBox');
  var badge = document.getElementById('procStatusBadge');
  var statusText = document.getElementById('procStatusText');
  var title = document.getElementById('procResultTitle');
  var body = document.getElementById('procResultBody');

  btn.addEventListener('click', function(){
    var dest = destSelect.value;
    var cat = document.getElementById('procCategory').value;
    box.classList.add('show');
    if(!dest){
      badge.className = 'console-status-badge console-status-neutral';
      statusText.textContent = 'Select a country';
      title.textContent = 'Choose a destination above';
      body.textContent = 'Pick a country and category to see a general processing-time band.';
      return;
    }
    var d = PROC_BANDS[cat];
    var cls = d.status === 'ok' ? 'console-status-ok' : 'console-status-warn';
    badge.className = 'console-status-badge ' + cls;
    statusText.textContent = d.label;
    title.innerHTML = dest + ' &mdash; ' + cat.charAt(0).toUpperCase() + cat.slice(1) + ' Visa';
    body.innerHTML = d.note + ' We\'ll confirm the current official processing estimate for ' + dest + ' with you directly.';
  });
})();
</script>

<script type="application/ld+json">
<?php echo json_encode([
    '@context' => 'https://schema.org',
    '@type' => 'WebPage',
    'name' => 'Visa Processing Time Checker',
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
        ['@type' => 'ListItem', 'position' => 3, 'name' => 'Processing Time Checker', 'item' => $page_canonical],
    ],
], JSON_UNESCAPED_SLASHES); ?>
</script>

<?php include __DIR__ . '/includes/footer.php'; ?>
