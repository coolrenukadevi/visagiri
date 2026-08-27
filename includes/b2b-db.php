<?php
/**
 * B2B Visa Partner Portal + CRM module — schema + shared helpers. Shares the
 * same SQLite connection as includes/enquiry-db.php (enquiry_db()) rather
 * than a new database file, matching the pattern already established for
 * the Forex module (includes/forex-db.php).
 */
require_once __DIR__ . '/enquiry-db.php';

const B2B_PARTNER_STATUSES = [
    'Draft', 'Submitted', 'Under Review', 'Documents Required', 'Verification',
    'Approved', 'Rejected', 'Suspended', 'Deactivated',
];
const B2B_PARTNER_OPEN_STATUSES = ['Draft', 'Submitted', 'Under Review', 'Documents Required', 'Verification'];
const B2B_PARTNER_ACTIVE_STATUSES = ['Approved'];

const B2B_BUSINESS_TYPES = [
    'Travel Agency', 'Tour Operator', 'Visa Consultant', 'Corporate Travel Desk',
    'Immigration Consultant', 'Freelancer / Independent Consultant', 'Sub-Agent', 'Other',
];

const B2B_SERVICES_OFFERED = [
    'Visa Services', 'Flight Booking', 'Hotel Booking', 'Holiday Packages', 'Corporate Travel',
    'Forex', 'Travel Insurance', 'Passport Services', 'Apostille / Attestation', 'Immigration', 'Other',
];

const B2B_VISA_SPECIALIZATION = [
    'Schengen', 'USA', 'UK', 'Canada', 'Australia', 'New Zealand', 'UAE', 'Singapore',
    'Thailand', 'Japan', 'China', 'Hong Kong', 'Other Countries',
];

const B2B_MONTHLY_VOLUME_BANDS = ['1-10', '11-25', '26-50', '51-100', '100+'];

const B2B_DOC_TYPES = [
    'PAN' => 'PAN Card',
    'GST' => 'GST Certificate',
    'CompanyRegistration' => 'Company Registration Certificate',
    'TradeLicense' => 'Trade License',
    'IATA' => 'IATA Certificate',
    'TAFI' => 'TAFI Certificate',
    'AddressProof' => 'Office Address Proof',
    'SignatoryID' => 'Authorized Signatory ID',
    'CompanyProfile' => 'Company Profile',
    'Other' => 'Other Supporting Document',
];
const B2B_DOC_STATUSES = ['Pending', 'Verified', 'Rejected', 'Expired'];
/** Document types whose expiry is worth monitoring — see Phase 9. */
const B2B_DOC_TYPES_WITH_EXPIRY = ['GST', 'TradeLicense', 'IATA', 'CompanyRegistration', 'SignatoryID'];

const B2B_PARTNER_USER_ROLES = ['Owner', 'Manager', 'Visa Executive', 'Accounts Executive'];
const B2B_PARTNER_USER_STATUSES = ['Active', 'Suspended'];
/** Granular permission keys a partner admin can grant/revoke per sub-user (spec §35). */
const B2B_PARTNER_PERMISSIONS = [
    'create_application' => 'Create visa application',
    'view_applications' => 'View applications',
    'upload_documents' => 'Upload documents',
    'view_quotations' => 'View quotations',
    'view_invoices' => 'View invoices',
    'view_payments' => 'View payments',
    'manage_users' => 'Manage users',
];

const B2B_OTP_PURPOSES = ['register', 'login', 'password_reset'];
const B2B_OTP_TTL_SECONDS = 600; // 10 minutes
const B2B_OTP_MAX_ATTEMPTS = 5;

const B2B_TIER_NAMES = ['Silver', 'Gold', 'Platinum', 'Premium'];

const B2B_QUOTATION_STATUSES = ['Draft', 'Sent', 'Accepted', 'Rejected', 'Revision Requested', 'Expired'];
const B2B_INVOICE_STATUSES = ['Draft', 'Issued', 'Partially Paid', 'Paid', 'Overdue', 'Cancelled'];
const B2B_WALLET_TXN_TYPES = ['Credit Added', 'Debit', 'Adjustment', 'Payment Applied'];
const B2B_ANNOUNCEMENT_TARGETS = ['All', 'Tier', 'Country', 'Partner'];

function b2b_db(): PDO
{
    static $migrated = false;
    $pdo = enquiry_db();
    if ($migrated) {
        return $pdo;
    }

    $pdo->exec("CREATE TABLE IF NOT EXISTS b2b_partners (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        application_ref TEXT UNIQUE NOT NULL,
        status TEXT NOT NULL DEFAULT 'Draft',

        company_name TEXT NOT NULL,
        business_type TEXT,
        year_established TEXT,
        website TEXT,
        gst_number TEXT,
        pan_number TEXT,
        iata_registered INTEGER NOT NULL DEFAULT 0,
        iata_number TEXT,
        tafi_number TEXT,
        other_association TEXT,
        address TEXT,
        city TEXT,
        state TEXT,
        country TEXT,
        pin_code TEXT,

        services_offered TEXT,
        visa_specialization TEXT,
        monthly_visa_volume TEXT,

        contact_name TEXT NOT NULL,
        contact_designation TEXT,
        contact_email TEXT NOT NULL,
        contact_mobile TEXT NOT NULL,
        contact_whatsapp TEXT,
        contact_alternate_mobile TEXT,

        tier TEXT,
        credit_limit REAL NOT NULL DEFAULT 0,
        wallet_balance REAL NOT NULL DEFAULT 0,

        assigned_manager_id INTEGER REFERENCES users(id),
        rejection_reason TEXT,
        status_note TEXT,

        ip_address TEXT,
        submitted_at TEXT,
        approved_at TEXT,
        approved_by TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT,
        archived_at TEXT
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS b2b_partner_users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        partner_id INTEGER NOT NULL REFERENCES b2b_partners(id),
        name TEXT NOT NULL,
        designation TEXT,
        email TEXT NOT NULL,
        username TEXT UNIQUE NOT NULL,
        password_hash TEXT NOT NULL,
        mobile TEXT,
        whatsapp TEXT,
        alternate_mobile TEXT,
        role TEXT NOT NULL DEFAULT 'Owner',
        permissions TEXT,
        is_primary INTEGER NOT NULL DEFAULT 0,
        status TEXT NOT NULL DEFAULT 'Active',
        email_verified_at TEXT,
        last_login_at TEXT,
        created_at TEXT NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS b2b_otp_codes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        partner_user_id INTEGER REFERENCES b2b_partner_users(id),
        email TEXT NOT NULL,
        purpose TEXT NOT NULL,
        code_hash TEXT NOT NULL,
        expires_at TEXT NOT NULL,
        consumed_at TEXT,
        attempts INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL,
        ip_address TEXT
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS b2b_partner_documents (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        partner_id INTEGER NOT NULL REFERENCES b2b_partners(id),
        doc_type TEXT NOT NULL,
        original_filename TEXT,
        stored_filename TEXT,
        mime TEXT,
        size INTEGER,
        status TEXT NOT NULL DEFAULT 'Pending',
        expiry_date TEXT,
        rejection_reason TEXT,
        verification_remarks TEXT,
        replaces_document_id INTEGER REFERENCES b2b_partner_documents(id),
        verified_by TEXT,
        verified_at TEXT,
        uploaded_at TEXT NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS b2b_tiers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT UNIQUE NOT NULL,
        default_credit_limit REAL NOT NULL DEFAULT 0,
        default_discount_percent REAL NOT NULL DEFAULT 0,
        sla_hours INTEGER,
        priority_support INTEGER NOT NULL DEFAULT 0,
        is_active INTEGER NOT NULL DEFAULT 1
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS b2b_pricing_rules (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        partner_id INTEGER REFERENCES b2b_partners(id),
        tier_id INTEGER REFERENCES b2b_tiers(id),
        service_category TEXT NOT NULL,
        base_price REAL NOT NULL DEFAULT 0,
        partner_price REAL NOT NULL DEFAULT 0,
        markup_allowed INTEGER NOT NULL DEFAULT 0,
        effective_from TEXT NOT NULL,
        created_by TEXT,
        created_at TEXT NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS b2b_quotations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        quotation_ref TEXT UNIQUE NOT NULL,
        partner_id INTEGER NOT NULL REFERENCES b2b_partners(id),
        enquiry_id INTEGER REFERENCES enquiries(id),
        service_category TEXT,
        country TEXT,
        visa_type TEXT,
        applicants_count INTEGER NOT NULL DEFAULT 1,
        visa_fee REAL NOT NULL DEFAULT 0,
        service_fee REAL NOT NULL DEFAULT 0,
        embassy_fee REAL NOT NULL DEFAULT 0,
        appointment_fee REAL NOT NULL DEFAULT 0,
        courier_fee REAL NOT NULL DEFAULT 0,
        other_charges REAL NOT NULL DEFAULT 0,
        discount REAL NOT NULL DEFAULT 0,
        gst REAL NOT NULL DEFAULT 0,
        total REAL NOT NULL DEFAULT 0,
        valid_until TEXT,
        status TEXT NOT NULL DEFAULT 'Draft',
        revision_note TEXT,
        created_by TEXT,
        created_at TEXT NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS b2b_invoices (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        invoice_number TEXT UNIQUE NOT NULL,
        partner_id INTEGER NOT NULL REFERENCES b2b_partners(id),
        quotation_id INTEGER REFERENCES b2b_quotations(id),
        enquiry_id INTEGER REFERENCES enquiries(id),
        taxable_amount REAL NOT NULL DEFAULT 0,
        gst REAL NOT NULL DEFAULT 0,
        discount REAL NOT NULL DEFAULT 0,
        total REAL NOT NULL DEFAULT 0,
        status TEXT NOT NULL DEFAULT 'Draft',
        due_date TEXT,
        created_by TEXT,
        created_at TEXT NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS b2b_invoice_payments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        invoice_id INTEGER NOT NULL REFERENCES b2b_invoices(id),
        amount REAL NOT NULL,
        method TEXT,
        transaction_id TEXT,
        reference TEXT,
        proof_stored_filename TEXT,
        remarks TEXT,
        recorded_by TEXT,
        payment_date TEXT NOT NULL,
        created_at TEXT NOT NULL
    )");

    // Append-only ledger — rows are never UPDATEd or DELETEd by application
    // code after insert; balance corrections are new Adjustment rows, not
    // edits to history, so the running balance is always reconstructable.
    $pdo->exec("CREATE TABLE IF NOT EXISTS b2b_wallet_transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        partner_id INTEGER NOT NULL REFERENCES b2b_partners(id),
        transaction_ref TEXT UNIQUE NOT NULL,
        type TEXT NOT NULL,
        amount REAL NOT NULL,
        balance_after REAL NOT NULL,
        reason TEXT,
        recorded_by TEXT,
        created_at TEXT NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS b2b_messages (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        partner_id INTEGER NOT NULL REFERENCES b2b_partners(id),
        sender_type TEXT NOT NULL,
        sender_id INTEGER,
        sender_name TEXT,
        subject TEXT,
        body TEXT NOT NULL,
        is_read INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS b2b_announcements (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        body TEXT NOT NULL,
        target_type TEXT NOT NULL DEFAULT 'All',
        target_value TEXT,
        published_by TEXT,
        published_at TEXT NOT NULL,
        expires_at TEXT
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS b2b_ref_counters (
        prefix TEXT NOT NULL,
        year TEXT NOT NULL,
        next_number INTEGER NOT NULL DEFAULT 1,
        PRIMARY KEY (prefix, year)
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS b2b_audit_logs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        entity_type TEXT,
        entity_id INTEGER,
        user_name TEXT,
        role TEXT,
        action TEXT NOT NULL,
        previous_value TEXT,
        new_value TEXT,
        ip_address TEXT,
        created_at TEXT NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS b2b_settings (
        key TEXT PRIMARY KEY,
        value TEXT
    )");

    // Additive columns on existing tables — nullable, so every non-B2B row
    // is untouched. Lets B2B visa cases/enquiries live in the same CRM
    // table and notification system staff already use, instead of a
    // parallel set of tables (per the confirmed architecture decision).
    b2b_ensure_column($pdo, 'enquiries', 'partner_id', 'INTEGER REFERENCES b2b_partners(id)');
    b2b_ensure_column($pdo, 'enquiries', 'partner_user_id', 'INTEGER REFERENCES b2b_partner_users(id)');
    b2b_ensure_column($pdo, 'notifications', 'partner_id', 'INTEGER REFERENCES b2b_partners(id)');
    // Phase 3: a random, unguessable token issued at submission time so a
    // just-registered applicant can upload documents and preview them
    // before Phase 5's partner login exists — without exposing documents
    // via the sequential, guessable application_ref alone.
    b2b_ensure_column($pdo, 'b2b_partners', 'upload_token', 'TEXT');

    b2b_seed_default_settings($pdo);
    b2b_seed_default_tiers($pdo);

    $migrated = true;
    return $pdo;
}

/** Idempotently adds a column to an already-existing table — mirrors forex_ensure_column(). */
function b2b_ensure_column(PDO $pdo, string $table, string $column, string $definition): void
{
    $cols = $pdo->query('PRAGMA table_info(' . $table . ')')->fetchAll(PDO::FETCH_ASSOC);
    foreach ($cols as $c) {
        if ($c['name'] === $column) {
            return;
        }
    }
    $pdo->exec("ALTER TABLE $table ADD COLUMN $column $definition");
}

function b2b_seed_default_settings(PDO $pdo): void
{
    $defaults = [
        'approval_required' => '1',
        'otp_required' => '1',
        'max_upload_size_mb' => '10',
        'allowed_file_types' => json_encode(['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx']),
        'application_ref_prefix' => 'B2B',
        'enquiry_ref_prefix' => 'ENQ-B2B',
        'sms_gateway_status' => 'not_connected',
        'whatsapp_gateway_status' => 'not_connected',
        'email_notifications_enabled' => '1',
    ];
    $stmt = $pdo->prepare('INSERT OR IGNORE INTO b2b_settings (key, value) VALUES (?, ?)');
    foreach ($defaults as $k => $v) {
        $stmt->execute([$k, $v]);
    }
}

function b2b_seed_default_tiers(PDO $pdo): void
{
    $exists = (int) $pdo->query('SELECT COUNT(*) FROM b2b_tiers')->fetchColumn();
    if ($exists > 0) {
        return;
    }
    $defaults = [
        ['Silver', 0, 0, 72, 0],
        ['Gold', 50000, 5, 48, 0],
        ['Platinum', 200000, 10, 24, 1],
        ['Premium', 500000, 15, 12, 1],
    ];
    $stmt = $pdo->prepare('INSERT INTO b2b_tiers (name, default_credit_limit, default_discount_percent, sla_hours, priority_support, is_active) VALUES (?, ?, ?, ?, ?, 1)');
    foreach ($defaults as $t) {
        $stmt->execute($t);
    }
}

function b2b_setting(PDO $pdo, string $key, ?string $default = null): ?string
{
    $stmt = $pdo->prepare('SELECT value FROM b2b_settings WHERE key = ?');
    $stmt->execute([$key]);
    $val = $stmt->fetchColumn();
    return $val !== false ? $val : $default;
}

function b2b_set_setting(PDO $pdo, string $key, string $value): void
{
    $pdo->prepare('INSERT INTO b2b_settings (key, value) VALUES (?, ?) ON CONFLICT(key) DO UPDATE SET value = excluded.value')
        ->execute([$key, $value]);
}

/**
 * Sequential, race-safe reference number generator shared by every B2B
 * prefix (application refs, quotations, invoices, wallet transactions) —
 * exact same transactional-counter pattern as forex_generate_ref(), just
 * parameterised by prefix so one function covers all of them.
 */
function b2b_generate_ref(PDO $pdo, string $prefix): string
{
    $year = gmdate('Y');

    $alreadyInTransaction = $pdo->inTransaction();
    if (!$alreadyInTransaction) {
        $pdo->beginTransaction();
    }
    try {
        $pdo->prepare('INSERT OR IGNORE INTO b2b_ref_counters (prefix, year, next_number) VALUES (?, ?, 1)')->execute([$prefix, $year]);
        $stmt = $pdo->prepare('SELECT next_number FROM b2b_ref_counters WHERE prefix = ? AND year = ?');
        $stmt->execute([$prefix, $year]);
        $number = (int) $stmt->fetchColumn();
        $pdo->prepare('UPDATE b2b_ref_counters SET next_number = ? WHERE prefix = ? AND year = ?')->execute([$number + 1, $prefix, $year]);
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

/**
 * General B2B audit trail — mirrors forex_log_audit()'s exact shape.
 * $entityType is a free-text label ('partner', 'document', 'quotation',
 * 'invoice', 'wallet', 'settings', ...), $entityId nullable for
 * settings-level actions.
 */
function b2b_log_audit(PDO $pdo, ?string $entityType, ?int $entityId, string $userName, string $role, string $action, string $previousValue = '', string $newValue = ''): void
{
    $ip = $_SERVER['REMOTE_ADDR'] ?? null;
    $pdo->prepare('INSERT INTO b2b_audit_logs (entity_type, entity_id, user_name, role, action, previous_value, new_value, ip_address, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)')
        ->execute([$entityType, $entityId, $userName, $role, $action, $previousValue, $newValue, $ip, gmdate('c')]);
}

/** Thin wrapper matching crm_notify()'s/forex_notify()'s shape, scoped to a partner via the additive notifications.partner_id column. */
function b2b_notify(PDO $pdo, ?int $userId, string $type, string $message, ?int $partnerId = null): void
{
    $pdo->prepare('INSERT INTO notifications (user_id, type, message, partner_id, created_at) VALUES (?, ?, ?, ?, ?)')
        ->execute([$userId, $type, $message, $partnerId, gmdate('c')]);
}

function b2b_notify_partner(PDO $pdo, array $partner, string $subject, string $bodyText): void
{
    $email = trim((string) ($partner['contact_email'] ?? ''));
    if ($email === '') {
        return;
    }
    $sent = crm_send_applicant_email($email, $subject, $bodyText);
    b2b_log_audit(
        $pdo,
        'partner',
        (int) $partner['id'],
        'System',
        'System',
        'partner_email_' . ($sent ? 'sent' : 'failed'),
        '',
        $subject
    );
}

/**
 * Duplicate-application check (spec §27) — queries active/pending
 * applications by any of the identity fields a genuine duplicate would
 * share. Returns the matching partner row, or null if none found.
 */
function b2b_find_duplicate_partner(PDO $pdo, array $fields): ?array
{
    $conditions = [];
    $params = [];
    $map = [
        'contact_email' => $fields['contact_email'] ?? null,
        'contact_mobile' => $fields['contact_mobile'] ?? null,
        'company_name' => $fields['company_name'] ?? null,
        'gst_number' => $fields['gst_number'] ?? null,
        'pan_number' => $fields['pan_number'] ?? null,
        'iata_number' => $fields['iata_number'] ?? null,
    ];
    foreach ($map as $column => $value) {
        $value = trim((string) $value);
        if ($value === '') {
            continue;
        }
        $conditions[] = "$column = ?";
        $params[] = $value;
    }
    if (!$conditions) {
        return null;
    }
    $sql = 'SELECT * FROM b2b_partners WHERE archived_at IS NULL AND status != \'Rejected\' AND (' . implode(' OR ', $conditions) . ') LIMIT 1';
    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);
    $row = $stmt->fetch(PDO::FETCH_ASSOC);
    return $row ?: null;
}

/**
 * Looks up a partner by application_ref + upload_token (Phase 3's
 * pre-login document upload/preview gate). Returns null if the ref
 * doesn't exist or the token doesn't match — deliberately the same
 * generic failure for both, so a wrong token can't be used to probe
 * whether a given ref exists.
 */
function b2b_partner_by_token(PDO $pdo, string $applicationRef, string $token): ?array
{
    if ($token === '') {
        return null;
    }
    $stmt = $pdo->prepare('SELECT * FROM b2b_partners WHERE application_ref = ? AND archived_at IS NULL');
    $stmt->execute([$applicationRef]);
    $partner = $stmt->fetch(PDO::FETCH_ASSOC);
    if (!$partner || !$partner['upload_token'] || !hash_equals($partner['upload_token'], $token)) {
        return null;
    }
    return $partner;
}

/** Matches forex_status_class()'s exact slug-generation pattern — one CSS rule per status lives in admin.css. */
function b2b_status_class(string $status): string
{
    return 'b2b-status-' . strtolower(str_replace([' ', '/'], ['-', ''], $status));
}

function b2b_doc_status_class(string $status): string
{
    return 'b2b-doc-' . strtolower(str_replace(' ', '-', $status));
}
