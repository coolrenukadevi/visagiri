<?php
/**
 * The central CRM enquiry engine: one record per visa/forex/etc. enquiry,
 * always tied to a customer (see customer_auth.php), always carrying a
 * human-readable code (CV-2026-000001) generated the same way
 * customer_code_for() works.
 *
 * What's deliberately NOT here yet, and why: enquiry_assignments as its own
 * history table, internal_notes, and a communication/message thread are all
 * real fields in the original spec, but nothing in the codebase can read or
 * write them yet — there is no employee console (that's Phase 7) to assign
 * an enquiry to, view an internal note, or reply in a thread. Building that
 * storage now, with zero UI ever touching it, is exactly the kind of
 * unused-until-later machinery this project avoids elsewhere. `enquiries`
 * carries nullable assigned_employee/assigned_department/sla_due_at columns
 * so Phase 7 can start writing to THIS table rather than migrating data into
 * a new one; the history/notes/messages tables get built when something
 * exists to use them.
 */
declare(strict_types=1);

require_once __DIR__ . '/customer_auth.php';

function enquiry_migrate(PDO $pdo): void
{
    $pdo->exec("
        CREATE TABLE IF NOT EXISTS service_types (
            id          INTEGER PRIMARY KEY AUTOINCREMENT,
            code        TEXT UNIQUE NOT NULL,
            label       TEXT NOT NULL,
            sort_order  INTEGER NOT NULL DEFAULT 0
        )");
    $pdo->exec("
        CREATE TABLE IF NOT EXISTS enquiries (
            id                   INTEGER PRIMARY KEY AUTOINCREMENT,
            enquiry_code         TEXT UNIQUE NOT NULL,
            customer_id          INTEGER NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
            service_type_id      INTEGER NOT NULL REFERENCES service_types(id),
            country              TEXT NOT NULL,
            travel_purpose       TEXT NOT NULL,
            travel_date          TEXT,
            message              TEXT NOT NULL DEFAULT '',
            customer_notes       TEXT NOT NULL DEFAULT '',
            priority             TEXT NOT NULL DEFAULT 'Normal',
            status               TEXT NOT NULL DEFAULT 'New',
            assigned_employee    TEXT,
            assigned_department  TEXT,
            sla_due_at           INTEGER,
            created_at           INTEGER NOT NULL,
            updated_at           INTEGER NOT NULL
        )");
    $pdo->exec('CREATE INDEX IF NOT EXISTS idx_enquiries_customer ON enquiries(customer_id)');
    $pdo->exec("
        CREATE TABLE IF NOT EXISTS enquiry_status_history (
            id           INTEGER PRIMARY KEY AUTOINCREMENT,
            enquiry_id   INTEGER NOT NULL REFERENCES enquiries(id) ON DELETE CASCADE,
            status       TEXT NOT NULL,
            note         TEXT NOT NULL DEFAULT '',
            created_at   INTEGER NOT NULL
        )");
    $pdo->exec('CREATE INDEX IF NOT EXISTS idx_status_history_enquiry ON enquiry_status_history(enquiry_id)');

    // Seed once. INSERT OR IGNORE on the UNIQUE code makes this idempotent —
    // safe to run on every request the same way the table-create calls are.
    $seed = $pdo->prepare('INSERT OR IGNORE INTO service_types (code, label, sort_order) VALUES (?, ?, ?)');
    foreach ([
        ['visa', 'Visa Services', 1],
        ['forex', 'Forex Services', 2],
        ['travel_insurance', 'Travel Insurance', 3],
        ['travel_documentation', 'Travel Documentation', 4],
        ['apostille', 'Apostille / Attestation', 5],
        ['other', 'Other Travel Services', 6],
    ] as [$code, $label, $order]) {
        $seed->execute([$code, $label, $order]);
    }
}

function enquiry_db(): ?PDO
{
    static $migrated = false;
    $pdo = customer_db();
    if (!$pdo) return null;
    if (!$migrated) {
        enquiry_migrate($pdo);
        $migrated = true;
    }
    return $pdo;
}

function service_types_all(): array
{
    $pdo = enquiry_db();
    if (!$pdo) return [];
    return $pdo->query('SELECT * FROM service_types ORDER BY sort_order')->fetchAll();
}

function service_type_find(int $id): ?array
{
    $pdo = enquiry_db();
    if (!$pdo) return null;
    $st = $pdo->prepare('SELECT * FROM service_types WHERE id = ?');
    $st->execute([$id]);
    return $st->fetch() ?: null;
}

function enquiry_code_for(int $id, int $year): string
{
    return 'CV-' . $year . '-' . str_pad((string) $id, 6, '0', STR_PAD_LEFT);
}

/**
 * @param array $p Validated {service_type_id, country, travel_purpose,
 *                 travel_date, message} — see enquire.php for the checks
 *                 run before this is ever called.
 * @return array{0:?int,1:string,2:?string} [enquiry id, error, code]
 */
function enquiry_create(int $customerId, array $p): array
{
    $pdo = enquiry_db();
    if (!$pdo) return [null, 'Enquiries are temporarily unavailable. Please try again shortly.', null];

    try {
        $pdo->beginTransaction();
        $now = time();
        $st = $pdo->prepare('
            INSERT INTO enquiries
                (enquiry_code, customer_id, service_type_id, country, travel_purpose, travel_date, message, status, created_at, updated_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)');
        $st->execute([
            'PENDING', $customerId, $p['service_type_id'], $p['country'], $p['travel_purpose'],
            $p['travel_date'] ?: null, $p['message'], 'New', $now, $now,
        ]);
        $id = (int) $pdo->lastInsertId();
        $code = enquiry_code_for($id, (int) date('Y', $now));
        $pdo->prepare('UPDATE enquiries SET enquiry_code = ? WHERE id = ?')->execute([$code, $id]);

        $pdo->prepare('INSERT INTO enquiry_status_history (enquiry_id, status, note, created_at) VALUES (?, ?, ?, ?)')
            ->execute([$id, 'New', 'Enquiry submitted.', $now]);

        $pdo->commit();
        return [$id, '', $code];
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        log_error('enquiries: create failed — ' . $e->getMessage());
        return [null, 'Something went wrong submitting your enquiry. Please try again.', null];
    }
}

/** Every enquiry for a customer, newest first, with its service label joined in. */
function enquiries_for_customer(int $customerId): array
{
    $pdo = enquiry_db();
    if (!$pdo) return [];
    $st = $pdo->prepare('
        SELECT e.*, s.label AS service_label
        FROM enquiries e JOIN service_types s ON s.id = e.service_type_id
        WHERE e.customer_id = ?
        ORDER BY e.created_at DESC');
    $st->execute([$customerId]);
    return $st->fetchAll();
}

function enquiry_find_by_code(string $code): ?array
{
    $pdo = enquiry_db();
    if (!$pdo) return null;
    $st = $pdo->prepare('
        SELECT e.*, s.label AS service_label
        FROM enquiries e JOIN service_types s ON s.id = e.service_type_id
        WHERE e.enquiry_code = ?');
    $st->execute([$code]);
    return $st->fetch() ?: null;
}

function enquiry_status_history_for(int $enquiryId): array
{
    $pdo = enquiry_db();
    if (!$pdo) return [];
    $st = $pdo->prepare('SELECT * FROM enquiry_status_history WHERE enquiry_id = ? ORDER BY created_at, id');
    $st->execute([$enquiryId]);
    return $st->fetchAll();
}

function enquiry_set_customer_notes(int $enquiryId, string $notes): void
{
    $pdo = enquiry_db();
    if (!$pdo) return;
    $pdo->prepare('UPDATE enquiries SET customer_notes = ?, updated_at = ? WHERE id = ?')
        ->execute([$notes, time(), $enquiryId]);
}

/** Active = not in a terminal status. Terminal set is small on purpose —
 *  only what a later phase can actually reach today. */
function enquiry_is_active(array $enquiry): bool
{
    return !in_array($enquiry['status'], ['Completed', 'Cancelled'], true);
}
