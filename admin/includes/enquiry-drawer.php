<?php
require_once __DIR__ . '/../../includes/countries-data.php';
$crmUsers = $pdo->query('SELECT name, role FROM users ORDER BY name')->fetchAll(PDO::FETCH_ASSOC);
$crmDocCategories = CRM_DOC_CATEGORIES;
?>
<div class="crm-drawer-overlay" id="crmEnquiryDrawer">
    <div class="crm-drawer">
        <div class="crm-drawer-header">
            <h2>New Enquiry</h2>
            <button type="button" class="crm-drawer-close" id="crmDrawerClose"><i class="fa-solid fa-xmark"></i></button>
        </div>
        <div class="crm-drawer-body">
            <form id="crmEnquiryForm">
                <div class="crm-form-error" id="crmFormError" style="display:none;background:var(--c-red-bg);color:var(--c-red);padding:10px 14px;border-radius:8px;font-size:13px;margin-bottom:16px;"></div>

                <div class="crm-form-section">
                    <h4><i class="fa-solid fa-user"></i> Customer Information</h4>
                    <div class="crm-form-grid">
                        <div class="crm-form-field"><label>Full Name *</label><input type="text" name="full_name" required></div>
                        <div class="crm-form-field"><label>Mobile Number *</label><input type="tel" name="mobile" required></div>
                        <div class="crm-form-field"><label>WhatsApp Number</label><input type="tel" name="whatsapp_number"></div>
                        <div class="crm-form-field"><label>Email *</label><input type="email" name="email" required></div>
                        <div class="crm-form-field"><label>Date of Birth</label><input type="date" name="date_of_birth"></div>
                        <div class="crm-form-field"><label>Gender</label>
                            <select name="gender"><option value="">Select</option><option>Male</option><option>Female</option><option>Other</option></select>
                        </div>
                        <div class="crm-form-field"><label>Nationality</label><input type="text" name="nationality" list="crmCountryListDrawer"></div>
                        <div class="crm-form-field"><label>Passport Number</label><input type="text" name="passport_number"></div>
                        <div class="crm-form-field"><label>Passport Expiry</label><input type="date" name="passport_expiry"></div>
                        <div class="crm-form-field"><label>Current City</label><input type="text" name="current_city"></div>
                        <div class="crm-form-field"><label>Country of Residence</label><input type="text" name="country_residence" list="crmCountryListDrawer"></div>
                    </div>
                </div>

                <div class="crm-form-section">
                    <h4><i class="fa-solid fa-passport"></i> Visa Requirement</h4>
                    <div class="crm-form-grid">
                        <div class="crm-form-field"><label>Destination Country *</label><input type="text" name="destination_country" list="crmCountryListDrawer" required></div>
                        <div class="crm-form-field"><label>Visa Category *</label>
                            <select name="visa_category" required><option value="">Select category</option><?php foreach (CRM_VISA_CATEGORIES as $c): ?><option><?php echo $c; ?></option><?php endforeach; ?></select>
                        </div>
                        <div class="crm-form-field"><label>Visa Type *</label><input type="text" name="visa_type" placeholder="e.g. B1/B2 Tourist Visa" required></div>
                        <div class="crm-form-field"><label>Purpose of Travel</label><input type="text" name="purpose"></div>
                        <div class="crm-form-field"><label>Intended Travel Date *</label><input type="date" name="travel_date" required></div>
                        <div class="crm-form-field"><label>Expected Stay Duration</label><input type="text" name="expected_stay_duration" placeholder="e.g. 14 days"></div>
                        <div class="crm-form-field"><label>Number of Travellers *</label><input type="number" name="travellers" min="1" value="1" required></div>
                        <div class="crm-form-field"><label>Previous Visa History</label><input type="text" name="previous_visa_history" placeholder="e.g. USA 2022, UK 2019"></div>
                        <div class="crm-form-field"><label>Previous Refusal</label>
                            <select name="previous_refusal"><option value="">Select</option><option>No</option><option>Yes</option></select>
                        </div>
                        <div class="crm-form-field"><label>Urgency</label>
                            <select name="urgency"><option>Normal</option><option>Urgent</option><option>Immediate</option></select>
                        </div>
                    </div>
                </div>

                <div class="crm-form-section">
                    <h4><i class="fa-solid fa-plane-departure"></i> Travel Information</h4>
                    <div class="crm-form-grid">
                        <div class="crm-form-field"><label>Departure City</label><input type="text" name="departure_city"></div>
                        <div class="crm-form-field"><label>Arrival City</label><input type="text" name="arrival_city"></div>
                        <div class="crm-form-field"><label>Flight Status</label>
                            <select name="flight_status"><option>Not Booked</option><option>Booked</option><option>Confirmed</option></select>
                        </div>
                        <div class="crm-form-field"><label>Hotel Required</label>
                            <select name="hotel_required"><option>No</option><option>Yes</option></select>
                        </div>
                        <div class="crm-form-field"><label>Travel Insurance Required</label>
                            <select name="insurance_required"><option>No</option><option>Yes</option></select>
                        </div>
                        <div class="crm-form-field"><label>Invitation Letter</label>
                            <select name="invitation_letter"><option>Not Applicable</option><option>Yes</option><option>No</option></select>
                        </div>
                        <div class="crm-form-field"><label>Sponsorship</label>
                            <select name="sponsorship"><option>Self-Sponsored</option><option>Employer-Sponsored</option><option>Family-Sponsored</option><option>Other</option></select>
                        </div>
                        <div class="crm-form-field crm-form-field-full"><label>Accommodation Details</label><input type="text" name="accommodation_details"></div>
                    </div>
                </div>

                <div class="crm-form-section">
                    <h4><i class="fa-solid fa-bullseye"></i> Lead Information</h4>
                    <div class="crm-form-grid">
                        <div class="crm-form-field"><label>Lead Source *</label>
                            <select name="source" required><?php foreach (CRM_SOURCES as $s): ?><option><?php echo $s; ?></option><?php endforeach; ?></select>
                        </div>
                        <div class="crm-form-field"><label>Campaign</label><input type="text" name="campaign"></div>
                        <div class="crm-form-field"><label>Referral Name</label><input type="text" name="referral_name"></div>
                        <div class="crm-form-field"><label>Partner</label><input type="text" name="partner"></div>
                        <div class="crm-form-field"><label>Assigned Sales Executive</label>
                            <select name="assigned_to"><option value="">Unassigned</option><?php foreach ($crmUsers as $u): ?><option><?php echo htmlspecialchars($u['name']); ?></option><?php endforeach; ?></select>
                        </div>
                        <div class="crm-form-field"><label>Assigned Visa Consultant</label>
                            <select name="visa_consultant"><option value="">Unassigned</option><?php foreach ($crmUsers as $u): ?><option><?php echo htmlspecialchars($u['name']); ?></option><?php endforeach; ?></select>
                        </div>
                        <div class="crm-form-field"><label>Priority</label>
                            <select name="priority"><option>Medium</option><option>High</option><option>Low</option></select>
                        </div>
                        <div class="crm-form-field"><label>Expected Revenue (₹)</label><input type="number" name="estimated_value" min="0" step="100"></div>
                        <div class="crm-form-field"><label>Estimated Conversion Probability (%)</label><input type="number" name="conversion_probability" min="0" max="100"></div>
                    </div>
                </div>

                <div class="crm-form-section">
                    <h4><i class="fa-solid fa-note-sticky"></i> Notes</h4>
                    <div class="crm-form-field crm-form-field-full">
                        <textarea name="message" rows="4" placeholder="Add customer requirements, special instructions or internal notes..."></textarea>
                    </div>
                </div>

                <div class="crm-form-section">
                    <h4><i class="fa-solid fa-paperclip"></i> Upload Supporting Documents</h4>
                    <div class="crm-doc-grid">
                        <?php foreach ($crmDocCategories as $i => $cat): $field = 'doc_' . $i; ?>
                        <div class="crm-doc-box" data-category="<?php echo htmlspecialchars($cat); ?>">
                            <div class="crm-doc-drop">
                                <i class="fa-solid fa-file"></i>
                                <span><?php echo htmlspecialchars($cat); ?></span>
                            </div>
                            <input type="file" name="<?php echo $field; ?>[]" accept=".pdf,.jpg,.jpeg,.png" <?php echo $cat === 'Other Documents' ? 'multiple' : ''; ?> hidden>
                            <div class="crm-doc-list"></div>
                            <?php if ($cat === 'Passport Scan Copy'): ?>
                            <p class="crm-doc-note">Please upload a clear printer/scanner-generated passport scan. Mobile photocopies or unclear images may not be accepted.</p>
                            <?php endif; ?>
                        </div>
                        <?php endforeach; ?>
                    </div>
                </div>
            </form>
        </div>
        <div class="crm-drawer-footer">
            <button type="button" class="crm-btn crm-btn-ghost" id="crmDrawerCancel">Cancel</button>
            <button type="button" class="crm-btn crm-btn-primary" id="crmDrawerSubmit"><span>Create Enquiry</span></button>
        </div>
    </div>
</div>
<datalist id="crmCountryListDrawer">
    <?php foreach ($VISA_AGENCY_COUNTRIES as $c): ?><option value="<?php echo htmlspecialchars($c['name']); ?>"><?php endforeach; ?>
</datalist>

<script>
(function () {
    var overlay = document.getElementById('crmEnquiryDrawer');
    var form = document.getElementById('crmEnquiryForm');
    var closeBtn = document.getElementById('crmDrawerClose');
    var cancelBtn = document.getElementById('crmDrawerCancel');
    var submitBtn = document.getElementById('crmDrawerSubmit');
    var errorBox = document.getElementById('crmFormError');
    if (!overlay) { return; }

    window.crmOpenEnquiryDrawer = function () {
        overlay.hidden = false;
        requestAnimationFrame(function () { overlay.classList.add('is-open', 'is-visible'); });
        document.body.style.overflow = 'hidden';
    };
    function closeDrawer() {
        overlay.classList.remove('is-visible');
        document.body.style.overflow = '';
        setTimeout(function () { overlay.classList.remove('is-open'); }, 250);
    }
    closeBtn.addEventListener('click', closeDrawer);
    cancelBtn.addEventListener('click', closeDrawer);

    var MAX_BYTES = 5 * 1024 * 1024;
    var ALLOWED = ['pdf', 'jpg', 'jpeg', 'png'];
    document.querySelectorAll('.crm-doc-box').forEach(function (box) {
        box._files = [];
        var input = box.querySelector('input[type="file"]');
        var drop = box.querySelector('.crm-doc-drop');
        var list = box.querySelector('.crm-doc-list');
        var multi = input.multiple;

        drop.addEventListener('click', function () { input.click(); });
        drop.addEventListener('dragover', function (e) { e.preventDefault(); box.classList.add('is-dragover'); });
        drop.addEventListener('dragleave', function () { box.classList.remove('is-dragover'); });
        drop.addEventListener('drop', function (e) { e.preventDefault(); box.classList.remove('is-dragover'); handle(e.dataTransfer.files); });
        input.addEventListener('change', function () { handle(input.files); });

        function render() {
            list.innerHTML = '';
            box._files.forEach(function (f, idx) {
                var chip = document.createElement('div');
                chip.className = 'crm-doc-chip';
                chip.innerHTML = '<span class="chip-name">' + f.name.replace(/</g, '&lt;') + '</span><button type="button" class="chip-remove"><i class="fa-solid fa-xmark"></i></button>';
                chip.querySelector('.chip-remove').addEventListener('click', function () { box._files.splice(idx, 1); sync(); render(); });
                list.appendChild(chip);
            });
        }
        function sync() {
            var dt = new DataTransfer();
            box._files.forEach(function (f) { dt.items.add(f); });
            input.files = dt.files;
        }
        function handle(files) {
            var arr = Array.prototype.slice.call(files);
            if (!multi) { box._files = []; }
            arr.forEach(function (f) {
                var ext = f.name.split('.').pop().toLowerCase();
                if (ALLOWED.indexOf(ext) === -1 || f.size > MAX_BYTES) { return; }
                box._files.push(f);
            });
            sync();
            render();
        }
    });

    submitBtn.addEventListener('click', function () {
        if (!form.reportValidity()) { return; }
        submitBtn.disabled = true;
        submitBtn.querySelector('span').textContent = 'Creating...';
        errorBox.style.display = 'none';
        var fd = new FormData(form);
        fetch('enquiry-create.php', { method: 'POST', body: fd })
            .then(function (r) { return r.json(); })
            .then(function (data) {
                submitBtn.disabled = false;
                submitBtn.querySelector('span').textContent = 'Create Enquiry';
                if (data.success) {
                    window.crmToast('Enquiry ' + data.enquiry_ref + ' created.');
                    setTimeout(function () { window.location = 'enquiry.php?ref=' + encodeURIComponent(data.enquiry_ref); }, 500);
                } else {
                    errorBox.style.display = 'block';
                    errorBox.textContent = data.message || 'Please check the form and try again.';
                }
            })
            .catch(function () {
                submitBtn.disabled = false;
                submitBtn.querySelector('span').textContent = 'Create Enquiry';
                errorBox.style.display = 'block';
                errorBox.textContent = 'Something went wrong. Please try again.';
            });
    });
})();
</script>
