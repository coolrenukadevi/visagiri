<?php
/**
 * SQLite-backed storage for the Visa Enquiry CRM. Single connection point so
 * the schema only lives in one place; the public enquiry popup handler and
 * every admin page include this file to get a ready PDO handle.
 */

// Required at true top-level scope (not inside a function) so $site_email
// etc. become real PHP globals exactly once, regardless of which function
// happens to touch this file first — required_once inside a function body
// only defines variables in that function's local scope.
require_once __DIR__ . '/site-contact.php';

const CRM_STATUSES = [
    'New Enquiry', 'Contacted', 'Documents Pending', 'Documents Under Review', 'Documents Approved',
    'Payment Pending', 'Application Preparation', 'Application Submitted', 'Under Embassy Processing',
    'Additional Documents Required', 'Decision Received', 'Visa Approved', 'Visa Refused',
    'Passport Ready', 'Completed', 'Cancelled',
];
const CRM_OPEN_STATUSES = [
    'New Enquiry', 'Contacted', 'Documents Pending', 'Documents Under Review', 'Documents Approved',
    'Payment Pending', 'Application Preparation', 'Application Submitted', 'Under Embassy Processing',
    'Additional Documents Required', 'Decision Received',
];
const CRM_CLOSED_STATUSES = ['Visa Approved', 'Visa Refused', 'Passport Ready', 'Completed', 'Cancelled'];
const CRM_PRIORITIES = ['High', 'Medium', 'Low'];
const CRM_SOURCES = ['Website', 'WhatsApp', 'Phone', 'Email', 'Walk-in', 'Referral', 'Social Media', 'Google', 'Partner'];
const CRM_VISA_CATEGORIES = [
    'Tourist Visa', 'Business Visa', 'Student Visa', 'Work Visa', 'Dependent Visa',
    'Transit Visa', 'Immigration', 'Conference Visa', 'Sports Visa', 'Medical Visa', 'Other',
    'General Enquiry', 'Apostille & Attestation', 'Forex Assistance', 'Travel Insurance',
    'Flight & Hotel Assistance', 'Other Services',
];
const CRM_ROLES = [
    'Super Admin', 'Admin', 'Sales Manager', 'Travel Consultant', 'Visa Consultant', 'Accounts',
    'Forex Manager', 'Forex Executive', 'Compliance / Audit',
    'B2B Admin', 'B2B Relationship Manager', 'Support Executive',
];
const CRM_FOLLOWUP_TYPES = ['Call', 'WhatsApp', 'Email', 'Meeting'];
const CRM_PAYMENT_METHODS = ['Cash', 'UPI', 'Bank Transfer', 'Credit Card', 'Debit Card', 'Cheque', 'Other'];
const CRM_DECISIONS = ['Pending', 'Approved', 'Refused'];
const CRM_DOC_CATEGORIES = [
    'Passport Scan Copy', 'Photograph', 'Flight Tickets', 'Hotel Reservation', 'Bank Statement',
    'ITR', 'Employment Certificate', 'Salary Slip', 'Cover Letter', 'Invitation Letter',
    'Travel Insurance', 'Business Documents', 'Previous Visa', 'Other Documents',
];
const CRM_DOC_STATUSES = ['Pending', 'Uploaded', 'Verified', 'Rejected'];

function enquiry_db(): PDO
{
    static $pdo = null;
    if ($pdo !== null) {
        return $pdo;
    }

    $dataDir = __DIR__ . '/../data';
    if (!is_dir($dataDir)) {
        mkdir($dataDir, 0770, true);
    }

    $pdo = new PDO('sqlite:' . $dataDir . '/enquiries.db');
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $pdo->exec('PRAGMA foreign_keys = ON');

    $pdo->exec("CREATE TABLE IF NOT EXISTS enquiries (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        enquiry_ref TEXT UNIQUE NOT NULL,
        tracking_code TEXT UNIQUE,
        expected_completion_date TEXT,

        -- Customer information
        full_name TEXT NOT NULL,
        email TEXT NOT NULL,
        mobile TEXT NOT NULL,
        whatsapp_number TEXT,
        date_of_birth TEXT,
        gender TEXT,
        nationality TEXT,
        passport_number TEXT,
        passport_expiry TEXT,
        current_city TEXT,
        country_residence TEXT,
        contact_method TEXT,

        -- Visa requirement
        visa_category TEXT NOT NULL,
        service_required TEXT NOT NULL,
        destination_country TEXT NOT NULL,
        visa_type TEXT NOT NULL,
        purpose TEXT,
        travel_date TEXT NOT NULL,
        expected_stay_duration TEXT,
        travellers INTEGER NOT NULL,
        previous_visa_history TEXT,
        previous_refusal TEXT,
        urgency TEXT,

        -- Travel information
        departure_city TEXT,
        arrival_city TEXT,
        flight_status TEXT,
        hotel_required TEXT,
        insurance_required TEXT,
        invitation_letter TEXT,
        sponsorship TEXT,
        accommodation_details TEXT,

        -- Lead / assignment information
        source TEXT NOT NULL DEFAULT 'Website',
        campaign TEXT,
        referral_name TEXT,
        partner TEXT,
        assigned_to TEXT,
        visa_consultant TEXT,
        sales_manager TEXT,
        priority TEXT NOT NULL DEFAULT 'Medium',
        estimated_value REAL,
        conversion_probability INTEGER,
        lost_reason TEXT,

        -- Financial (lightweight, ahead of the full Payments module)
        quoted_amount REAL,
        discount_amount REAL,
        paid_amount REAL,

        -- Application tracking
        application_number TEXT,
        appointment_date TEXT,
        submission_date TEXT,
        decision_date TEXT,
        decision TEXT,

        message TEXT,
        source_url TEXT,
        utm_source TEXT,
        utm_medium TEXT,
        utm_campaign TEXT,
        utm_term TEXT,
        utm_content TEXT,

        status TEXT NOT NULL DEFAULT 'New Enquiry',
        follow_up_date TEXT,
        archived_at TEXT,

        ip_address TEXT,
        user_agent TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS status_updates (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        enquiry_id INTEGER NOT NULL REFERENCES enquiries(id) ON DELETE CASCADE,
        previous_status TEXT,
        new_status TEXT NOT NULL,
        message TEXT,
        updated_by TEXT,
        notified INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS tracking_attempts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        ip_address TEXT NOT NULL,
        created_at TEXT NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS payments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        enquiry_id INTEGER NOT NULL REFERENCES enquiries(id) ON DELETE CASCADE,
        amount REAL NOT NULL,
        payment_method TEXT,
        reference_number TEXT,
        payment_date TEXT NOT NULL,
        notes TEXT,
        recorded_by TEXT,
        created_at TEXT NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS enquiry_documents (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        enquiry_id INTEGER NOT NULL REFERENCES enquiries(id) ON DELETE CASCADE,
        category TEXT NOT NULL,
        original_filename TEXT NOT NULL,
        stored_filename TEXT NOT NULL,
        file_type TEXT NOT NULL,
        file_size INTEGER NOT NULL,
        status TEXT NOT NULL DEFAULT 'Uploaded',
        verified_by TEXT,
        verified_at TEXT,
        uploaded_at TEXT NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS enquiry_notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        enquiry_id INTEGER NOT NULL REFERENCES enquiries(id) ON DELETE CASCADE,
        note TEXT NOT NULL,
        created_by TEXT,
        created_at TEXT NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS follow_ups (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        enquiry_id INTEGER NOT NULL REFERENCES enquiries(id) ON DELETE CASCADE,
        follow_up_date TEXT NOT NULL,
        follow_up_time TEXT,
        type TEXT NOT NULL DEFAULT 'Call',
        reminder INTEGER NOT NULL DEFAULT 0,
        assigned_to TEXT,
        notes TEXT,
        completed_at TEXT,
        created_by TEXT,
        created_at TEXT NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS activities (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        enquiry_id INTEGER NOT NULL REFERENCES enquiries(id) ON DELETE CASCADE,
        user_name TEXT,
        action TEXT NOT NULL,
        notes TEXT,
        created_at TEXT NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS notifications (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
        type TEXT NOT NULL,
        message TEXT NOT NULL,
        enquiry_id INTEGER REFERENCES enquiries(id) ON DELETE CASCADE,
        is_read INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS submission_tokens (
        token TEXT PRIMARY KEY,
        enquiry_ref TEXT NOT NULL,
        created_at TEXT NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        username TEXT UNIQUE NOT NULL,
        email TEXT,
        password_hash TEXT NOT NULL,
        role TEXT NOT NULL DEFAULT 'Admin',
        created_at TEXT NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS newsletter_subscribers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT UNIQUE NOT NULL,
        source_url TEXT,
        is_active INTEGER NOT NULL DEFAULT 1,
        created_at TEXT NOT NULL
    )");

    /**
     * Sequential per-service-per-year reference number counters, e.g.
     * VG-VISA-2026-000125. Same safe transactional-increment pattern as
     * forex_ref_counters — a real counter, not a random suffix, so refs
     * are gap-free and predictable within a service+year.
     */
    $pdo->exec("CREATE TABLE IF NOT EXISTS enquiry_ref_counters (
        prefix TEXT NOT NULL,
        year TEXT NOT NULL,
        next_number INTEGER NOT NULL DEFAULT 1,
        PRIMARY KEY (prefix, year)
    )");

    /**
     * Lightweight first-party analytics events for the Quick Enquiry
     * widget and floating contact button — no third-party analytics
     * platform exists in this codebase, so this is a real, minimal,
     * self-hosted event log rather than a fake tracking claim. Only
     * event/service/page context is stored, never personal details.
     */
    $pdo->exec("CREATE TABLE IF NOT EXISTS enquiry_analytics_events (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        event_type TEXT NOT NULL,
        service TEXT,
        purpose TEXT,
        page_url TEXT,
        session_id TEXT,
        created_at TEXT NOT NULL
    )");

    $userCount = (int) $pdo->query('SELECT COUNT(*) FROM users')->fetchColumn();
    if ($userCount === 0) {
        // Bcrypt hash of the admin password chosen at setup time. The plaintext
        // itself is never stored in source control — only this one-way hash.
        $defaultPasswordHash = '$2y$12$aWyLe9tdTUiaIaoT412MzufM.JX0adjtg8Jm.opuPNA0KRx40SfWC';
        $stmt = $pdo->prepare('INSERT INTO users (name, username, password_hash, role, created_at) VALUES (?, ?, ?, ?, ?)');
        $stmt->execute(['Administrator', 'admin', $defaultPasswordHash, 'Super Admin', gmdate('c')]);
    }

    return $pdo;
}

/**
 * Maps a service_required/visa_category value to the short prefix used in
 * reference numbers and, indirectly, auto-assignment. Centralised here so
 * ref generation and routing never drift apart.
 */
function enquiry_service_prefix(string $serviceRequired): string
{
    if ($serviceRequired === 'Apostille & Attestation') return 'APOS';
    if ($serviceRequired === 'Forex Assistance') return 'FOREX';
    if (in_array($serviceRequired, ['Travel Insurance', 'Flight & Hotel Assistance'], true)) return 'TRAVEL';
    if (in_array($serviceRequired, ['General Enquiry', 'Other Services'], true)) return 'GEN';
    return 'VISA';
}

/**
 * Sequential, gap-free, per-service-per-year reference number:
 * VG-VISA-2026-000125. Replaces the old random-suffix VA-YYYYMMDD-XXXXX
 * scheme sitewide (same safe transactional-increment pattern already
 * proven by forex_generate_ref()) — existing enquiries keep their old
 * refs untouched, only new ones use this format. $serviceRequired may be
 * '' for legacy call sites that haven't been updated yet, which falls
 * back to the VISA prefix.
 */
function enquiry_generate_ref(PDO $pdo, string $serviceRequired = ''): string
{
    $prefix = enquiry_service_prefix($serviceRequired);
    $year = gmdate('Y');

    $alreadyInTransaction = $pdo->inTransaction();
    if (!$alreadyInTransaction) {
        $pdo->beginTransaction();
    }
    try {
        $pdo->prepare('INSERT OR IGNORE INTO enquiry_ref_counters (prefix, year, next_number) VALUES (?, ?, 1)')->execute([$prefix, $year]);
        $stmt = $pdo->prepare('SELECT next_number FROM enquiry_ref_counters WHERE prefix = ? AND year = ?');
        $stmt->execute([$prefix, $year]);
        $number = (int) $stmt->fetchColumn();
        $pdo->prepare('UPDATE enquiry_ref_counters SET next_number = ? WHERE prefix = ? AND year = ?')->execute([$number + 1, $prefix, $year]);
        if (!$alreadyInTransaction) {
            $pdo->commit();
        }
    } catch (Throwable $e) {
        if (!$alreadyInTransaction && $pdo->inTransaction()) {
            $pdo->rollBack();
        }
        throw $e;
    }

    return sprintf('VG-%s-%s-%06d', $prefix, $year, $number);
}

/**
 * Real (if simple) auto-assignment: routes a new enquiry to the
 * least-loaded staff member holding the role responsible for that
 * service, so leads don't all pile onto one person. Falls back to the
 * first Super Admin if no one holds the target role yet. Returns null
 * only if there are no users at all (never happens once the default
 * admin account exists).
 */
function enquiry_auto_assign(PDO $pdo, string $serviceRequired): ?array
{
    $roleMap = [
        'Forex Assistance' => 'Forex Executive',
        'Travel Insurance' => 'Travel Consultant',
        'Flight & Hotel Assistance' => 'Travel Consultant',
        'General Enquiry' => 'Sales Manager',
        'Other Services' => 'Sales Manager',
    ];
    $role = $roleMap[$serviceRequired] ?? 'Visa Consultant';

    $placeholders = implode(',', array_fill(0, count(CRM_OPEN_STATUSES), '?'));
    $stmt = $pdo->prepare("
        SELECT u.id, u.name,
            (SELECT COUNT(*) FROM enquiries e WHERE e.assigned_to = u.name AND e.archived_at IS NULL AND e.status IN ($placeholders)) AS open_count
        FROM users u
        WHERE u.role = ?
        ORDER BY open_count ASC, u.id ASC
        LIMIT 1
    ");
    $stmt->execute(array_merge(CRM_OPEN_STATUSES, [$role]));
    $pick = $stmt->fetch(PDO::FETCH_ASSOC);
    if ($pick) {
        return ['name' => $pick['name'], 'role' => $role];
    }

    $fallback = $pdo->query("SELECT name FROM users WHERE role = 'Super Admin' ORDER BY id ASC LIMIT 1")->fetch(PDO::FETCH_ASSOC);
    if ($fallback) {
        return ['name' => $fallback['name'], 'role' => 'Super Admin (fallback — no ' . $role . ' on staff yet)'];
    }
    return null;
}

function crm_log_activity(PDO $pdo, int $enquiryId, string $userName, string $action, string $notes = ''): void
{
    $stmt = $pdo->prepare('INSERT INTO activities (enquiry_id, user_name, action, notes, created_at) VALUES (?, ?, ?, ?, ?)');
    $stmt->execute([$enquiryId, $userName, $action, $notes, gmdate('c')]);
}

function crm_notify(PDO $pdo, ?int $userId, string $type, string $message, ?int $enquiryId = null): void
{
    $stmt = $pdo->prepare('INSERT INTO notifications (user_id, type, message, enquiry_id, created_at) VALUES (?, ?, ?, ?, ?)');
    $stmt->execute([$userId, $type, $message, $enquiryId, gmdate('c')]);
}

function crm_status_class(string $status): string
{
    return 'status-' . strtolower(str_replace(' ', '-', $status));
}

function crm_followup_state(string $date, ?string $completedAt): string
{
    if ($completedAt) {
        return 'Completed';
    }
    $today = gmdate('Y-m-d');
    if ($date < $today) {
        return 'Overdue';
    }
    if ($date === $today) {
        return 'Due Today';
    }
    return 'Upcoming';
}

/** Public-facing applicant tracking code — never the internal enquiry_ref or numeric id. */
function crm_generate_tracking_code(PDO $pdo): string
{
    $chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    do {
        $suffix = '';
        for ($i = 0; $i < 6; $i++) {
            $suffix .= $chars[random_int(0, strlen($chars) - 1)];
        }
        $code = 'VISA-' . gmdate('Y') . '-' . $suffix;
        $stmt = $pdo->prepare('SELECT COUNT(*) FROM enquiries WHERE tracking_code = ?');
        $stmt->execute([$code]);
        $exists = (int) $stmt->fetchColumn() > 0;
    } while ($exists);

    return $code;
}

function crm_mask_passport(?string $passport): string
{
    $passport = trim((string) $passport);
    if ($passport === '') return '—';
    if (strlen($passport) <= 4) return str_repeat('X', strlen($passport));
    return str_repeat('X', strlen($passport) - 4) . substr($passport, -4);
}

function crm_mask_mobile(?string $mobile): string
{
    $digits = preg_replace('/\D/', '', (string) $mobile);
    if (strlen($digits) <= 4) return str_repeat('*', strlen($digits));
    return str_repeat('*', strlen($digits) - 4) . substr($digits, -4);
}

function crm_mask_email(?string $email): string
{
    $email = trim((string) $email);
    if (strpos($email, '@') === false) return '—';
    [$local, $domain] = explode('@', $email, 2);
    if ($local === '') return '@' . $domain;
    return $local[0] . str_repeat('*', max(1, strlen($local) - 1)) . '@' . $domain;
}

/**
 * Maps a CRM status to the 8-stage applicant timeline. Each entry is
 * 'done' | 'current' | 'pending' | 'na'. Cancelled is handled separately
 * by the caller since it isn't a point on the normal linear progression.
 */
function crm_timeline_stages(string $status): array
{
    $table = [
        'New Enquiry'                   => ['done', 'pending', 'pending', 'pending', 'pending', 'pending', 'pending', 'pending'],
        'Contacted'                     => ['done', 'pending', 'pending', 'pending', 'pending', 'pending', 'pending', 'pending'],
        'Documents Pending'             => ['done', 'current', 'pending', 'pending', 'pending', 'pending', 'pending', 'pending'],
        'Documents Under Review'        => ['done', 'current', 'pending', 'pending', 'pending', 'pending', 'pending', 'pending'],
        'Additional Documents Required' => ['done', 'current', 'pending', 'pending', 'pending', 'pending', 'pending', 'pending'],
        'Documents Approved'            => ['done', 'done', 'current', 'pending', 'pending', 'pending', 'pending', 'pending'],
        'Payment Pending'               => ['done', 'done', 'done', 'current', 'pending', 'pending', 'pending', 'pending'],
        'Application Preparation'       => ['done', 'done', 'done', 'current', 'pending', 'pending', 'pending', 'pending'],
        'Application Submitted'         => ['done', 'done', 'done', 'done', 'current', 'pending', 'pending', 'pending'],
        'Under Embassy Processing'      => ['done', 'done', 'done', 'done', 'done', 'current', 'pending', 'pending'],
        'Decision Received'             => ['done', 'done', 'done', 'done', 'done', 'done', 'current', 'pending'],
        'Visa Approved'                 => ['done', 'done', 'done', 'done', 'done', 'done', 'done', 'current'],
        'Visa Refused'                  => ['done', 'done', 'done', 'done', 'done', 'done', 'done', 'na'],
        'Passport Ready'                => ['done', 'done', 'done', 'done', 'done', 'done', 'done', 'done'],
        'Completed'                     => ['done', 'done', 'done', 'done', 'done', 'done', 'done', 'done'],
    ];
    return $table[$status] ?? array_fill(0, 8, 'pending');
}

function crm_timeline_labels(): array
{
    return [
        'Enquiry Submitted', 'Documents Under Review', 'Documentation Completed', 'Application Prepared',
        'Application Submitted', 'Embassy/Consulate Processing', 'Decision Received', 'Passport / Visa Ready',
    ];
}

function crm_log_status_change(PDO $pdo, int $enquiryId, ?string $previousStatus, string $newStatus, string $updatedBy, string $message = '', bool $notified = false): void
{
    $stmt = $pdo->prepare('INSERT INTO status_updates (enquiry_id, previous_status, new_status, message, updated_by, notified, created_at) VALUES (?, ?, ?, ?, ?, ?, ?)');
    $stmt->execute([$enquiryId, $previousStatus, $newStatus, $message, $updatedBy, $notified ? 1 : 0, gmdate('c')]);
}

/** Thin wrapper around mail() so every applicant-facing email looks consistent. */
function crm_send_applicant_email(string $to, string $subject, string $bodyText): bool
{
    global $site_email;
    $headers = "From: VisaAgency.in <{$site_email}>\r\nContent-Type: text/plain; charset=UTF-8";
    return @mail($to, $subject, $bodyText, $headers);
}

/** Internal copy of every new customer enquiry, forwarded to the parent company. */
const CRM_STAFF_FORWARD_EMAIL = 'info@tripgation.com';

function crm_send_staff_email(string $subject, string $bodyText): bool
{
    global $site_email;
    $headers = "From: VisaAgency.in <{$site_email}>\r\nContent-Type: text/plain; charset=UTF-8";
    return @mail(CRM_STAFF_FORWARD_EMAIL, $subject, $bodyText, $headers);
}

const CRM_PAYMENT_STATUSES = ['Not Quoted', 'Payment Pending', 'Partially Paid', 'Paid'];

/**
 * Computed financial state of an enquiry, derived from quoted/discount/paid
 * amounts rather than stored directly, so it's always in sync with the
 * payments ledger. Returns ['label', 'class', 'balance'].
 */
function crm_payment_status(array $enquiry): array
{
    $quoted = (float) ($enquiry['quoted_amount'] ?? 0);
    $discount = (float) ($enquiry['discount_amount'] ?? 0);
    $paid = (float) ($enquiry['paid_amount'] ?? 0);
    $balance = max(0, $quoted - $discount - $paid);

    if ($quoted <= 0) {
        $label = 'Not Quoted';
    } elseif ($paid <= 0) {
        $label = 'Payment Pending';
    } elseif ($balance > 0.01) {
        $label = 'Partially Paid';
    } else {
        $label = 'Paid';
    }

    return ['label' => $label, 'class' => 'payment-' . strtolower(str_replace(' ', '-', $label)), 'balance' => $balance];
}
