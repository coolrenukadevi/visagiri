<?php
/**
 * Customer support tickets: a complaint/query channel that is deliberately
 * separate from an enquiry's customer_notes (one-way, informal) and
 * internal_notes (staff-only) — a ticket is a genuine two-way thread both
 * the customer and an employee post into, with its own status.
 *
 * A ticket MAY reference an enquiry (enquiry_id, nullable) but doesn't have
 * to — "your call center didn't call me back" isn't about any one enquiry.
 * When it does, ownership of the enquiry is still checked by the caller
 * (support.php) before the link is saved; this file trusts its caller the
 * same way enquiries.php does.
 *
 * Status changes get a synthetic message in the same thread (author_type
 * 'system') rather than a separate history table — for a ticket, unlike an
 * enquiry, the thread already IS the complete history of what happened and
 * when; a second table recording the same timeline would just be two
 * sources of truth for one fact.
 */
declare(strict_types=1);

require_once __DIR__ . '/enquiries.php';
require_once __DIR__ . '/notify_channels.php';

const TICKET_CATEGORIES = ['Complaint', 'Query', 'Document Issue', 'Refund Request', 'Service Delay', 'Other'];
const TICKET_STATUSES = ['Open', 'In Progress', 'Resolved', 'Closed'];

function support_migrate(PDO $pdo): void
{
    $pdo->exec("
        CREATE TABLE IF NOT EXISTS support_tickets (
            id                  INTEGER PRIMARY KEY AUTOINCREMENT,
            ticket_code         TEXT UNIQUE NOT NULL,
            customer_id         INTEGER NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
            enquiry_id          INTEGER REFERENCES enquiries(id) ON DELETE SET NULL,
            subject             TEXT NOT NULL,
            category            TEXT NOT NULL DEFAULT 'Query',
            status              TEXT NOT NULL DEFAULT 'Open',
            assigned_employee   TEXT,
            assigned_department TEXT,
            created_at          INTEGER NOT NULL,
            updated_at          INTEGER NOT NULL
        )");
    $pdo->exec('CREATE INDEX IF NOT EXISTS idx_tickets_customer ON support_tickets(customer_id)');
    $pdo->exec('CREATE INDEX IF NOT EXISTS idx_tickets_assigned ON support_tickets(assigned_employee)');
    $pdo->exec("
        CREATE TABLE IF NOT EXISTS ticket_messages (
            id            INTEGER PRIMARY KEY AUTOINCREMENT,
            ticket_id     INTEGER NOT NULL REFERENCES support_tickets(id) ON DELETE CASCADE,
            author_type   TEXT NOT NULL,
            author_name   TEXT NOT NULL,
            message       TEXT NOT NULL,
            created_at    INTEGER NOT NULL
        )");
    $pdo->exec('CREATE INDEX IF NOT EXISTS idx_ticket_messages_ticket ON ticket_messages(ticket_id)');
}

function support_db(): ?PDO
{
    static $migrated = false;
    $pdo = enquiry_db();
    if (!$pdo) return null;
    if (!$migrated) {
        support_migrate($pdo);
        $migrated = true;
    }
    return $pdo;
}

function ticket_code_for(int $id, int $year): string
{
    return 'TK-' . $year . '-' . str_pad((string) $id, 6, '0', STR_PAD_LEFT);
}

/**
 * @param array $p Validated {subject, category, enquiry_id (?int), message}
 *                 — see support.php for the checks run before this is
 *                 called, including that enquiry_id (if any) belongs to
 *                 this customer.
 * @return array{0:?int,1:string,2:?string} [ticket id, error, code]
 */
function ticket_create(int $customerId, string $customerName, array $p): array
{
    $pdo = support_db();
    if (!$pdo) return [null, 'Support tickets are temporarily unavailable. Please try again shortly.', null];

    try {
        $pdo->beginTransaction();
        $now = time();
        $pdo->prepare('
            INSERT INTO support_tickets (ticket_code, customer_id, enquiry_id, subject, category, status, created_at, updated_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)')
            ->execute(['PENDING', $customerId, $p['enquiry_id'] ?: null, $p['subject'], $p['category'], 'Open', $now, $now]);
        $id = (int) $pdo->lastInsertId();
        $code = ticket_code_for($id, (int) date('Y', $now));
        $pdo->prepare('UPDATE support_tickets SET ticket_code = ? WHERE id = ?')->execute([$code, $id]);

        $pdo->prepare('INSERT INTO ticket_messages (ticket_id, author_type, author_name, message, created_at) VALUES (?, ?, ?, ?, ?)')
            ->execute([$id, 'customer', $customerName, $p['message'], $now]);

        $pdo->commit();
        return [$id, '', $code];
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        log_error('support: ticket_create failed — ' . $e->getMessage());
        return [null, 'Something went wrong submitting your ticket. Please try again.', null];
    }
}

function tickets_for_customer(int $customerId): array
{
    $pdo = support_db();
    if (!$pdo) return [];
    $st = $pdo->prepare('SELECT * FROM support_tickets WHERE customer_id = ? ORDER BY created_at DESC');
    $st->execute([$customerId]);
    return $st->fetchAll();
}

function ticket_find_by_code(string $code): ?array
{
    $pdo = support_db();
    if (!$pdo) return null;
    $st = $pdo->prepare('SELECT * FROM support_tickets WHERE ticket_code = ?');
    $st->execute([$code]);
    return $st->fetch() ?: null;
}

function ticket_find_by_id(int $id): ?array
{
    $pdo = support_db();
    if (!$pdo) return null;
    $st = $pdo->prepare('SELECT * FROM support_tickets WHERE id = ?');
    $st->execute([$id]);
    return $st->fetch() ?: null;
}

function ticket_messages_for(int $ticketId): array
{
    $pdo = support_db();
    if (!$pdo) return [];
    $st = $pdo->prepare('SELECT * FROM ticket_messages WHERE ticket_id = ? ORDER BY created_at, id');
    $st->execute([$ticketId]);
    return $st->fetchAll();
}

/**
 * A customer message on an already Resolved/Closed ticket reopens it — a
 * ticket that keeps receiving replies while its own status insists nothing
 * is happening would be misrepresenting its own state, which this project
 * doesn't do anywhere else either.
 */
function ticket_message_add(int $ticketId, string $authorType, string $authorName, string $message): bool
{
    $message = trim($message);
    if ($message === '' || !in_array($authorType, ['customer', 'employee', 'system'], true)) return false;
    $pdo = support_db();
    if (!$pdo) return false;
    $now = time();
    $pdo->prepare('INSERT INTO ticket_messages (ticket_id, author_type, author_name, message, created_at) VALUES (?, ?, ?, ?, ?)')
        ->execute([$ticketId, $authorType, $authorName, $message, $now]);
    $pdo->prepare('UPDATE support_tickets SET updated_at = ? WHERE id = ?')->execute([$now, $ticketId]);

    $ticket = ticket_find_by_id($ticketId);
    if ($ticket && $authorType === 'customer' && in_array($ticket['status'], ['Resolved', 'Closed'], true)) {
        ticket_set_status($ticketId, 'Open', $authorName, true);
    }

    // Notify whoever didn't just write this message — never the author.
    if ($ticket && $authorType === 'employee') {
        notify_customer((int) $ticket['customer_id'], 'ticket_reply',
            'New reply on ' . $ticket['ticket_code'],
            $authorName . ' replied on your ticket "' . $ticket['subject'] . '".',
            '/support/' . $ticket['ticket_code']);
    } elseif ($ticket && $authorType === 'customer' && $ticket['assigned_employee']) {
        notify_employee_by_name($ticket['assigned_employee'], 'ticket_reply',
            'New message on ' . $ticket['ticket_code'],
            $authorName . ' posted on ticket "' . $ticket['subject'] . '".',
            '/employee/ticket/' . $ticket['ticket_code']);
    }
    return true;
}

/** @param bool $silent Skip the "by {actor}" system message — used when
 *  ticket_message_add() reopens a ticket right after the customer's own
 *  message already landed in the thread; a second system line saying the
 *  same thing a line above would be noise, not information. */
function ticket_set_status(int $ticketId, string $status, string $actorName, bool $silent = false): bool
{
    if (!in_array($status, TICKET_STATUSES, true)) return false;
    $pdo = support_db();
    if (!$pdo) return false;
    $now = time();
    $pdo->prepare('UPDATE support_tickets SET status = ?, updated_at = ? WHERE id = ?')->execute([$status, $now, $ticketId]);
    if (!$silent) {
        $pdo->prepare('INSERT INTO ticket_messages (ticket_id, author_type, author_name, message, created_at) VALUES (?, ?, ?, ?, ?)')
            ->execute([$ticketId, 'system', $actorName, "Status changed to {$status} by {$actorName}.", $now]);

        // $silent is only ever true for the customer's own reopen-on-reply
        // (see ticket_message_add()) — notifying them about their own
        // action isn't useful, so this stays inside the !$silent branch.
        $ticket = ticket_find_by_id($ticketId);
        if ($ticket) {
            notify_customer((int) $ticket['customer_id'], 'ticket_status',
                'Ticket ' . $ticket['ticket_code'] . ': ' . $status,
                'Your ticket "' . $ticket['subject'] . '" is now ' . $status . '.',
                '/support/' . $ticket['ticket_code']);
        }
    }
    return true;
}

function ticket_assign(int $ticketId, string $employeeName, string $department = ''): void
{
    $pdo = support_db();
    if (!$pdo) return;
    $pdo->prepare('UPDATE support_tickets SET assigned_employee = ?, assigned_department = ?, updated_at = ? WHERE id = ?')
        ->execute([$employeeName, $department ?: null, time(), $ticketId]);

    $ticket = ticket_find_by_id($ticketId);
    if ($ticket) {
        notify_employee_by_name($employeeName, 'ticket_assigned',
            'Ticket assigned: ' . $ticket['ticket_code'],
            'You were assigned "' . $ticket['subject'] . '" (' . $ticket['ticket_code'] . ').',
            '/employee/ticket/' . $ticket['ticket_code']);
    }
}

function ticket_unassign(int $ticketId): void
{
    $pdo = support_db();
    if (!$pdo) return;
    $pdo->prepare('UPDATE support_tickets SET assigned_employee = NULL, assigned_department = NULL, updated_at = ? WHERE id = ?')
        ->execute([time(), $ticketId]);
}

/** Open tickets nobody has claimed yet — same bounded-not-paginated
 *  reasoning as enquiries_unassigned(). */
function tickets_unassigned(int $limit = 50): array
{
    $pdo = support_db();
    if (!$pdo) return [];
    $st = $pdo->prepare("
        SELECT t.*, c.full_name AS customer_name, c.customer_code
        FROM support_tickets t JOIN customers c ON c.id = t.customer_id
        WHERE t.assigned_employee IS NULL AND t.status NOT IN ('Resolved', 'Closed')
        ORDER BY t.created_at DESC LIMIT ?");
    $st->execute([$limit]);
    return $st->fetchAll();
}

function tickets_assigned_to(string $employeeName, int $limit = 50): array
{
    $pdo = support_db();
    if (!$pdo || $employeeName === '') return [];
    $st = $pdo->prepare("
        SELECT t.*, c.full_name AS customer_name, c.customer_code
        FROM support_tickets t JOIN customers c ON c.id = t.customer_id
        WHERE t.assigned_employee = ?
        ORDER BY t.created_at DESC LIMIT ?");
    $st->execute([$employeeName, $limit]);
    return $st->fetchAll();
}

function ticket_is_active(array $ticket): bool
{
    return !in_array($ticket['status'], ['Resolved', 'Closed'], true);
}

// ---------------------------------------------------------------------
// Reports (Phase 10) — uncapped, same reasoning as enquiries_all().
// ---------------------------------------------------------------------

function tickets_all(): array
{
    $pdo = support_db();
    if (!$pdo) return [];
    return $pdo->query("
        SELECT t.*, c.full_name AS customer_name, c.customer_code
        FROM support_tickets t JOIN customers c ON c.id = t.customer_id
        ORDER BY t.created_at DESC")->fetchAll();
}

function tickets_count_by_status(): array
{
    $pdo = support_db();
    if (!$pdo) return [];
    $rows = $pdo->query('SELECT status, COUNT(*) AS n FROM support_tickets GROUP BY status')->fetchAll();
    $out = [];
    foreach ($rows as $r) $out[$r['status']] = (int) $r['n'];
    return $out;
}

function tickets_count_by_category(): array
{
    $pdo = support_db();
    if (!$pdo) return [];
    $rows = $pdo->query('SELECT category, COUNT(*) AS n FROM support_tickets GROUP BY category ORDER BY n DESC')->fetchAll();
    $out = [];
    foreach ($rows as $r) $out[$r['category']] = (int) $r['n'];
    return $out;
}
