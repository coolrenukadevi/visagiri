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

    // Additive column on the existing notifications table so the Forex module
    // can reuse crm_notify()/admin/notifications.php as-is rather than
    // building a parallel notification system.
    $cols = $pdo->query("PRAGMA table_info(notifications)")->fetchAll(PDO::FETCH_ASSOC);
    $hasForexCol = false;
    foreach ($cols as $c) {
        if ($c['name'] === 'forex_request_id') {
            $hasForexCol = true;
            break;
        }
    }
    if (!$hasForexCol) {
        $pdo->exec('ALTER TABLE notifications ADD COLUMN forex_request_id INTEGER REFERENCES forex_requests(id) ON DELETE CASCADE');
    }

    forex_seed_default_settings($pdo);
    forex_seed_default_declaration_template($pdo);

    $migrated = true;
    return $pdo;
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
 * Renders a declaration template's {{placeholders}} against a forex request.
 * Kept as a pure string function (no HTML escaping decisions baked in) so
 * both the on-screen render and the PDF export (added in a later phase) can
 * reuse it identically.
 */
function forex_render_declaration(string $bodyHtml, array $vars): string
{
    $map = [];
    foreach ($vars as $k => $v) {
        $map['{{' . $k . '}}'] = htmlspecialchars((string) $v);
    }
    return strtr($bodyHtml, $map);
}
