<?php
/**
 * SQLite-backed storage for the Visa Enquiry CRM. Single connection point so
 * the schema only lives in one place; the public enquiry popup handler and
 * every admin page include this file to get a ready PDO handle.
 */

const CRM_STATUSES = [
    'New', 'Contacted', 'Qualified', 'Documents Pending', 'Application Processing',
    'Submitted', 'Visa Approved', 'Visa Rejected', 'Closed', 'Lost',
];
const CRM_OPEN_STATUSES = ['New', 'Contacted', 'Qualified', 'Documents Pending', 'Application Processing', 'Submitted'];
const CRM_PRIORITIES = ['High', 'Medium', 'Low'];
const CRM_SOURCES = ['Website', 'WhatsApp', 'Phone', 'Email', 'Walk-in', 'Referral', 'Social Media', 'Google', 'Partner'];
const CRM_VISA_CATEGORIES = [
    'Tourist Visa', 'Business Visa', 'Student Visa', 'Work Visa', 'Dependent Visa',
    'Transit Visa', 'Immigration', 'Conference Visa', 'Sports Visa', 'Medical Visa', 'Other',
];
const CRM_ROLES = ['Super Admin', 'Admin', 'Sales Manager', 'Travel Consultant', 'Visa Consultant', 'Accounts'];
const CRM_FOLLOWUP_TYPES = ['Call', 'WhatsApp', 'Email', 'Meeting'];
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

        -- Application tracking (lightweight, ahead of the full Applications module)
        application_number TEXT,
        appointment_date TEXT,
        submission_date TEXT,
        decision_date TEXT,

        message TEXT,
        source_url TEXT,
        utm_source TEXT,
        utm_medium TEXT,
        utm_campaign TEXT,
        utm_term TEXT,
        utm_content TEXT,

        status TEXT NOT NULL DEFAULT 'New',
        follow_up_date TEXT,
        archived_at TEXT,

        ip_address TEXT,
        user_agent TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT
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

function enquiry_generate_ref(PDO $pdo): string
{
    $chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    do {
        $suffix = '';
        for ($i = 0; $i < 5; $i++) {
            $suffix .= $chars[random_int(0, strlen($chars) - 1)];
        }
        $ref = 'VA-' . gmdate('Ymd') . '-' . $suffix;
        $stmt = $pdo->prepare('SELECT COUNT(*) FROM enquiries WHERE enquiry_ref = ?');
        $stmt->execute([$ref]);
        $exists = (int) $stmt->fetchColumn() > 0;
    } while ($exists);

    return $ref;
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
