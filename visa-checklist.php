<?php
$page_title = "Visa Document Checklist &ndash; Visa Agency";
$page_description = "Interactive, category-specific visa document checklist with a live progress tracker. By Visa Agency, Patna.";
include __DIR__ . '/includes/header.php';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Visa Document Checklist</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Visa Checklist</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="console-intro">
            <div class="console-intro-inner">
                <div class="console-tag"><span class="blink"></span> checklist.build() &middot; interactive document tracker</div>
                <p class="lede">Pick your visa category and check off documents as you gather them &mdash; a live progress readout shows exactly what's left before you're ready to file.</p>
                <div class="console-cta-row">
                    <a class="console-btn console-btn-primary" href="#builder">Build My Checklist</a>
                    <a class="console-btn console-btn-outline-dark" href="contact">Get A Personalised Checklist</a>
                </div>
            </div>
        </section>

        <section class="section-padding fix" id="builder">
            <div class="container">
                <div class="console-section-head">
                    <p class="console-eyebrow">Checklist builder</p>
                    <h2>Track Your Documents</h2>
                    <p>Select a visa category to load its checklist. Checked items stay checked while you're on this page &mdash; refreshing resets the tracker.</p>
                </div>

                <div class="console-tool-panel">
                    <div class="console-tool-panel-bar"><span class="dot"></span><span class="dot"></span><span class="dot"></span><span class="path">visa-agency / document-checklist</span></div>
                    <div class="console-tool-panel-body">
                        <div class="console-field-row" style="margin-bottom:22px;">
                            <div class="console-field">
                                <label for="visaType">Visa category</label>
                                <select id="visaType">
                                    <option value="tourist">Tourist Visa</option>
                                    <option value="business">Business Visa</option>
                                    <option value="family">Family Visa</option>
                                    <option value="work">Work Visa</option>
                                    <option value="medical">Medical Visa</option>
                                    <option value="transit">Transit Visa</option>
                                </select>
                            </div>
                        </div>

                        <div class="console-progress-wrap">
                            <div class="console-progress-track"><div class="console-progress-fill" id="progressFill"></div></div>
                            <div class="console-progress-label" id="progressLabel">0 of 0 ready</div>
                        </div>

                        <div class="console-checklist" id="checklistBox"></div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="console-section-head">
                    <p class="console-eyebrow">Why a checklist matters</p>
                    <h2>Missing Documents Are The #1 Cause Of Delay</h2>
                    <p>A complete, correctly formatted document set is what keeps your application moving without back-and-forth requests from the embassy.</p>
                </div>
                <div class="console-card-grid">
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><rect x="7" y="3" width="10" height="7" rx="1"/><path d="M9 10v4h6v-4M4 21h16M6 21l1-4h10l1 4"/></svg></div>
                        <h3>Category-specific</h3>
                        <p>Every visa category has a different checklist &mdash; we don't use one generic list for every applicant.</p>
                    </div>
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M4 12l5 5L20 6"/></svg></div>
                        <h3>Reviewed before filing</h3>
                        <p>Once your documents are ready, our team reviews them against the embassy's actual current requirements.</p>
                    </div>
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 3"/></svg></div>
                        <h3>Saves you a resubmission</h3>
                        <p>Catching a missing document before filing is faster than fixing it after a query from the embassy.</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="console-cta-band">
                    <div class="console-cta-inner">
                        <div>
                            <h3>Want Us To Build This Checklist For You?</h3>
                            <p>Share your destination and visa category &mdash; we'll send a checklist tailored to your exact case.</p>
                        </div>
                        <div class="console-cta-buttons">
                            <a class="console-btn console-btn-primary" href="contact">Get My Checklist</a>
                            <a class="console-btn console-btn-outline-dark" href="tel:+917844819819">Talk to a Visa Expert</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

<script>
var CHECKLISTS = {
  tourist: ["Passport with 6+ months validity and blank pages","Recent passport-size photographs","Bank statements (last 3–6 months)","Confirmed or tentative travel itinerary","Hotel booking or accommodation proof","Proof of employment / leave sanction letter","Return flight ticket"],
  business: ["Passport with 6+ months validity","Invitation letter from host company","Employer sponsorship / NOC letter","Company registration documents (if self-employed)","Proof of sufficient funds","Confirmed flight and hotel booking"],
  family: ["Passport with 6+ months validity","Marriage / birth / relationship certificate","Sponsor's proof of status abroad","Sponsor's income and accommodation proof","Invitation or sponsorship letter","Recent photographs (destination format)"],
  work: ["Passport with 6+ months validity","Signed employment contract","Employer sponsorship documents","Educational certificates (attested if required)","Medical examination report (if required)","Police clearance certificate (if required)"],
  medical: ["Passport with 6+ months validity","Hospital treatment acceptance letter","Medical reports and referral letter","Proof of funds to cover treatment and stay","Attendant's passport and relationship proof","Return or onward travel itinerary"],
  transit: ["Passport with 6+ months validity","Confirmed onward flight ticket","Valid visa for final destination (if required)","Proof of layover duration","Photographs (destination format)"]
};

(function(){
  var select = document.getElementById('visaType');
  var box = document.getElementById('checklistBox');
  var fill = document.getElementById('progressFill');
  var label = document.getElementById('progressLabel');

  function updateProgress(){
    var boxes = box.querySelectorAll('input[type=checkbox]');
    var checked = box.querySelectorAll('input[type=checkbox]:checked').length;
    var pct = boxes.length ? Math.round((checked / boxes.length) * 100) : 0;
    fill.style.width = pct + '%';
    label.textContent = checked + ' of ' + boxes.length + ' ready';
  }

  function render(type){
    box.innerHTML = '';
    CHECKLISTS[type].forEach(function(item, i){
      var row = document.createElement('label');
      row.className = 'console-cl-row';
      row.innerHTML = '<input type="checkbox" id="cl'+i+'"><span class="txt">'+item+'</span>';
      var cb = row.querySelector('input');
      cb.addEventListener('change', function(){
        row.classList.toggle('done', cb.checked);
        updateProgress();
      });
      box.appendChild(row);
    });
    updateProgress();
  }

  select.addEventListener('change', function(){ render(select.value); });
  render(select.value);
})();
</script>

<?php include __DIR__ . '/includes/footer.php'; ?>
