<?php
/**
 * Forex Buy / Foreign Currency Purchase CRM module — schema + shared helpers.
 * Shares the same SQLite connection as includes/enquiry-db.php (enquiry_db())
 * rather than a new database file, matching the pattern already established
 * for the visa content system (includes/visa-content-db.php).
 */
require_once __DIR__ . '/enquiry-db.php';

const FOREX_STATUSES = [
    'New Request', 'Awaiting Documents', 'Documents Submitted', 'Documents Under Verification',
    'Documents Verified', 'Quotation Preparing', 'Quotation Sent', 'Customer Accepted',
    'Payment Pending', 'Payment Received', 'Compliance Verification', 'Approved for Processing',
    'Forex Procurement / Processing', 'Ready for Delivery', 'Delivered', 'Cancelled', 'Rejected',
    'Refund / Reversal',
];
const FOREX_OPEN_STATUSES = [
    'New Request', 'Awaiting Documents', 'Documents Submitted', 'Documents Under Verification',
    'Documents Verified', 'Quotation Preparing', 'Quotation Sent', 'Customer Accepted',
    'Payment Pending', 'Payment Received', 'Compliance Verification', 'Approved for Processing',
    'Forex Procurement / Processing', 'Ready for Delivery',
];
const FOREX_CLOSED_STATUSES = ['Delivered', 'Cancelled', 'Rejected', 'Refund / Reversal'];

const FOREX_VISA_STATUSES = [
    'Visa Available', 'Visa Not Available', 'Visa on Arrival', 'Visa-Free / No Visa Required',
    'eVisa', 'Visa Application in Process', 'Other',
];
/** Visa statuses where a Visa-on-Arrival/Visa-Free style declaration is required instead of a visa copy. */
const FOREX_VISA_STATUSES_NEEDING_DECLARATION = ['Visa on Arrival', 'Visa-Free / No Visa Required'];

/** What the customer is asking for — distinct from FOREX_TRAVEL_PURPOSES
 * (why they need it). Admin-editable later via forex_settings if this
 * list needs to grow; not wired to a settings override yet since no
 * admin screen asks for it. */
const FOREX_SERVICE_TYPES = [
    'Foreign Currency', 'Forex Card', 'Travel Forex', 'Business Travel Forex',
    'Education Remittance', 'Medical Remittance', 'Corporate Forex', 'Other',
];
const FOREX_TRAVELLER_TYPES = ['Individual', 'Family', 'Corporate', 'Student', 'Other'];
const FOREX_TRAVEL_PURPOSES = [
    'Tourism', 'Business', 'Medical', 'Education', 'Employment', 'Conference',
    'Family Visit', 'Pilgrimage', 'Sports', 'Other',
];
const FOREX_DELIVERY_METHODS = ['Branch Collection', 'Home Delivery', 'Courier'];

const FOREX_DOC_TYPES = [
    'Passport' => 'Passport Copy',
    'PAN' => 'PAN Card Copy',
    'AirTicket' => 'Confirmed Air Ticket Copy',
    'Hotel' => 'Hotel Booking / Accommodation Proof',
    'Visa' => 'Visa Copy',
    'Declaration' => 'Visa-on-Arrival / Visa-Free Declaration',
];
const FOREX_DOC_STATUSES = ['Not Uploaded', 'Uploaded', 'Under Verification', 'Verified', 'Rejected'];

const FOREX_RATE_TYPES = ['Indicative', 'Quoted', 'Locked / Confirmed'];
const FOREX_QUOTATION_STATUSES = ['Draft', 'Sent', 'Accepted', 'Expired'];

const FOREX_PAYMENT_STATUSES = ['Pending', 'Partially Paid', 'Paid', 'Refunded', 'Cancelled'];
const FOREX_PAYMENT_METHODS = ['Cash', 'UPI', 'Bank Transfer', 'Credit Card', 'Debit Card', 'Cheque', 'Other'];

/** Default supported currencies — admin-editable afterward via forex_settings, not hard-coded elsewhere. */
const FOREX_DEFAULT_CURRENCIES = [
    'USD', 'EUR', 'GBP', 'AED', 'SGD', 'AUD', 'CAD', 'CHF', 'JPY', 'HKD',
    'THB', 'MYR', 'SAR', 'QAR', 'NZD', 'CNY',
];

/** Customer portal login OTP — mirrors B2B_OTP_TTL_SECONDS/B2B_OTP_MAX_ATTEMPTS (includes/b2b-otp.php). */
const FOREX_CUSTOMER_OTP_TTL_SECONDS = 600; // 10 minutes
const FOREX_CUSTOMER_OTP_MAX_ATTEMPTS = 5;

function forex_db(): PDO
{
    static $migrated = false;
    $pdo = enquiry_db();
    if ($migrated) {
        return $pdo;
    }

    $pdo->exec("CREATE TABLE IF NOT EXISTS forex_country_rules (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        country TEXT UNIQUE NOT NULL,
        currency_code TEXT,
        visa_required INTEGER NOT NULL DEFAULT 1,
        visa_on_arrival INTEGER NOT NULL DEFAULT 0,
        visa_free INTEGER NOT NULL DEFAULT 0,
        evisa INTEGER NOT NULL DEFAULT 0,
        requires_passport INTEGER NOT NULL DEFAULT 1,
        requires_pan INTEGER NOT NULL DEFAULT 1,
        requires_air_ticket INTEGER NOT NULL DEFAULT 1,
        requires_hotel INTEGER NOT NULL DEFAULT 1,
        requires_visa_copy INTEGER NOT NULL DEFAULT 1,
        requires_declaration INTEGER NOT NULL DEFAULT 0,
        compliance_notes TEXT,
        updated_by TEXT,
        updated_at TEXT NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS forex_requests (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        forex_ref TEXT UNIQUE NOT NULL,
        status TEXT NOT NULL DEFAULT 'New Request',

        full_name TEXT NOT NULL,
        date_of_birth TEXT,
        mobile TEXT NOT NULL,
        email TEXT,
        address TEXT,
        city TEXT,
        state TEXT,
        pin_code TEXT,
        pan_number TEXT,
        passport_number TEXT,
        passport_issue_date TEXT,
        passport_expiry TEXT,
        nationality TEXT,

        country_visit TEXT,
        cities_visit TEXT,
        purpose TEXT,
        departure_date TEXT,
        return_date TEXT,
        duration_of_stay TEXT,
        airline TEXT,
        flight_number TEXT,
        hotel_name TEXT,
        hotel_location TEXT,
        traveller_type TEXT,

        visa_status TEXT,

        currency_code TEXT,
        amount_required REAL,
        approx_inr REAL,
        preferred_delivery_date TEXT,
        collection_location TEXT,
        delivery_method TEXT,

        assigned_to TEXT,
        created_by TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        archived_at TEXT
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS forex_documents (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        forex_request_id INTEGER NOT NULL REFERENCES forex_requests(id) ON DELETE CASCADE,
        doc_type TEXT NOT NULL,
        original_filename TEXT,
        stored_filename TEXT,
        mime TEXT,
        size INTEGER,
        status TEXT NOT NULL DEFAULT 'Not Uploaded',
        rejection_reason TEXT,
        verification_remarks TEXT,
        verified_by TEXT,
        verified_at TEXT,
        replaces_document_id INTEGER REFERENCES forex_documents(id),
        uploaded_at TEXT
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS forex_declaration_templates (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        body_html TEXT NOT NULL,
        version INTEGER NOT NULL DEFAULT 1,
        is_active INTEGER NOT NULL DEFAULT 1,
        created_by TEXT,
        created_at TEXT NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS forex_declarations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        forex_request_id INTEGER NOT NULL REFERENCES forex_requests(id) ON DELETE CASCADE,
        template_id INTEGER REFERENCES forex_declaration_templates(id),
        template_version INTEGER,
        customer_name TEXT,
        passport_number TEXT,
        destination_country TEXT,
        declaration_date TEXT,
        stored_filename TEXT,
        uploaded_at TEXT,
        verified_by TEXT,
        verified_at TEXT
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS forex_rates (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        currency_code TEXT NOT NULL,
        buy_rate REAL,
        sell_rate REAL,
        source TEXT,
        updated_by TEXT,
        effective_from TEXT NOT NULL,
        effective_until TEXT
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS forex_quotations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        forex_request_id INTEGER NOT NULL REFERENCES forex_requests(id) ON DELETE CASCADE,
        currency_code TEXT NOT NULL,
        currency_amount REAL NOT NULL,
        exchange_rate REAL NOT NULL,
        rate_type TEXT NOT NULL DEFAULT 'Indicative',
        base_inr REAL NOT NULL,
        service_charge REAL NOT NULL DEFAULT 0,
        markup REAL NOT NULL DEFAULT 0,
        gst REAL NOT NULL DEFAULT 0,
        other_charges REAL NOT NULL DEFAULT 0,
        total_inr REAL NOT NULL,
        payment_terms TEXT,
        valid_until TEXT,
        status TEXT NOT NULL DEFAULT 'Draft',
        created_by TEXT,
        created_at TEXT NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS forex_approvals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        forex_request_id INTEGER NOT NULL REFERENCES forex_requests(id) ON DELETE CASCADE,
        quotation_id INTEGER REFERENCES forex_quotations(id),
        action TEXT NOT NULL,
        approver TEXT,
        previous_value TEXT,
        new_value TEXT,
        remarks TEXT,
        ip_address TEXT,
        created_at TEXT NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS forex_payments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        forex_request_id INTEGER NOT NULL REFERENCES forex_requests(id) ON DELETE CASCADE,
        status TEXT NOT NULL DEFAULT 'Pending',
        method TEXT,
        transaction_id TEXT,
        amount REAL,
        payment_date TEXT,
        reference TEXT,
        proof_stored_filename TEXT,
        remarks TEXT,
        recorded_by TEXT,
        created_at TEXT NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS forex_deliveries (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        forex_request_id INTEGER NOT NULL UNIQUE REFERENCES forex_requests(id) ON DELETE CASCADE,
        delivered_by TEXT,
        received_by TEXT,
        delivery_date TEXT,
        delivery_time TEXT,
        currency_code TEXT,
        total_amount REAL,
        customer_ack INTEGER NOT NULL DEFAULT 0,
        signature_stored_filename TEXT,
        remarks TEXT,
        created_at TEXT NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS forex_denominations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        delivery_id INTEGER NOT NULL REFERENCES forex_deliveries(id) ON DELETE CASCADE,
        denomination_value REAL NOT NULL,
        quantity INTEGER NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS forex_status_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        forex_request_id INTEGER NOT NULL REFERENCES forex_requests(id) ON DELETE CASCADE,
        previous_status TEXT,
        new_status TEXT NOT NULL,
        changed_by TEXT,
        message TEXT,
        created_at TEXT NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS forex_audit_logs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        forex_request_id INTEGER REFERENCES forex_requests(id) ON DELETE CASCADE,
        user_name TEXT,
        role TEXT,
        action TEXT NOT NULL,
        previous_value TEXT,
        new_value TEXT,
        ip_address TEXT,
        created_at TEXT NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS forex_ref_counters (
        year TEXT PRIMARY KEY,
        next_number INTEGER NOT NULL DEFAULT 1
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS forex_settings (
        key TEXT PRIMARY KEY,
        value TEXT
    )");

    // Customer portal login — passwordless, mobile-scoped OTP emailed to the
    // address already on file (mirrors b2b_otp_codes but keyed by mobile
    // rather than an account row, since a forex customer has no separate
    // account until they log in for the first time).
    $pdo->exec("CREATE TABLE IF NOT EXISTS forex_customer_otps (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        mobile TEXT NOT NULL,
        email TEXT NOT NULL,
        code_hash TEXT NOT NULL,
        expires_at TEXT NOT NULL,
        consumed_at TEXT,
        attempts INTEGER NOT NULL DEFAULT 0,
        ip_address TEXT,
        created_at TEXT NOT NULL
    )");

    // Additive column on the existing notifications table so the Forex module
    // can reuse crm_notify()/admin/notifications.php as-is rather than
    // building a parallel notification system.
    forex_ensure_column($pdo, 'notifications', 'forex_request_id', 'INTEGER REFERENCES forex_requests(id) ON DELETE CASCADE');
    // Added in Phase 4 for the document verification queue — CREATE TABLE IF
    // NOT EXISTS above doesn't retrofit new columns onto an already-created
    // table on environments that bootstrapped forex_documents before this.
    forex_ensure_column($pdo, 'forex_documents', 'verification_remarks', 'TEXT');
    // Public post-submission document upload link (mirrors b2b_partners.upload_token) —
    // lets a customer who just submitted a public enquiry upload documents without an account.
    forex_ensure_column($pdo, 'forex_requests', 'upload_token', 'TEXT');
    forex_ensure_column($pdo, 'forex_requests', 'ip_address', 'TEXT');
    // What the customer asked for (Foreign Currency / Forex Card / Travel
    // Forex / etc.) — distinct from the existing `purpose` column, which
    // captures why (Tourism/Business/Medical/...).
    forex_ensure_column($pdo, 'forex_requests', 'service_type', 'TEXT');
    forex_ensure_column($pdo, 'forex_requests', 'special_requirement', 'TEXT');

    forex_seed_default_settings($pdo);
    forex_seed_default_declaration_template($pdo);

    $migrated = true;
    return $pdo;
}

/** Idempotently adds a column to an already-existing table — CREATE TABLE IF
 * NOT EXISTS doesn't retrofit schema changes onto a database bootstrapped by
 * an earlier version of this file. */
function forex_ensure_column(PDO $pdo, string $table, string $column, string $definition): void
{
    $cols = $pdo->query('PRAGMA table_info(' . $table . ')')->fetchAll(PDO::FETCH_ASSOC);
    foreach ($cols as $c) {
        if ($c['name'] === $column) {
            return;
        }
    }
    $pdo->exec("ALTER TABLE $table ADD COLUMN $column $definition");
}

function forex_seed_default_settings(PDO $pdo): void
{
    $defaults = [
        'currencies' => json_encode(FOREX_DEFAULT_CURRENCIES),
        'default_service_charge' => '0',
        'default_markup' => '0',
        'default_gst_percent' => '0',
        'quotation_validity_hours' => '24',
        'approval_threshold_inr' => '200000',
        'ref_number_prefix' => 'VG-FX',
        'sms_gateway_status' => 'not_connected',
    ];
    $stmt = $pdo->prepare('INSERT OR IGNORE INTO forex_settings (key, value) VALUES (?, ?)');
    foreach ($defaults as $k => $v) {
        $stmt->execute([$k, $v]);
    }
}

function forex_seed_default_declaration_template(PDO $pdo): void
{
    $exists = (int) $pdo->query('SELECT COUNT(*) FROM forex_declaration_templates')->fetchColumn();
    if ($exists > 0) {
        return;
    }
    $body = '<h3>Visa Not Applicable — Customer Declaration</h3>
<p>Forex Reference: <strong>{{forex_reference}}</strong></p>
<p>I, <strong>{{customer_name}}</strong>, holder of passport number <strong>{{passport_number}}</strong>,
confirm that I am travelling to <strong>{{country}}</strong> on or around <strong>{{travel_date}}</strong>,
and that a visa is not required to be presented at the time of this foreign currency purchase because the
destination is classified as Visa on Arrival, Visa-Free, or otherwise exempt under the applicable entry rules
for my nationality.</p>
<p>I am purchasing <strong>{{currency}} {{amount}}</strong> and I understand that it is my responsibility to
verify current entry/visa requirements for {{country}} before travel. I declare that the information provided
in connection with this foreign exchange transaction is true and accurate to the best of my knowledge.</p>
<p>This declaration must be signed by hand and the signed copy uploaded — a typed name does not satisfy this
requirement.</p>
<p>Declaration Date: <strong>{{declaration_date}}</strong></p>
<p style="margin-top:40px;">Signature: _______________________________</p>
<p style="font-size:11px;color:#888;margin-top:24px;">This declaration is a company record-keeping document
and does not itself constitute legal or regulatory advice. Final compliance requirements should be reviewed
and approved by an authorised compliance/legal professional.</p>';
    $pdo->prepare('INSERT INTO forex_declaration_templates (name, body_html, version, is_active, created_by, created_at) VALUES (?, ?, 1, 1, ?, ?)')
        ->execute(['Visa on Arrival / Visa-Free Declaration', $body, 'System', gmdate('c')]);
}

function forex_setting(PDO $pdo, string $key, ?string $default = null): ?string
{
    $stmt = $pdo->prepare('SELECT value FROM forex_settings WHERE key = ?');
    $stmt->execute([$key]);
    $val = $stmt->fetchColumn();
    return $val !== false ? $val : $default;
}

function forex_set_setting(PDO $pdo, string $key, string $value): void
{
    $pdo->prepare('INSERT INTO forex_settings (key, value) VALUES (?, ?) ON CONFLICT(key) DO UPDATE SET value = excluded.value')
        ->execute([$key, $value]);
}

function forex_currencies(PDO $pdo): array
{
    $json = forex_setting($pdo, 'currencies');
    $list = $json ? json_decode($json, true) : null;
    return is_array($list) && $list ? $list : FOREX_DEFAULT_CURRENCIES;
}

/**
 * Sequential, non-editable, unique reference number: VG-FX-2026-000001.
 * Allocated inside a transaction against forex_ref_counters so concurrent
 * requests can never collide or skip — unlike enquiry_generate_ref()'s
 * random-suffix approach, the spec explicitly wants real sequential numbers.
 */
function forex_generate_ref(PDO $pdo): string
{
    $prefix = forex_setting($pdo, 'ref_number_prefix', 'VG-FX');
    $year = gmdate('Y');

    $alreadyInTransaction = $pdo->inTransaction();
    if (!$alreadyInTransaction) {
        $pdo->beginTransaction();
    }
    try {
        $pdo->prepare('INSERT OR IGNORE INTO forex_ref_counters (year, next_number) VALUES (?, 1)')->execute([$year]);
        $stmt = $pdo->prepare('SELECT next_number FROM forex_ref_counters WHERE year = ?');
        $stmt->execute([$year]);
        $number = (int) $stmt->fetchColumn();
        $pdo->prepare('UPDATE forex_ref_counters SET next_number = ? WHERE year = ?')->execute([$number + 1, $year]);
        if (!$alreadyInTransaction) {
            $pdo->commit();
        }
    } catch (Throwable $e) {
        if (!$alreadyInTransaction && $pdo->inTransaction()) {
            $pdo->rollBack();
        }
        throw $e;
    }

    return sprintf('%s-%s-%06d', $prefix, $year, $number);
}

function forex_status_class(string $status): string
{
    return 'forex-status-' . strtolower(str_replace([' ', '/'], ['-', ''], $status));
}

function forex_doc_status_class(string $status): string
{
    return 'forex-doc-' . strtolower(str_replace(' ', '-', $status));
}

function forex_log_status_change(PDO $pdo, int $requestId, ?string $previousStatus, string $newStatus, string $changedBy, string $message = ''): void
{
    $pdo->prepare('INSERT INTO forex_status_history (forex_request_id, previous_status, new_status, changed_by, message, created_at) VALUES (?, ?, ?, ?, ?, ?)')
        ->execute([$requestId, $previousStatus, $newStatus, $changedBy, $message, gmdate('c')]);
}

/**
 * General audit trail covering document verification, approvals, overrides
 * and delivery — broader than forex_status_history, which only tracks the
 * request's overall status field.
 */
function forex_log_audit(PDO $pdo, ?int $requestId, string $userName, string $role, string $action, string $previousValue = '', string $newValue = ''): void
{
    $ip = $_SERVER['REMOTE_ADDR'] ?? null;
    $pdo->prepare('INSERT INTO forex_audit_logs (forex_request_id, user_name, role, action, previous_value, new_value, ip_address, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?)')
        ->execute([$requestId, $userName, $role, $action, $previousValue, $newValue, $ip, gmdate('c')]);
}

function forex_notify(PDO $pdo, ?int $userId, string $type, string $message, ?int $requestId): void
{
    $pdo->prepare('INSERT INTO notifications (user_id, type, message, forex_request_id, created_at) VALUES (?, ?, ?, ?, ?)')
        ->execute([$userId, $type, $message, $requestId, gmdate('c')]);
}

/**
 * Sends a milestone email to the customer on a forex request (Request
 * Created / Documents Pending / Document Rejected / Quotation Ready /
 * Payment Received / Ready for Delivery / Completed) and records the
 * attempt on the audit trail, mirroring how crm_send_applicant_email()
 * is used for visa enquiries. Silently no-ops if the request has no
 * email on file — email is optional at intake, this is not a hard error.
 */
function forex_notify_customer(PDO $pdo, array $request, string $subject, string $bodyText): void
{
    $email = trim((string) ($request['email'] ?? ''));
    if ($email === '') {
        return;
    }
    $sent = crm_send_applicant_email($email, $subject, $bodyText);
    forex_log_audit(
        $pdo,
        (int) $request['id'],
        'System',
        'System',
        'customer_email_' . ($sent ? 'sent' : 'failed'),
        '',
        $subject
    );
}

/**
 * Renders a declaration template's {{placeholders}} against a forex request.
 * Kept as a pure string function (no HTML escaping decisions baked in) so
 * both the on-screen render and the PDF export (added in a later phase) can
 * reuse it identically.
 */
/**
 * Maps a Forex status to the 8-stage customer-facing tracking timeline.
 * Cancelled/Rejected are handled as a separate banner by the caller, same
 * convention as crm_timeline_stages() for visa enquiries.
 */
function forex_timeline_stages(string $status): array
{
    $table = [
        'New Request'                     => ['done', 'pending', 'pending', 'pending', 'pending', 'pending', 'pending', 'pending'],
        'Awaiting Documents'               => ['done', 'current', 'pending', 'pending', 'pending', 'pending', 'pending', 'pending'],
        'Documents Submitted'              => ['done', 'current', 'pending', 'pending', 'pending', 'pending', 'pending', 'pending'],
        'Documents Under Verification'     => ['done', 'current', 'pending', 'pending', 'pending', 'pending', 'pending', 'pending'],
        'Documents Verified'               => ['done', 'done', 'current', 'pending', 'pending', 'pending', 'pending', 'pending'],
        'Quotation Preparing'              => ['done', 'done', 'done', 'current', 'pending', 'pending', 'pending', 'pending'],
        'Quotation Sent'                   => ['done', 'done', 'done', 'current', 'pending', 'pending', 'pending', 'pending'],
        'Customer Accepted'                => ['done', 'done', 'done', 'done', 'current', 'pending', 'pending', 'pending'],
        'Payment Pending'                  => ['done', 'done', 'done', 'done', 'current', 'pending', 'pending', 'pending'],
        'Payment Received'                 => ['done', 'done', 'done', 'done', 'done', 'current', 'pending', 'pending'],
        'Compliance Verification'          => ['done', 'done', 'done', 'done', 'done', 'current', 'pending', 'pending'],
        'Approved for Processing'          => ['done', 'done', 'done', 'done', 'done', 'done', 'current', 'pending'],
        'Forex Procurement / Processing'   => ['done', 'done', 'done', 'done', 'done', 'done', 'current', 'pending'],
        'Ready for Delivery'               => ['done', 'done', 'done', 'done', 'done', 'done', 'done', 'current'],
        'Delivered'                        => ['done', 'done', 'done', 'done', 'done', 'done', 'done', 'done'],
        'Refund / Reversal'                => ['done', 'done', 'done', 'done', 'done', 'done', 'done', 'done'],
    ];
    return $table[$status] ?? array_fill(0, 8, 'pending');
}

function forex_timeline_labels(): array
{
    return [
        'Request Submitted', 'Documents Uploaded', 'Documents Verified', 'Quotation Prepared',
        'Payment', 'Compliance Verification', 'Approved for Processing', 'Ready / Delivered',
    ];
}

/**
 * The hard pre-delivery compliance gate (spec §17). Returns an array of
 * human-readable missing-requirement strings — empty array means delivery
 * is allowed. Called both to render the on-screen checklist AND to block
 * the "Mark as Delivered" action server-side; never trust the UI alone.
 */
function forex_delivery_blockers(PDO $pdo, array $request): array
{
    $blockers = [];
    $requestId = (int) $request['id'];

    $docsStmt = $pdo->prepare('SELECT * FROM forex_documents WHERE forex_request_id = ? ORDER BY doc_type, id DESC');
    $docsStmt->execute([$requestId]);
    $currentDocs = [];
    foreach ($docsStmt->fetchAll(PDO::FETCH_ASSOC) as $d) {
        if (!isset($currentDocs[$d['doc_type']])) {
            $currentDocs[$d['doc_type']] = $d;
        }
    }

    foreach ($currentDocs as $docType => $d) {
        if ($d['status'] !== 'Verified') {
            $blockers[] = FOREX_DOC_TYPES[$docType] . ' is not yet verified (currently: ' . $d['status'] . ').';
        }
    }
    if (!isset($currentDocs['Passport'])) {
        // Passport identity verification is the spec's own explicit example of a
        // mandatory check — called out even if, unusually, it's missing from the checklist entirely.
        $blockers[] = 'Customer identity (passport) has not been captured on this request.';
    }

    $quotStmt = $pdo->prepare("SELECT * FROM forex_quotations WHERE forex_request_id = ? ORDER BY id DESC LIMIT 1");
    $quotStmt->execute([$requestId]);
    $quotation = $quotStmt->fetch(PDO::FETCH_ASSOC);
    if (!$quotation) {
        $blockers[] = 'No quotation has been created for this request.';
    } elseif ($quotation['status'] === 'Draft') {
        $blockers[] = 'The quotation is still awaiting approval.';
    } elseif (!in_array($quotation['status'], ['Sent', 'Accepted'], true)) {
        $blockers[] = 'The quotation has not been sent/accepted (status: ' . $quotation['status'] . ').';
    }

    $paidStmt = $pdo->prepare("SELECT COALESCE(SUM(amount), 0) FROM forex_payments WHERE forex_request_id = ? AND status = 'Paid'");
    $paidStmt->execute([$requestId]);
    $totalPaid = (float) $paidStmt->fetchColumn();
    if ($quotation && $totalPaid < (float) $quotation['total_inr'] - 0.01) {
        $blockers[] = 'Payment not fully confirmed (received Rs. ' . number_format($totalPaid, 2) . ' of Rs. ' . number_format((float) $quotation['total_inr'], 2) . ' due).';
    }

    if (isset($currentDocs['Declaration'])) {
        $declStmt = $pdo->prepare('SELECT * FROM forex_declarations WHERE forex_request_id = ? ORDER BY id DESC LIMIT 1');
        $declStmt->execute([$requestId]);
        $decl = $declStmt->fetch(PDO::FETCH_ASSOC);
        if (!$decl || !$decl['verified_at']) {
            $blockers[] = 'Visa-on-Arrival/Visa-Free declaration has not been verified.';
        }
    }

    return array_values(array_unique($blockers));
}

/**
 * FPDF's core fonts only support single-byte Windows-1252, not UTF-8 — any
 * database value (customer name, payment terms, etc.) that contains a
 * genuinely non-Latin1 character would otherwise render as garbled bytes in
 * a generated PDF. Transliterates what it can and drops the rest rather
 * than corrupting output. Shared by every admin/forex-*-pdf.php generator.
 */
function forex_pdf_safe(?string $text): string
{
    $text = (string) $text;
    $converted = @iconv('UTF-8', 'CP1252//TRANSLIT//IGNORE', $text);
    return $converted !== false ? $converted : preg_replace('/[^\x20-\x7E]/', '', $text);
}

/** Normalizes any mobile input to its last 10 digits — the same comparison
 * forex-track.php already uses to verify a submitted mobile number. */
function forex_normalize_mobile(string $raw): string
{
    return substr(preg_replace('/\D/', '', $raw), -10);
}

/**
 * Most recent non-archived forex request's email for a given mobile
 * number — where the customer-portal login OTP gets sent. Returns null if
 * this mobile has no forex request on file with an email, in which case
 * the caller must still respond as if a code might have been sent (see
 * forex-otp-send.php) so the response itself can't be used to enumerate
 * which mobile numbers have requests.
 */
function forex_customer_email_for_mobile(PDO $pdo, string $mobile): ?string
{
    $digits = forex_normalize_mobile($mobile);
    if ($digits === '') {
        return null;
    }
    $stmt = $pdo->prepare("SELECT email FROM forex_requests
        WHERE substr(mobile, -10) = ? AND archived_at IS NULL AND email IS NOT NULL AND email != ''
        ORDER BY created_at DESC LIMIT 1");
    $stmt->execute([$digits]);
    $email = $stmt->fetchColumn();
    return $email !== false && $email !== '' ? (string) $email : null;
}

/** Most recent full_name on file for a mobile — greets the customer once
 * logged in; there is no separate customer-profile table to read from. */
function forex_customer_display_name(PDO $pdo, string $mobile): string
{
    $digits = forex_normalize_mobile($mobile);
    if ($digits === '') {
        return 'Customer';
    }
    $stmt = $pdo->prepare("SELECT full_name FROM forex_requests
        WHERE substr(mobile, -10) = ? AND archived_at IS NULL
        ORDER BY created_at DESC LIMIT 1");
    $stmt->execute([$digits]);
    $name = $stmt->fetchColumn();
    return $name !== false && $name !== '' ? (string) $name : 'Customer';
}

/**
 * Generates a 6-digit code, stores its hash (never the plaintext) with a
 * 10-minute expiry, and emails it to $email — mirrors b2b_send_otp()
 * exactly. The caller resolves $email via forex_customer_email_for_mobile()
 * first, so this function itself never decides whether an "account"
 * exists. Returns true if the email send succeeded.
 */
function forex_send_customer_otp(PDO $pdo, string $mobile, string $email): bool
{
    $digits = forex_normalize_mobile($mobile);
    $code = str_pad((string) random_int(0, 999999), 6, '0', STR_PAD_LEFT);
    $codeHash = password_hash($code, PASSWORD_DEFAULT);
    $expiresAt = gmdate('c', time() + FOREX_CUSTOMER_OTP_TTL_SECONDS);

    $pdo->prepare('INSERT INTO forex_customer_otps (mobile, email, code_hash, expires_at, created_at, ip_address) VALUES (?, ?, ?, ?, ?, ?)')
        ->execute([$digits, $email, $codeHash, $expiresAt, gmdate('c'), $_SERVER['REMOTE_ADDR'] ?? null]);

    return crm_send_applicant_email(
        $email,
        'Your VisaAgency.in Forex Portal Login Code',
        "Your verification code is: $code\n\nThis code expires in " . (FOREX_CUSTOMER_OTP_TTL_SECONDS / 60) . " minutes. If you did not request this, you can safely ignore this email.\n\nRegards,\nVisaAgency.in Forex Team"
    );
}

/**
 * Verifies a submitted code against the most recent unconsumed code for
 * this mobile — mirrors b2b_verify_otp() exactly (expiry check,
 * max-attempts lockout, consume-on-success so it can't be replayed).
 */
function forex_verify_customer_otp(PDO $pdo, string $mobile, string $code): bool
{
    $digits = forex_normalize_mobile($mobile);
    $stmt = $pdo->prepare('SELECT * FROM forex_customer_otps WHERE mobile = ? AND consumed_at IS NULL ORDER BY id DESC LIMIT 1');
    $stmt->execute([$digits]);
    $row = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$row) {
        return false;
    }
    if (strtotime($row['expires_at']) < time()) {
        return false;
    }
    if ((int) $row['attempts'] >= FOREX_CUSTOMER_OTP_MAX_ATTEMPTS) {
        return false;
    }

    $pdo->prepare('UPDATE forex_customer_otps SET attempts = attempts + 1 WHERE id = ?')->execute([$row['id']]);

    if (!password_verify($code, $row['code_hash'])) {
        return false;
    }

    $pdo->prepare('UPDATE forex_customer_otps SET consumed_at = ? WHERE id = ?')->execute([gmdate('c'), $row['id']]);
    return true;
}

/**
 * Looks up a forex request by reference + upload token (the pre-login
 * document upload gate for a customer who just submitted a public
 * enquiry — mirrors b2b_partner_by_token() exactly). Returns null on any
 * mismatch, deliberately the same generic failure for "ref doesn't
 * exist" and "wrong token" so a bad token can't be used to probe
 * whether a given reference exists.
 */
function forex_request_by_token(PDO $pdo, string $forexRef, string $token): ?array
{
    if ($token === '') {
        return null;
    }
    $stmt = $pdo->prepare('SELECT * FROM forex_requests WHERE forex_ref = ? AND archived_at IS NULL');
    $stmt->execute([$forexRef]);
    $request = $stmt->fetch(PDO::FETCH_ASSOC);
    if (!$request || !$request['upload_token'] || !hash_equals($request['upload_token'], $token)) {
        return null;
    }
    return $request;
}

/**
 * Which documents apply to a forex request's destination country, and
 * whether each is required — driven by forex_country_rules so this is
 * configurable per country rather than one hard-coded checklist for
 * every destination (spec: document requirements must not be uniformly
 * mandatory). Falls back to "Required" for the core KYC docs (Passport,
 * PAN) when the destination has no country_rules row yet.
 *
 * @return array<string,bool> doc_type => required
 */
function forex_required_docs_for_country(PDO $pdo, ?string $country): array
{
    $rule = null;
    if ($country) {
        $stmt = $pdo->prepare('SELECT * FROM forex_country_rules WHERE country = ?');
        $stmt->execute([$country]);
        $rule = $stmt->fetch(PDO::FETCH_ASSOC) ?: null;
    }

    if (!$rule) {
        return [
            'Passport' => true, 'PAN' => true, 'AirTicket' => true,
            'Hotel' => false, 'Visa' => false, 'Declaration' => false,
        ];
    }

    return [
        'Passport' => (bool) $rule['requires_passport'],
        'PAN' => (bool) $rule['requires_pan'],
        'AirTicket' => (bool) $rule['requires_air_ticket'],
        'Hotel' => (bool) $rule['requires_hotel'],
        'Visa' => (bool) $rule['requires_visa_copy'],
        'Declaration' => (bool) $rule['requires_declaration'],
    ];
}

/**
 * Shared validation + storage for a public (pre-login, token-gated)
 * forex document upload — mirrors admin/forex-document-upload.php's
 * exact extension/MIME whitelist, size cap and human-traceable
 * filename pattern so both paths behave identically, just gated
 * differently (token here, admin_require_login() there).
 *
 * @param array $file One element of $_FILES, e.g. $_FILES['document'].
 * @return array{success:bool,code?:int,message?:string,doc_id?:int,filename?:string,status?:string}
 */
function forex_save_uploaded_document(PDO $pdo, array $request, string $docType, array $file): array
{
    if (!array_key_exists($docType, FOREX_DOC_TYPES)) {
        return ['success' => false, 'code' => 422, 'message' => 'Unknown document type.'];
    }
    if (empty($file) || ($file['error'] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_OK) {
        return ['success' => false, 'code' => 422, 'message' => 'Please choose a file to upload.'];
    }

    $allowedExt = ['pdf', 'jpg', 'jpeg', 'png'];
    $allowedMime = ['application/pdf', 'image/jpeg', 'image/png'];
    $maxBytes = 5 * 1024 * 1024;

    if ((int) $file['size'] > $maxBytes) {
        return ['success' => false, 'code' => 422, 'message' => 'File is too large. Maximum size is 5 MB.'];
    }

    $ext = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));
    if (!in_array($ext, $allowedExt, true)) {
        return ['success' => false, 'code' => 422, 'message' => 'Unsupported file type. Allowed: PDF, JPG, PNG.'];
    }
    $finfo = new finfo(FILEINFO_MIME_TYPE);
    $mime = $finfo->file($file['tmp_name']) ?: '';
    if (!in_array($mime, $allowedMime, true)) {
        return ['success' => false, 'code' => 422, 'message' => 'The file content does not match its extension. Please upload a genuine file.'];
    }

    $requestId = (int) $request['id'];
    $targetDir = __DIR__ . '/../uploads/forex/' . $request['forex_ref'];
    if (!is_dir($targetDir) && !mkdir($targetDir, 0770, true) && !is_dir($targetDir)) {
        return ['success' => false, 'code' => 500, 'message' => 'Could not create the storage folder for this request.'];
    }
    $storedName = $request['forex_ref'] . '-' . strtoupper($docType) . '-' . time() . '.' . $ext;
    if (!move_uploaded_file($file['tmp_name'], $targetDir . '/' . $storedName)) {
        return ['success' => false, 'code' => 500, 'message' => 'Could not save the uploaded file. Please try again.'];
    }

    $now = gmdate('c');
    $existingStmt = $pdo->prepare('SELECT id, stored_filename FROM forex_documents WHERE forex_request_id = ? AND doc_type = ? ORDER BY id DESC LIMIT 1');
    $existingStmt->execute([$requestId, $docType]);
    $existing = $existingStmt->fetch(PDO::FETCH_ASSOC);

    if ($existing && $existing['stored_filename'] === null) {
        $pdo->prepare("UPDATE forex_documents SET original_filename = ?, stored_filename = ?, mime = ?, size = ?, status = 'Uploaded', rejection_reason = NULL, uploaded_at = ? WHERE id = ?")
            ->execute([$file['name'], $storedName, $mime, (int) $file['size'], $now, $existing['id']]);
        $docId = (int) $existing['id'];
    } else {
        $pdo->prepare("INSERT INTO forex_documents (forex_request_id, doc_type, original_filename, stored_filename, mime, size, status, replaces_document_id, uploaded_at) VALUES (?, ?, ?, ?, ?, ?, 'Uploaded', ?, ?)")
            ->execute([$requestId, $docType, $file['name'], $storedName, $mime, (int) $file['size'], $existing['id'] ?? null, $now]);
        $docId = (int) $pdo->lastInsertId();
    }

    if ($docType === 'Declaration') {
        $pdo->prepare('UPDATE forex_declarations SET stored_filename = ?, uploaded_at = ? WHERE forex_request_id = ?')
            ->execute([$storedName, $now, $requestId]);
    }

    forex_log_audit($pdo, $requestId, 'Customer', 'Customer', 'Uploaded document: ' . FOREX_DOC_TYPES[$docType], '', $file['name']);

    return ['success' => true, 'doc_id' => $docId, 'filename' => $file['name'], 'status' => 'Uploaded'];
}

function forex_render_declaration(string $bodyHtml, array $vars): string
{
    $map = [];
    foreach ($vars as $k => $v) {
        $map['{{' . $k . '}}'] = htmlspecialchars((string) $v);
    }
    return strtr($bodyHtml, $map);
}
