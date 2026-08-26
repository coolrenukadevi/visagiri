<?php
ob_start(); // buffer output so header()-based redirects below still work even if the host has output_buffering off
$ADMIN_PAGE_TITLE = 'New Forex Request';
$ADMIN_ACTIVE_NAV = 'forex-new';
$ADMIN_BREADCRUMB = ['CRM', 'Forex', 'New Request'];
require __DIR__ . '/includes/layout-top.php';

if (!forex_can_create_request()) {
    http_response_code(403);
    echo '<div class="crm-card">You do not have permission to create forex requests.</div>';
    require __DIR__ . '/includes/layout-bottom.php';
    exit;
}

$error = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $fullName = trim($_POST['full_name'] ?? '');
    $mobile = trim($_POST['mobile'] ?? '');
    $countryVisit = trim($_POST['country_visit'] ?? '');
    $visaStatus = trim($_POST['visa_status'] ?? '');
    $currencyCode = strtoupper(trim($_POST['currency_code'] ?? ''));
    $amountRequired = filter_var($_POST['amount_required'] ?? '', FILTER_VALIDATE_FLOAT);

    if ($fullName === '') $error = 'Please enter the customer\'s full name.';
    elseif ($mobile === '') $error = 'Please enter a mobile number.';
    elseif ($countryVisit === '') $error = 'Please select a country of visit.';
    elseif (!in_array($visaStatus, FOREX_VISA_STATUSES, true)) $error = 'Please select a visa status.';
    elseif ($currencyCode === '') $error = 'Please select the currency required.';
    elseif ($amountRequired === false || $amountRequired <= 0) $error = 'Please enter a valid amount required.';

    if ($error === '') {
        $now = gmdate('c');
        $ref = forex_generate_ref($pdo);

        $insert = $pdo->prepare("INSERT INTO forex_requests (
            forex_ref, status, full_name, date_of_birth, mobile, email, address, city, state, pin_code,
            pan_number, passport_number, passport_issue_date, passport_expiry, nationality,
            country_visit, cities_visit, purpose, departure_date, return_date, duration_of_stay,
            airline, flight_number, hotel_name, hotel_location, traveller_type,
            visa_status,
            currency_code, amount_required, approx_inr, preferred_delivery_date, collection_location, delivery_method,
            assigned_to, created_by, created_at, updated_at
        ) VALUES (
            :forex_ref, 'New Request', :full_name, :dob, :mobile, :email, :address, :city, :state, :pin_code,
            :pan_number, :passport_number, :passport_issue_date, :passport_expiry, :nationality,
            :country_visit, :cities_visit, :purpose, :departure_date, :return_date, :duration_of_stay,
            :airline, :flight_number, :hotel_name, :hotel_location, :traveller_type,
            :visa_status,
            :currency_code, :amount_required, :approx_inr, :preferred_delivery_date, :collection_location, :delivery_method,
            :assigned_to, :created_by, :created_at, :updated_at
        )");
        $insert->execute([
            'forex_ref' => $ref,
            'full_name' => $fullName,
            'dob' => trim($_POST['date_of_birth'] ?? '') ?: null,
            'mobile' => $mobile,
            'email' => trim($_POST['email'] ?? '') ?: null,
            'address' => trim($_POST['address'] ?? '') ?: null,
            'city' => trim($_POST['city'] ?? '') ?: null,
            'state' => trim($_POST['state'] ?? '') ?: null,
            'pin_code' => trim($_POST['pin_code'] ?? '') ?: null,
            'pan_number' => strtoupper(trim($_POST['pan_number'] ?? '')) ?: null,
            'passport_number' => strtoupper(trim($_POST['passport_number'] ?? '')) ?: null,
            'passport_issue_date' => trim($_POST['passport_issue_date'] ?? '') ?: null,
            'passport_expiry' => trim($_POST['passport_expiry'] ?? '') ?: null,
            'nationality' => trim($_POST['nationality'] ?? '') ?: null,
            'country_visit' => $countryVisit,
            'cities_visit' => trim($_POST['cities_visit'] ?? '') ?: null,
            'purpose' => trim($_POST['purpose'] ?? '') ?: null,
            'departure_date' => trim($_POST['departure_date'] ?? '') ?: null,
            'return_date' => trim($_POST['return_date'] ?? '') ?: null,
            'duration_of_stay' => trim($_POST['duration_of_stay'] ?? '') ?: null,
            'airline' => trim($_POST['airline'] ?? '') ?: null,
            'flight_number' => trim($_POST['flight_number'] ?? '') ?: null,
            'hotel_name' => trim($_POST['hotel_name'] ?? '') ?: null,
            'hotel_location' => trim($_POST['hotel_location'] ?? '') ?: null,
            'traveller_type' => in_array($_POST['traveller_type'] ?? '', FOREX_TRAVELLER_TYPES, true) ? $_POST['traveller_type'] : null,
            'visa_status' => $visaStatus,
            'currency_code' => $currencyCode,
            'amount_required' => $amountRequired,
            'approx_inr' => filter_var($_POST['approx_inr'] ?? '', FILTER_VALIDATE_FLOAT) ?: null,
            'preferred_delivery_date' => trim($_POST['preferred_delivery_date'] ?? '') ?: null,
            'collection_location' => trim($_POST['collection_location'] ?? '') ?: null,
            'delivery_method' => in_array($_POST['delivery_method'] ?? '', FOREX_DELIVERY_METHODS, true) ? $_POST['delivery_method'] : null,
            'assigned_to' => trim($_POST['assigned_to'] ?? '') ?: admin_name(),
            'created_by' => admin_name(),
            'created_at' => $now,
            'updated_at' => $now,
        ]);
        $requestId = (int) $pdo->lastInsertId();

        // Auto-build the document checklist from the country rule for this
        // destination (falls back to a sensible default set if no rule
        // exists yet for this country).
        $ruleStmt = $pdo->prepare('SELECT * FROM forex_country_rules WHERE country = ?');
        $ruleStmt->execute([$countryVisit]);
        $rule = $ruleStmt->fetch(PDO::FETCH_ASSOC);

        $needsDeclaration = in_array($visaStatus, FOREX_VISA_STATUSES_NEEDING_DECLARATION, true)
            || ($rule && (int) $rule['requires_declaration'] === 1);
        $needsVisaCopy = $visaStatus === 'Visa Available' || ($rule ? (int) $rule['requires_visa_copy'] === 1 : true) && !$needsDeclaration;

        $checklist = [];
        if (!$rule || $rule['requires_passport']) $checklist[] = 'Passport';
        if (!$rule || $rule['requires_pan']) $checklist[] = 'PAN';
        if (!$rule || $rule['requires_air_ticket']) $checklist[] = 'AirTicket';
        if (!$rule || $rule['requires_hotel']) $checklist[] = 'Hotel';
        if ($needsVisaCopy) $checklist[] = 'Visa';
        if ($needsDeclaration) $checklist[] = 'Declaration';

        $docStmt = $pdo->prepare("INSERT INTO forex_documents (forex_request_id, doc_type, status) VALUES (?, ?, 'Not Uploaded')");
        foreach (array_unique($checklist) as $docType) {
            $docStmt->execute([$requestId, $docType]);
        }

        if ($needsDeclaration) {
            $tplStmt = $pdo->query('SELECT * FROM forex_declaration_templates WHERE is_active = 1 ORDER BY id DESC LIMIT 1');
            $tpl = $tplStmt->fetch(PDO::FETCH_ASSOC);
            if ($tpl) {
                $pdo->prepare('INSERT INTO forex_declarations (forex_request_id, template_id, template_version, customer_name, passport_number, destination_country, declaration_date) VALUES (?, ?, ?, ?, ?, ?, ?)')
                    ->execute([$requestId, $tpl['id'], $tpl['version'], $fullName, trim($_POST['passport_number'] ?? ''), $countryVisit, gmdate('Y-m-d')]);
            }
        }

        forex_log_status_change($pdo, $requestId, null, 'New Request', admin_name(), 'Forex request created.');
        forex_log_audit($pdo, $requestId, admin_name(), admin_role(), 'Created forex request ' . $ref);
        forex_notify($pdo, null, 'forex_new_request', "New forex request $ref created for $fullName ($countryVisit, $currencyCode " . number_format($amountRequired, 2) . ').', $requestId);

        $newRequestStmt = $pdo->prepare('SELECT * FROM forex_requests WHERE id = ?');
        $newRequestStmt->execute([$requestId]);
        $newRequest = $newRequestStmt->fetch(PDO::FETCH_ASSOC);
        if ($newRequest) {
            $docLabels = array_map(fn($t) => FOREX_DOC_TYPES[$t] ?? $t, array_unique($checklist));
            forex_notify_customer(
                $pdo,
                $newRequest,
                "Forex Request Received — $ref",
                "Dear $fullName,\n\nThank you for your foreign currency purchase request with VisaAgency.in.\n\n" .
                "Reference Number: $ref\nDestination: $countryVisit\nCurrency Required: $currencyCode " . number_format($amountRequired, 2) . "\n\n" .
                "Documents required:\n- " . implode("\n- ", $docLabels) . "\n\n" .
                "Please upload or submit these documents so we can proceed. You can track your request anytime at https://visaagency.in/forex-track using this reference number and your registered mobile number.\n\n" .
                "Regards,\nVisaAgency.in"
            );
        }

        header('Location: forex-request.php?ref=' . urlencode($ref));
        exit;
    }
}

$currencies = forex_currencies($pdo);
$countryOptions = $pdo->query('SELECT name, flag FROM countries WHERE is_active = 1 ORDER BY name ASC')->fetchAll(PDO::FETCH_ASSOC);
?>
<div class="crm-page-header">
    <div>
        <h1 class="crm-page-title">New Forex Request</h1>
        <p class="crm-page-subtitle">Customer &amp; travel intake — documents, quotation and compliance are handled after the request is created.</p>
    </div>
</div>

<?php if ($error): ?><div class="crm-card" style="background:var(--c-red-bg);color:var(--c-red);"><?php echo htmlspecialchars($error); ?></div><?php endif; ?>

<div class="crm-card">
    <div class="forex-step-indicator" id="forexStepIndicator">
        <div class="forex-step-dot is-active" data-step-dot="1"><span>1</span> Customer</div>
        <div class="forex-step-dot" data-step-dot="2"><span>2</span> Travel</div>
        <div class="forex-step-dot" data-step-dot="3"><span>3</span> Visa Status</div>
        <div class="forex-step-dot" data-step-dot="4"><span>4</span> Forex Requirement</div>
    </div>

    <form method="post" id="forexRequestForm">
        <!-- Step 1: Customer -->
        <div class="forex-step" data-step="1">
            <div class="crm-form-section">
                <h4><i class="fa-solid fa-magnifying-glass"></i> Search Existing Customer</h4>
                <div class="crm-form-grid">
                    <div class="crm-form-field crm-form-field-full">
                        <label>Search by name, email, mobile or passport number</label>
                        <input type="text" id="fxCustomerSearch" placeholder="Start typing to search...">
                        <div id="fxCustomerResults" class="forex-search-results" hidden></div>
                    </div>
                </div>
            </div>
            <div class="crm-form-section">
                <h4><i class="fa-solid fa-user"></i> Personal Information</h4>
                <div class="crm-form-grid">
                    <div class="crm-form-field"><label>Full Name *</label><input type="text" name="full_name" id="fxFullName" required></div>
                    <div class="crm-form-field"><label>Date of Birth</label><input type="date" name="date_of_birth" id="fxDob"></div>
                    <div class="crm-form-field"><label>Mobile Number *</label><input type="text" name="mobile" id="fxMobile" required></div>
                    <div class="crm-form-field"><label>Email Address</label><input type="email" name="email" id="fxEmail"></div>
                    <div class="crm-form-field crm-form-field-full"><label>Address</label><input type="text" name="address" id="fxAddress"></div>
                    <div class="crm-form-field"><label>City</label><input type="text" name="city" id="fxCity"></div>
                    <div class="crm-form-field"><label>State</label><input type="text" name="state" id="fxState"></div>
                    <div class="crm-form-field"><label>PIN Code</label><input type="text" name="pin_code" id="fxPinCode" maxlength="10"></div>
                    <div class="crm-form-field"><label>Nationality</label><input type="text" name="nationality" id="fxNationality" value="Indian"></div>
                    <div class="crm-form-field"><label>PAN Number</label><input type="text" name="pan_number" id="fxPan" maxlength="10"></div>
                </div>
            </div>
            <div class="crm-form-section">
                <h4><i class="fa-solid fa-passport"></i> Passport Information</h4>
                <div class="crm-form-grid">
                    <div class="crm-form-field"><label>Passport Number</label><input type="text" name="passport_number" id="fxPassportNumber"></div>
                    <div class="crm-form-field"><label>Passport Issue Date</label><input type="date" name="passport_issue_date" id="fxPassportIssue"></div>
                    <div class="crm-form-field"><label>Passport Expiry Date</label><input type="date" name="passport_expiry" id="fxPassportExpiry"></div>
                </div>
            </div>
        </div>

        <!-- Step 2: Travel -->
        <div class="forex-step" data-step="2" hidden>
            <div class="crm-form-section">
                <h4><i class="fa-solid fa-plane"></i> Travel Details</h4>
                <div class="crm-form-grid">
                    <div class="crm-form-field"><label>Country of Visit *</label>
                        <select name="country_visit" id="fxCountryVisit" required>
                            <option value="">Select country</option>
                            <?php foreach ($countryOptions as $c): ?><option value="<?php echo htmlspecialchars($c['name']); ?>"><?php echo htmlspecialchars(($c['flag'] ? $c['flag'] . ' ' : '') . $c['name']); ?></option><?php endforeach; ?>
                        </select>
                    </div>
                    <div class="crm-form-field"><label>Cities to Visit</label><input type="text" name="cities_visit" id="fxCitiesVisit"></div>
                    <div class="crm-form-field"><label>Purpose of Travel</label>
                        <select name="purpose" id="fxPurpose">
                            <option value="">Select purpose</option>
                            <?php foreach (FOREX_TRAVEL_PURPOSES as $p): ?><option value="<?php echo htmlspecialchars($p); ?>"><?php echo htmlspecialchars($p); ?></option><?php endforeach; ?>
                        </select>
                    </div>
                    <div class="crm-form-field"><label>Traveller Type</label>
                        <select name="traveller_type" id="fxTravellerType">
                            <?php foreach (FOREX_TRAVELLER_TYPES as $t): ?><option value="<?php echo htmlspecialchars($t); ?>"><?php echo htmlspecialchars($t); ?></option><?php endforeach; ?>
                        </select>
                    </div>
                    <div class="crm-form-field"><label>Departure Date</label><input type="date" name="departure_date" id="fxDeparture"></div>
                    <div class="crm-form-field"><label>Return Date</label><input type="date" name="return_date" id="fxReturn"></div>
                    <div class="crm-form-field"><label>Duration of Stay</label><input type="text" name="duration_of_stay" id="fxDuration" placeholder="e.g. 7 days"></div>
                    <div class="crm-form-field"><label>Airline</label><input type="text" name="airline" id="fxAirline"></div>
                    <div class="crm-form-field"><label>Flight Number</label><input type="text" name="flight_number" id="fxFlightNumber"></div>
                    <div class="crm-form-field"><label>Hotel Name</label><input type="text" name="hotel_name" id="fxHotelName"></div>
                    <div class="crm-form-field"><label>Hotel Location</label><input type="text" name="hotel_location" id="fxHotelLocation"></div>
                </div>
            </div>
        </div>

        <!-- Step 3: Visa Status -->
        <div class="forex-step" data-step="3" hidden>
            <div class="crm-form-section">
                <h4><i class="fa-solid fa-stamp"></i> Visa Status</h4>
                <div class="crm-form-grid">
                    <div class="crm-form-field crm-form-field-full"><label>Visa Status *</label>
                        <select name="visa_status" id="fxVisaStatus" required>
                            <option value="">Select visa status</option>
                            <?php foreach (FOREX_VISA_STATUSES as $v): ?><option value="<?php echo htmlspecialchars($v); ?>"><?php echo htmlspecialchars($v); ?></option><?php endforeach; ?>
                        </select>
                    </div>
                </div>
                <div id="fxVisaAvailableNote" class="compliance-note" style="margin-top:14px;" hidden>
                    A Visa Copy will be required in this request's document checklist. Upload it from the request page after creation.
                </div>
                <div id="fxVisaNotAvailableNote" class="compliance-note" style="margin-top:14px;background:var(--c-red-bg);color:var(--c-red);" hidden>
                    Forex delivery cannot be completed until the required visa documentation is verified, unless the destination is confirmed as Visa on Arrival, Visa-Free, or otherwise eligible under applicable rules.
                </div>
                <div id="fxDeclarationNote" class="compliance-note" style="margin-top:14px;" hidden>
                    <strong>Visa Not Applicable — Customer Declaration Required.</strong> A signed Visa-on-Arrival/Visa-Free declaration will be required instead of a visa copy. You'll be able to generate, print and upload the signed declaration from the request page after creation. A typed name does not satisfy this requirement — it must be hand-signed.
                </div>
            </div>
        </div>

        <!-- Step 4: Forex Requirement -->
        <div class="forex-step" data-step="4" hidden>
            <div class="crm-form-section">
                <h4><i class="fa-solid fa-money-bill-transfer"></i> Forex Requirement</h4>
                <div class="crm-form-grid">
                    <div class="crm-form-field"><label>Currency Required *</label>
                        <select name="currency_code" id="fxCurrencyCode" required>
                            <option value="">Select currency</option>
                            <?php foreach ($currencies as $cur): ?><option value="<?php echo htmlspecialchars($cur); ?>"><?php echo htmlspecialchars($cur); ?></option><?php endforeach; ?>
                        </select>
                    </div>
                    <div class="crm-form-field"><label>Amount Required *</label><input type="number" step="0.01" min="0.01" name="amount_required" id="fxAmountRequired" required></div>
                    <div class="crm-form-field"><label>Approximate INR Requirement</label><input type="number" step="0.01" min="0" name="approx_inr" id="fxApproxInr"></div>
                    <div class="crm-form-field"><label>Preferred Delivery / Collection Date</label><input type="date" name="preferred_delivery_date" id="fxPreferredDate"></div>
                    <div class="crm-form-field"><label>Preferred Collection Location</label><input type="text" name="collection_location" id="fxCollectionLocation"></div>
                    <div class="crm-form-field"><label>Delivery Method</label>
                        <select name="delivery_method" id="fxDeliveryMethod">
                            <option value="">Select method</option>
                            <?php foreach (FOREX_DELIVERY_METHODS as $m): ?><option value="<?php echo htmlspecialchars($m); ?>"><?php echo htmlspecialchars($m); ?></option><?php endforeach; ?>
                        </select>
                    </div>
                    <div class="crm-form-field"><label>Assigned To</label><input type="text" name="assigned_to" id="fxAssignedTo" value="<?php echo htmlspecialchars(admin_name()); ?>"></div>
                </div>
            </div>
        </div>

        <div class="forex-step-actions">
            <button type="button" class="crm-btn crm-btn-ghost" id="fxPrevBtn" hidden>Back</button>
            <button type="button" class="crm-btn crm-btn-primary" id="fxNextBtn">Next</button>
            <button type="submit" class="crm-btn crm-btn-primary" id="fxSubmitBtn" hidden>Create Forex Request</button>
        </div>
    </form>
</div>

<script>
(function () {
    var steps = Array.prototype.slice.call(document.querySelectorAll('.forex-step'));
    var dots = Array.prototype.slice.call(document.querySelectorAll('[data-step-dot]'));
    var current = 1;

    function showStep(n) {
        steps.forEach(function (s) { s.hidden = (parseInt(s.getAttribute('data-step'), 10) !== n); });
        dots.forEach(function (d) {
            var dn = parseInt(d.getAttribute('data-step-dot'), 10);
            d.classList.toggle('is-active', dn === n);
            d.classList.toggle('is-done', dn < n);
        });
        document.getElementById('fxPrevBtn').hidden = (n === 1);
        document.getElementById('fxNextBtn').hidden = (n === steps.length);
        document.getElementById('fxSubmitBtn').hidden = (n !== steps.length);
        current = n;
    }

    function validateStep(n) {
        var step = steps[n - 1];
        var required = step.querySelectorAll('[required]');
        for (var i = 0; i < required.length; i++) {
            if (!required[i].value) {
                required[i].reportValidity();
                return false;
            }
        }
        return true;
    }

    document.getElementById('fxNextBtn').addEventListener('click', function () {
        if (!validateStep(current)) return;
        if (current < steps.length) showStep(current + 1);
    });
    document.getElementById('fxPrevBtn').addEventListener('click', function () {
        if (current > 1) showStep(current - 1);
    });

    // Visa status conditional notes
    var visaSelect = document.getElementById('fxVisaStatus');
    var availableNote = document.getElementById('fxVisaAvailableNote');
    var notAvailableNote = document.getElementById('fxVisaNotAvailableNote');
    var declarationNote = document.getElementById('fxDeclarationNote');
    var declarationStatuses = ['Visa on Arrival', 'Visa-Free / No Visa Required'];
    visaSelect.addEventListener('change', function () {
        var v = visaSelect.value;
        availableNote.hidden = (v !== 'Visa Available');
        notAvailableNote.hidden = (v !== 'Visa Not Available');
        declarationNote.hidden = (declarationStatuses.indexOf(v) === -1);
    });

    // Customer search
    var searchInput = document.getElementById('fxCustomerSearch');
    var resultsBox = document.getElementById('fxCustomerResults');
    var searchTimer = null;
    searchInput.addEventListener('input', function () {
        clearTimeout(searchTimer);
        var q = searchInput.value.trim();
        if (q.length < 2) { resultsBox.hidden = true; resultsBox.innerHTML = ''; return; }
        searchTimer = setTimeout(function () {
            fetch('forex-customer-search.php?q=' + encodeURIComponent(q))
                .then(function (r) { return r.json(); })
                .then(function (data) {
                    resultsBox.innerHTML = '';
                    if (!data.results || !data.results.length) {
                        resultsBox.innerHTML = '<div class="forex-search-empty">No matching customer found — continue typing details below to create a new one.</div>';
                        resultsBox.hidden = false;
                        return;
                    }
                    data.results.forEach(function (c) {
                        var item = document.createElement('button');
                        item.type = 'button';
                        item.className = 'forex-search-result';
                        item.innerHTML = '<strong>' + (c.full_name || '') + '</strong><span>' + (c.mobile || '') + (c.email ? ' &middot; ' + c.email : '') + '</span><em>' + c.source + '</em>';
                        item.addEventListener('click', function () {
                            document.getElementById('fxFullName').value = c.full_name || '';
                            document.getElementById('fxMobile').value = c.mobile || '';
                            document.getElementById('fxEmail').value = c.email || '';
                            document.getElementById('fxNationality').value = c.nationality || 'Indian';
                            document.getElementById('fxPassportNumber').value = c.passport_number || '';
                            if (c.date_of_birth) document.getElementById('fxDob').value = c.date_of_birth;
                            if (c.address) document.getElementById('fxAddress').value = c.address;
                            if (c.city) document.getElementById('fxCity').value = c.city;
                            if (c.state) document.getElementById('fxState').value = c.state;
                            if (c.pin_code) document.getElementById('fxPinCode').value = c.pin_code;
                            if (c.pan_number) document.getElementById('fxPan').value = c.pan_number;
                            if (c.passport_issue_date) document.getElementById('fxPassportIssue').value = c.passport_issue_date;
                            if (c.passport_expiry) document.getElementById('fxPassportExpiry').value = c.passport_expiry;
                            resultsBox.hidden = true;
                            searchInput.value = c.full_name || '';
                        });
                        resultsBox.appendChild(item);
                    });
                    resultsBox.hidden = false;
                });
        }, 250);
    });
    document.addEventListener('click', function (e) {
        if (!resultsBox.contains(e.target) && e.target !== searchInput) { resultsBox.hidden = true; }
    });

    showStep(1);
})();
</script>

<?php require __DIR__ . '/includes/layout-bottom.php'; ?>
