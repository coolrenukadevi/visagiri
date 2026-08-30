<?php
/**
 * The central CRM enquiry engine: one record per visa/forex/etc. enquiry,
 * always tied to a customer (see customer_auth.php), always carrying a
 * human-readable code (CV-2026-000001) generated the same way
 * customer_code_for() works.
 *
 * Assignment is keyed by the employee's name, not an id: `assigned_employee`
 * is the same nullable TEXT column the customer-facing pages have rendered
 * since Phase 4 ("Assigned Consultant: <name>"), and Phase 7 (the employee
 * console — lib-php/employee_auth.php) now writes to it rather than adding a
 * parallel id column. For a small internal ops team this is a deliberate
 * trade — simple, and matches what was already pre-built and shipped for
 * display — not a scalability position; a large team would want a real FK
 * plus the role-based access Phase 8 (Admin & compliance configuration) is
 * scoped to add.
 *
 * internal_notes is new in Phase 7 for the same reason it was withheld
 * before: the docblock here used to say it stays out until a real consumer
 * exists to read or write it. The employee console is that consumer.
 * Employee identity is denormalized onto each note (employee_name) rather
 * than a foreign key, so this file still has no dependency on
 * employee_auth.php — the caller (employee-enquiry.php) passes the name in,
 * the same way it already does for `assigned_employee`.
 *
 * A communication/message thread with the customer is still NOT here —
 * nothing reads or writes one yet (that's Phase 9, customer redressal/support).
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
    $pdo->exec("
        CREATE TABLE IF NOT EXISTS internal_notes (
            id             INTEGER PRIMARY KEY AUTOINCREMENT,
            enquiry_id     INTEGER NOT NULL REFERENCES enquiries(id) ON DELETE CASCADE,
            employee_name  TEXT NOT NULL,
            note           TEXT NOT NULL,
            created_at     INTEGER NOT NULL
        )");
    $pdo->exec('CREATE INDEX IF NOT EXISTS idx_internal_notes_enquiry ON internal_notes(enquiry_id)');

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
        SELECT e.*, s.label AS service_label, s.code AS service_code
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
        SELECT e.*, s.label AS service_label, s.code AS service_code
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

const ENQUIRY_STATUSES = ['New', 'In Progress', 'Completed', 'Cancelled'];

// ---------------------------------------------------------------------
// Employee console (Phase 7) — queue, assignment, status, internal notes
// ---------------------------------------------------------------------

/** Open enquiries nobody has claimed yet, newest first. Bounded rather than
 *  paginated — a real pager belongs with the reporting work in Phase 10, not
 *  bolted on here for a queue that's meant to be worked down, not browsed. */
function enquiries_unassigned(int $limit = 50): array
{
    $pdo = enquiry_db();
    if (!$pdo) return [];
    $st = $pdo->prepare("
        SELECT e.*, s.label AS service_label, s.code AS service_code, c.full_name AS customer_name, c.customer_code
        FROM enquiries e JOIN service_types s ON s.id = e.service_type_id
        JOIN customers c ON c.id = e.customer_id
        WHERE e.assigned_employee IS NULL AND e.status NOT IN ('Completed', 'Cancelled')
        ORDER BY e.created_at DESC LIMIT ?");
    $st->execute([$limit]);
    return $st->fetchAll();
}

/** Every enquiry currently assigned to one employee (by name — see the
 *  docblock above), newest first. */
function enquiries_assigned_to(string $employeeName, int $limit = 50): array
{
    $pdo = enquiry_db();
    if (!$pdo || $employeeName === '') return [];
    $st = $pdo->prepare("
        SELECT e.*, s.label AS service_label, s.code AS service_code, c.full_name AS customer_name, c.customer_code
        FROM enquiries e JOIN service_types s ON s.id = e.service_type_id
        JOIN customers c ON c.id = e.customer_id
        WHERE e.assigned_employee = ?
        ORDER BY e.created_at DESC LIMIT ?");
    $st->execute([$employeeName, $limit]);
    return $st->fetchAll();
}

function enquiry_assign(int $enquiryId, string $employeeName, string $department = ''): void
{
    $pdo = enquiry_db();
    if (!$pdo) return;
    $pdo->prepare('UPDATE enquiries SET assigned_employee = ?, assigned_department = ?, updated_at = ? WHERE id = ?')
        ->execute([$employeeName, $department ?: null, time(), $enquiryId]);
}

function enquiry_unassign(int $enquiryId): void
{
    $pdo = enquiry_db();
    if (!$pdo) return;
    $pdo->prepare('UPDATE enquiries SET assigned_employee = NULL, assigned_department = NULL, updated_at = ? WHERE id = ?')
        ->execute([time(), $enquiryId]);
}

/** Sets the enquiry's status and appends a row to the same history table the
 *  customer's Status timeline already reads — an employee action shows up
 *  there with no template change needed on that page. */
function enquiry_set_status(int $enquiryId, string $status, string $actorName, string $note = ''): bool
{
    if (!in_array($status, ENQUIRY_STATUSES, true)) return false;
    $pdo = enquiry_db();
    if (!$pdo) return false;
    $now = time();
    $historyNote = "Status set to {$status} by {$actorName}." . ($note !== '' ? ' ' . $note : '');
    try {
        $pdo->beginTransaction();
        $pdo->prepare('UPDATE enquiries SET status = ?, updated_at = ? WHERE id = ?')->execute([$status, $now, $enquiryId]);
        $pdo->prepare('INSERT INTO enquiry_status_history (enquiry_id, status, note, created_at) VALUES (?, ?, ?, ?)')
            ->execute([$enquiryId, $status, $historyNote, $now]);
        $pdo->commit();
        return true;
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        log_error('enquiries: set_status failed — ' . $e->getMessage());
        return false;
    }
}

function internal_note_add(int $enquiryId, string $employeeName, string $note): bool
{
    $note = trim($note);
    if ($note === '') return false;
    $pdo = enquiry_db();
    if (!$pdo) return false;
    $pdo->prepare('INSERT INTO internal_notes (enquiry_id, employee_name, note, created_at) VALUES (?, ?, ?, ?)')
        ->execute([$enquiryId, $employeeName, $note, time()]);
    return true;
}

function internal_notes_for(int $enquiryId): array
{
    $pdo = enquiry_db();
    if (!$pdo) return [];
    $st = $pdo->prepare('SELECT * FROM internal_notes WHERE enquiry_id = ? ORDER BY created_at DESC, id DESC');
    $st->execute([$enquiryId]);
    return $st->fetchAll();
}
