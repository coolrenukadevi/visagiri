<?php
$page_title = "Visa Requirements Checker &ndash; Visa Agency";
$page_description = "Check indicative entry requirements for Indian passport holders by destination &ndash; e-visa, visa-on-arrival or embassy application. By Visa Agency, Patna.";
include __DIR__ . '/includes/header.php';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Visa Requirements Checker</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Visa Requirements</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="console-intro">
            <div class="console-intro-inner">
                <div class="console-tag"><span class="blink"></span> visa-requirements.check() &middot; live lookup tool</div>
                <p class="lede">Select your destination to get an indicative read on entry requirements &mdash; e-visa, visa-on-arrival, or an embassy application &mdash; before you start preparing documents.</p>
                <div class="console-cta-row">
                    <a class="console-btn console-btn-primary" href="visa-requirements#checker">Run A Check</a>
                    <a class="console-btn console-btn-outline-dark" href="contact">Talk To A Visa Expert</a>
                </div>
            </div>
        </section>

        <section class="section-padding fix" id="checker">
            <div class="container">
                <div class="console-section-head">
                    <p class="console-eyebrow">Requirement lookup</p>
                    <h2>Check A Destination</h2>
                    <p>This gives you a starting point based on commonly published entry rules for Indian passport holders. Always confirm with us before booking travel.</p>
                </div>

                <div class="console-tool-panel">
                    <div class="console-tool-panel-bar"><span class="dot"></span><span class="dot"></span><span class="dot"></span><span class="path">visa-agency / requirement-checker</span></div>
                    <div class="console-tool-panel-body">
                        <div class="console-field-row">
                            <div class="console-field">
                                <label for="passport">Passport</label>
                                <select id="passport">
                                    <option>India</option>
                                </select>
                            </div>
                            <div class="console-field">
                                <label for="destination">Destination country</label>
                                <select id="destination">
                                    <option value="">Select a country&hellip;</option>
                                </select>
                            </div>
                            <div class="console-field">
                                <label for="purpose">Purpose of travel</label>
                                <select id="purpose">
                                    <option value="tourist">Tourism</option>
                                    <option value="business">Business</option>
                                </select>
                            </div>
                        </div>
                        <button class="console-btn console-btn-primary" id="checkBtn" type="button">Run Requirement Check</button>

                        <div class="console-result-box" id="resultBox">
                            <span class="console-status-badge" id="statusBadge"><span class="sw"></span><span id="statusText">&mdash;</span></span>
                            <h4 id="resultTitle">&nbsp;</h4>
                            <p id="resultBody">&nbsp;</p>
                            <p class="console-fine">Indicative only, based on commonly published rules &mdash; confirm current requirements with our team before booking travel.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="console-section-head">
                    <p class="console-eyebrow">How the check works</p>
                    <h2>Three Categories We Check Against</h2>
                </div>
                <div class="console-card-grid">
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M4 12l5 5L20 6"/></svg></div>
                        <h3>Visa-free / e-Visa</h3>
                        <p>Destinations that allow entry without a prior embassy visit &mdash; either visa-free for short stays or through an online e-Visa application.</p>
                    </div>
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M12 3l7 3v6c0 5-3.5 8-7 9-3.5-1-7-4-7-9V6l7-3z"/></svg></div>
                        <h3>Visa-on-arrival</h3>
                        <p>Destinations where you can obtain a visa at the port of entry, typically with a fee and specific document requirements.</p>
                    </div>
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><rect x="4" y="3" width="16" height="18"/><path d="M9 8h1M9 12h1M9 16h1M14 8h1M14 12h1M14 16h1"/></svg></div>
                        <h3>Embassy visa required</h3>
                        <p>Destinations requiring a full application submitted to the embassy or consulate before travel, often with an interview or biometrics.</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="console-cta-band">
                    <div class="console-cta-inner">
                        <div>
                            <h3>Want This Confirmed By A Person, Not Just A Tool?</h3>
                            <p>Every result above is a starting point &mdash; our consultants confirm exact requirements before you apply.</p>
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
var VISA_DATA = {
  "United Arab Emirates": {status:"ok", label:"e-Visa", title:"e-Visa available", body:"Indian passport holders can typically apply for a UAE visa online before travel."},
  "Singapore": {status:"ok", label:"e-Visa", title:"e-Visa available", body:"An electronic visa application is typically available for short tourist and business visits."},
  "Thailand": {status:"warn", label:"Visa-on-arrival", title:"Visa-on-arrival commonly available", body:"Many nationalities including India have access to visa-on-arrival for short stays, subject to current rules."},
  "Sri Lanka": {status:"ok", label:"e-Visa (ETA)", title:"Electronic Travel Authorisation", body:"An online ETA is typically required before travel and can usually be completed in advance."},
  "Maldives": {status:"ok", label:"Visa-free / on arrival", title:"Visa on arrival for short stays", body:"Short tourist stays are commonly granted a visa on arrival, subject to onward ticket and hotel proof."},
  "Malaysia": {status:"warn", label:"eNTRI / eVisa", title:"Electronic travel registration", body:"Short tourist visits are often covered under an online travel registration or e-visa scheme."},
  "Vietnam": {status:"warn", label:"e-Visa", title:"e-Visa required", body:"An online e-visa is typically required in advance for Indian passport holders visiting Vietnam."},
  "Japan": {status:"bad", label:"Embassy visa", title:"Embassy application required", body:"A visa must be obtained from the Japanese embassy or consulate before travel, with supporting documents."},
  "United Kingdom": {status:"bad", label:"Embassy visa", title:"Embassy application required", body:"A visa must be obtained in advance through the visa application centre, including biometrics."},
  "Schengen (e.g. France, Germany, Italy)": {status:"bad", label:"Embassy visa", title:"Schengen visa required", body:"A Schengen visa application is required through the relevant country's visa centre before travel."},
  "United States": {status:"bad", label:"Embassy visa", title:"Embassy application &amp; interview", body:"A visa application including an in-person interview is required at the US embassy or consulate."},
  "Canada": {status:"bad", label:"Embassy visa", title:"Visa application required", body:"A visitor visa application, including biometrics, is required before travel to Canada."},
  "Australia": {status:"warn", label:"e-Visa (subclass)", title:"Electronic visa required", body:"An online visa application is required before travel, typically processed without an embassy visit."},
  "Saudi Arabia": {status:"ok", label:"e-Visa", title:"e-Visa available", body:"An electronic tourist visa is typically available for eligible travellers before arrival."},
  "Qatar": {status:"ok", label:"Visa-free / e-Visa", title:"Simplified entry available", body:"Many travellers can access a visa-free or electronic entry route for short visits &mdash; we'll confirm current eligibility."},
  "Nepal": {status:"ok", label:"Visa-free", title:"Visa-free entry", body:"Indian passport holders can typically enter Nepal without a visa, subject to valid ID."},
  "Bhutan": {status:"warn", label:"Permit required", title:"Entry permit required", body:"Indian nationals typically need an entry permit rather than a traditional visa &mdash; arranged in advance or on arrival."}
};

(function(){
  var destSelect = document.getElementById('destination');
  Object.keys(VISA_DATA).sort().forEach(function(name){
    var opt = document.createElement('option');
    opt.value = name; opt.textContent = name;
    destSelect.appendChild(opt);
  });

  var btn = document.getElementById('checkBtn');
  var box = document.getElementById('resultBox');
  var badge = document.getElementById('statusBadge');
  var statusText = document.getElementById('statusText');
  var title = document.getElementById('resultTitle');
  var resultBody = document.getElementById('resultBody');

  btn.addEventListener('click', function(){
    var dest = destSelect.value;
    if(!dest){
      box.classList.add('show');
      badge.className = 'console-status-badge console-status-neutral';
      statusText.textContent = 'Select a country';
      title.textContent = 'Choose a destination above';
      resultBody.textContent = 'Pick a country from the list to see an indicative requirement.';
      return;
    }
    var d = VISA_DATA[dest];
    var cls = d.status === 'ok' ? 'console-status-ok' : d.status === 'warn' ? 'console-status-warn' : 'console-status-bad';
    box.classList.add('show');
    badge.className = 'console-status-badge ' + cls;
    statusText.textContent = d.label;
    title.innerHTML = d.title;
    resultBody.innerHTML = d.body;
  });
})();
</script>

<?php include __DIR__ . '/includes/footer.php'; ?>
