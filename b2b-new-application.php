<?php
$PP_PAGE_TITLE = 'New Visa Application';
$PP_ACTIVE_NAV = 'applications';
require __DIR__ . '/includes/partner-layout-top.php';
require_once __DIR__ . '/includes/countries-data.php';
?>
<div class="pp-page-header">
    <div>
        <h1 class="pp-page-title">New Visa Application</h1>
        <p class="pp-page-subtitle">Submit a visa case on behalf of your client. It lands directly in our case pipeline.</p>
    </div>
</div>

<div class="pp-card" style="max-width:760px;">
    <div class="b2b-form-error" id="ppNewAppError" role="alert" hidden></div>
    <form id="ppNewAppForm" novalidate>
        <div class="b2b-reg-grid">
            <div class="b2b-field b2b-field-full">
                <label for="ppFullName">Traveller Full Name *</label>
                <input type="text" id="ppFullName" name="full_name" required maxlength="150">
                <span class="b2b-error" data-error-for="full_name"></span>
            </div>
            <div class="b2b-field">
                <label for="ppEmail">Traveller Email *</label>
                <input type="email" id="ppEmail" name="email" required>
                <span class="b2b-error" data-error-for="email"></span>
            </div>
            <div class="b2b-field">
                <label for="ppMobile">Traveller Mobile *</label>
                <input type="text" id="ppMobile" name="mobile" required maxlength="10" placeholder="10-digit mobile number">
                <span class="b2b-error" data-error-for="mobile"></span>
            </div>
            <div class="b2b-field">
                <label for="ppPassport">Passport Number</label>
                <input type="text" id="ppPassport" name="passport_number" maxlength="20">
            </div>
            <div class="b2b-field">
                <label for="ppNationality">Nationality</label>
                <input type="text" id="ppNationality" name="nationality" maxlength="60">
            </div>
            <div class="b2b-field">
                <label for="ppCategory">Service / Visa Category *</label>
                <select id="ppCategory" name="visa_category" required>
                    <option value="">Select category</option>
                    <?php foreach (CRM_VISA_CATEGORIES as $cat): ?>
                    <option value="<?php echo htmlspecialchars($cat); ?>"><?php echo htmlspecialchars($cat); ?></option>
                    <?php endforeach; ?>
                </select>
                <span class="b2b-error" data-error-for="visa_category"></span>
            </div>
            <div class="b2b-field">
                <label for="ppDestination">Destination Country *</label>
                <input type="text" id="ppDestination" name="destination_country" required list="ppCountryList" autocomplete="off">
                <datalist id="ppCountryList">
                    <?php foreach ($VISA_AGENCY_COUNTRIES as $c): ?><option value="<?php echo htmlspecialchars($c['name']); ?>"><?php endforeach; ?>
                </datalist>
                <span class="b2b-error" data-error-for="destination_country"></span>
            </div>
            <div class="b2b-field">
                <label for="ppVisaType">Visa Type *</label>
                <input type="text" id="ppVisaType" name="visa_type" required maxlength="80" placeholder="e.g. Tourist, B1/B2, Student">
                <span class="b2b-error" data-error-for="visa_type"></span>
            </div>
            <div class="b2b-field">
                <label for="ppTravelDate">Intended Travel Date *</label>
                <input type="date" id="ppTravelDate" name="travel_date" required>
                <span class="b2b-error" data-error-for="travel_date"></span>
            </div>
            <div class="b2b-field">
                <label for="ppTravellers">Number of Travellers *</label>
                <input type="number" id="ppTravellers" name="travellers" required min="1" max="50" value="1">
            </div>
            <div class="b2b-field b2b-field-full">
                <label for="ppMessage">Notes for our Visa Team</label>
                <textarea id="ppMessage" name="message" rows="4" maxlength="1000" placeholder="Any special instructions, prior visa history, urgency, etc."></textarea>
            </div>
        </div>
        <button type="submit" class="b2b-submit-btn" id="ppNewAppSubmit">
            <span class="b2b-btn-label">Submit Application</span>
            <span class="b2b-btn-spinner" hidden></span>
        </button>
    </form>

    <div class="pp-success" id="ppNewAppSuccess" hidden>
        <i class="fa-solid fa-circle-check" aria-hidden="true"></i>
        <h3>Application Submitted</h3>
        <p>Reference <strong id="ppNewAppRef"></strong> has been created and assigned to our visa team.</p>
        <a href="b2b-applications.php" class="b2b-submit-btn" style="text-decoration:none;display:inline-flex;width:auto;padding:12px 26px;">View My Applications</a>
    </div>
</div>

<script src="assets/js/b2b-new-application.js"></script>
<?php require __DIR__ . '/includes/partner-layout-bottom.php'; ?>
