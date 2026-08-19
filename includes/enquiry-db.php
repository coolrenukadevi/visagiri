<?php
/**
 * SQLite-backed storage for website enquiries. Single connection point so the
 * schema only lives in one place; both enquiry-handler.php and the admin
 * dashboard include this file to get a ready PDO handle.
 */

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
        full_name TEXT NOT NULL,
        email TEXT NOT NULL,
        mobile TEXT NOT NULL,
        country_residence TEXT,
        contact_method TEXT,
        service_required TEXT NOT NULL,
        destination_country TEXT NOT NULL,
        visa_type TEXT NOT NULL,
        travel_date TEXT NOT NULL,
        travellers INTEGER NOT NULL,
        purpose TEXT,
        message TEXT,
        source_url TEXT,
        utm_source TEXT,
        utm_medium TEXT,
        utm_campaign TEXT,
        utm_term TEXT,
        utm_content TEXT,
        status TEXT NOT NULL DEFAULT 'New',
        assigned_consultant TEXT,
        follow_up_date TEXT,
        ip_address TEXT,
        user_agent TEXT,
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
        uploaded_at TEXT NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS enquiry_notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        enquiry_id INTEGER NOT NULL REFERENCES enquiries(id) ON DELETE CASCADE,
        note TEXT NOT NULL,
        created_by TEXT,
        created_at TEXT NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS submission_tokens (
        token TEXT PRIMARY KEY,
        enquiry_ref TEXT NOT NULL,
        created_at TEXT NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS admin_users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE NOT NULL,
        password_hash TEXT NOT NULL,
        created_at TEXT NOT NULL
    )");

    $adminCount = (int) $pdo->query('SELECT COUNT(*) FROM admin_users')->fetchColumn();
    if ($adminCount === 0) {
        // Bcrypt hash of the admin password chosen at setup time. The plaintext
        // itself is never stored in source control — only this one-way hash.
        $defaultPasswordHash = '$2y$12$aWyLe9tdTUiaIaoT412MzufM.JX0adjtg8Jm.opuPNA0KRx40SfWC';
        $stmt = $pdo->prepare('INSERT INTO admin_users (username, password_hash, created_at) VALUES (?, ?, ?)');
        $stmt->execute(['admin', $defaultPasswordHash, gmdate('c')]);
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
