<?php
$page_title = "Book a Visa Appointment &ndash; Visa Agency";
$page_description = "Book a visa consultation with Visa Agency &ndash; pick a date and time, in person in Patna or by phone.";
include __DIR__ . '/includes/header.php';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Book a Visa Appointment</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Visa Appointment</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="console-intro">
            <div class="console-intro-inner">
                <div class="console-tag"><span class="blink"></span> appointment.schedule() &middot; consultation booking</div>
                <p class="lede">Pick a date and time that works for you, tell us what you need help with, and we'll confirm your consultation &mdash; in person in Patna, or by phone.</p>
                <div class="console-cta-row">
                    <a class="console-btn console-btn-primary" href="#scheduler">Pick A Slot</a>
                    <a class="console-btn console-btn-outline-dark" href="tel:+917844819819">Or Just Call Us</a>
                </div>
            </div>
        </section>

        <section class="section-padding fix" id="scheduler">
            <div class="container">
                <div class="console-section-head">
                    <p class="console-eyebrow">Appointment scheduler</p>
                    <h2>Choose A Date And Time</h2>
                    <p>Select an available day, then a slot. This reserves your preferred time &mdash; our team confirms it back to you by phone or WhatsApp.</p>
                </div>

                <div class="console-tool-panel">
                    <div class="console-tool-panel-bar"><span class="dot"></span><span class="dot"></span><span class="dot"></span><span class="path">visa-agency / appointment-scheduler</span></div>
                    <div class="console-tool-panel-body">
                        <div class="console-field-row">
                            <div class="console-field">
                                <label for="serviceType">What do you need help with?</label>
                                <select id="serviceType">
                                    <option>Tourist Visa</option>
                                    <option>Business Visa</option>
                                    <option>Work Visa</option>
                                    <option>Family Visa</option>
                                    <option>Medical Visa</option>
                                    <option>Apostille &amp; Attestation</option>
                                    <option>Visa Refusal Review</option>
                                    <option>Not sure yet</option>
                                </select>
                            </div>
                            <div class="console-field">
                                <label for="apptMode">Consultation mode</label>
                                <select id="apptMode">
                                    <option>In person &mdash; Patna office</option>
                                    <option>Phone consultation</option>
                                    <option>WhatsApp consultation</option>
                                </select>
                            </div>
                        </div>

                        <p style="font-family:monospace; font-size:11px; text-transform:uppercase; letter-spacing:0.08em; color:var(--text); margin:22px 0 10px;">Select a day</p>
                        <div id="dayPicker" class="console-day-picker"></div>

                        <p style="font-family:monospace; font-size:11px; text-transform:uppercase; letter-spacing:0.08em; color:var(--text); margin:20px 0 10px;">Select a time</p>
                        <div id="timePicker" class="console-time-picker"></div>

                        <div class="console-field-row" style="margin-top:22px;">
                            <div class="console-field"><label for="apptName">Your name</label><input id="apptName" type="text" placeholder="Full name"></div>
                            <div class="console-field"><label for="apptPhone">Phone number</label><input id="apptPhone" type="tel" placeholder="+91"></div>
                        </div>

                        <button class="console-btn console-btn-primary" id="reserveBtn" type="button">Request This Slot</button>

                        <div class="console-result-box" id="apptResult">
                            <span class="console-status-badge console-status-ok"><span class="sw"></span>Slot selected</span>
                            <h4 id="apptSummaryTitle">&nbsp;</h4>
                            <p id="apptSummaryBody">&nbsp;</p>
                            <p class="console-fine">This reserves your preferred slot &mdash; it is not yet confirmed. Our team will call or WhatsApp you to lock it in, or you can confirm directly below.</p>
                            <div style="margin-top:14px; display:flex; gap:10px; flex-wrap:wrap;">
                                <a class="console-btn console-btn-primary" href="contact">Confirm via Enquiry Form</a>
                                <a class="console-btn console-btn-outline" href="https://wa.me/917844819819">Confirm on WhatsApp</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="console-section-head">
                    <p class="console-eyebrow">What to expect</p>
                    <h2>Your First Consultation</h2>
                </div>
                <div class="console-card-grid">
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 3"/></svg></div>
                        <h3>15&ndash;20 minutes</h3>
                        <p>A focused conversation about your travel purpose, timeline and what documents you'll likely need.</p>
                    </div>
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M4 12l5 5L20 6"/></svg></div>
                        <h3>No obligation</h3>
                        <p>An initial consultation helps you understand your options &mdash; you decide afterward whether to proceed with us.</p>
                    </div>
                    <div class="console-tcard">
                        <div class="icon"><svg viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round"><path d="M7 3h7l5 5v13a1 1 0 0 1-1 1H7a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1z"/><path d="M14 3v5h5"/></svg></div>
                        <h3>Bring what you have</h3>
                        <p>Passport copy and any documents already in hand help us give you more specific guidance on the spot.</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="console-cta-band">
                    <div class="console-cta-inner">
                        <div>
                            <h3>Prefer To Just Call?</h3>
                            <p>Our team is available Monday&ndash;Friday, 9:00 AM &ndash; 5:00 PM.</p>
                        </div>
                        <div class="console-cta-buttons">
                            <a class="console-btn console-btn-primary" href="tel:+917844819819">Call +91 78448 19819</a>
                            <a class="console-btn console-btn-outline-dark" href="https://wa.me/917844819819">WhatsApp Us</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

<script>
(function(){
  var dayPicker = document.getElementById('dayPicker');
  var timePicker = document.getElementById('timePicker');
  var selectedDay = null, selectedTime = null;

  var dayNames = ['Mon','Tue','Wed','Thu','Fri','Sat'];
  var today = new Date();
  var days = [];
  var cursor = new Date(today);
  while(days.length < 6){
    if(cursor.getDay() !== 0){ days.push(new Date(cursor)); } // skip Sundays
    cursor.setDate(cursor.getDate()+1);
  }

  days.forEach(function(d, i){
    var btn = document.createElement('button');
    btn.type = 'button';
    btn.className = 'console-chip-toggle console-day-btn';
    btn.innerHTML = '<div style="font-family:monospace; font-size:10px; opacity:.75;">' + dayNames[d.getDay()===0?6:d.getDay()-1] + '</div><div style="font-weight:600; margin-top:2px;">' + d.getDate() + '</div>';
    btn.addEventListener('click', function(){
      Array.prototype.forEach.call(dayPicker.children, function(c){ c.classList.remove('active'); });
      btn.classList.add('active');
      selectedDay = d;
    });
    dayPicker.appendChild(btn);
    if(i===0){ btn.classList.add('active'); selectedDay = d; }
  });

  var slots = ['10:00 AM','11:00 AM','12:00 PM','2:00 PM','3:00 PM','4:00 PM'];
  slots.forEach(function(t, i){
    var btn = document.createElement('button');
    btn.type = 'button';
    btn.className = 'console-chip-toggle';
    btn.textContent = t;
    btn.addEventListener('click', function(){
      Array.prototype.forEach.call(timePicker.children, function(c){ c.classList.remove('active'); });
      btn.classList.add('active');
      selectedTime = t;
    });
    timePicker.appendChild(btn);
    if(i===1){ btn.classList.add('active'); selectedTime = t; }
  });

  document.getElementById('reserveBtn').addEventListener('click', function(){
    var service = document.getElementById('serviceType').value;
    var mode = document.getElementById('apptMode').value;
    var name = document.getElementById('apptName').value || 'there';
    var dateStr = selectedDay ? selectedDay.toLocaleDateString('en-IN', {weekday:'long', day:'numeric', month:'long'}) : '';
    var box = document.getElementById('apptResult');
    box.classList.add('show');
    document.getElementById('apptSummaryTitle').textContent = 'Hi ' + name + ', here is your requested slot';
    document.getElementById('apptSummaryBody').innerHTML = service + ' &middot; ' + mode + ' &middot; ' + dateStr + ' at ' + selectedTime;
    box.scrollIntoView({behavior:'smooth', block:'nearest'});
  });
})();
</script>

<?php include __DIR__ . '/includes/footer.php'; ?>
