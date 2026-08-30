<?php
/**
 * Forex document checklist + FEMA/RBI guideline content.
 *
 * CRITICAL constraint from the spec, repeated here because it's the one
 * rule in this whole project that must never be worked around: no RBI/FEMA
 * limit, fee, or regulatory figure is invented anywhere in this codebase.
 * compliance_guidelines starts with every row's value set to "To be
 * configured by administrator" — an authorized admin fills in real,
 * source-checked figures later (Phase 8 builds that editor); until then the
 * page states plainly that nothing has been confirmed yet, which is more
 * honest than a plausible-looking placeholder number.
 */
declare(strict_types=1);

require_once __DIR__ . '/enquiries.php';

const FEMA_DISCLAIMER = 'Foreign exchange transactions are subject to applicable laws, RBI directions, FEMA provisions and other regulatory requirements. Requirements and limits may change from time to time. The information on this page is for general guidance and does not constitute legal or regulatory advice. Verify the current applicable limits and documentation for your specific transaction before travel.';

/** code => [label, mandatory]. Matches the spec's explicit split — Visa
 *  Copy is conditional, never mandatory, because it doesn't apply to every
 *  destination or every forex transaction. */
const FOREX_CHECKLIST_ITEMS = [
    'flight_reservation' => ['Flight Ticket / Reservation', true],
    'hotel_reservation'  => ['Hotel Reservation', true],
    'pan_card'           => ['PAN Card Copy', true],
    'passport_copy'      => ['Passport Copy', true],
    'visa_copy'          => ['Visa Copy', false],
    'lerms_letter'        => ['LERMS Letter', false],
    'invitation_letter'  => ['Invitation Letter', false],
    'employment_letter'  => ['Employment / Business Documents', false],
    'other'              => ['Other Supporting Documents', false],
];

function compliance_migrate(PDO $pdo): void
{
    $pdo->exec("
        CREATE TABLE IF NOT EXISTS compliance_guidelines (
            id                INTEGER PRIMARY KEY AUTOINCREMENT,
            code              TEXT UNIQUE NOT NULL,
            title             TEXT NOT NULL,
            summary           TEXT NOT NULL,
            source            TEXT NOT NULL DEFAULT '',
            last_reviewed_at  INTEGER,
            effective_at      INTEGER,
            sort_order        INTEGER NOT NULL DEFAULT 0
        )");

    $placeholder = 'To be configured by administrator — verification required before this figure is shown to customers.';
    $seed = $pdo->prepare('INSERT OR IGNORE INTO compliance_guidelines (code, title, summary, source, sort_order) VALUES (?, ?, ?, ?, ?)');
    $order = 0;
    foreach ([
        ['lrs_limit', 'Liberalised Remittance Scheme (LRS) limit', $placeholder],
        ['cash_forex_limit', 'Cash foreign currency you can carry', $placeholder],
        ['forex_card_limit', 'Forex card loading limit', $placeholder],
        ['pan_requirement', 'PAN requirement for forex transactions', $placeholder],
        ['kyc_requirement', 'KYC documents required', $placeholder],
        ['purpose_declaration', 'Purpose-of-travel declaration', $placeholder],
        ['customs_declaration', 'Customs declaration on arrival/departure', $placeholder],
        ['home_delivery_compliance', 'Home delivery verification requirement', $placeholder],
    ] as [$code, $title, $summary]) {
        $seed->execute([$code, $title, $summary, 'Not yet sourced', $order++]);
    }
}

function compliance_db(): ?PDO
{
    static $migrated = false;
    $pdo = enquiry_db();
    if (!$pdo) return null;
    if (!$migrated) {
        compliance_migrate($pdo);
        $migrated = true;
    }
    return $pdo;
}

function compliance_guidelines_all(): array
{
    $pdo = compliance_db();
    if (!$pdo) return [];
    return $pdo->query('SELECT * FROM compliance_guidelines ORDER BY sort_order')->fetchAll();
}

/** Whether a guideline row still holds the unconfigured placeholder. */
function compliance_is_placeholder(array $row): bool
{
    return stripos($row['summary'], 'to be configured') !== false;
}

/**
 * The admin editor (Phase 8, employee-admin-guidelines.php) writing a real,
 * source-checked figure over a placeholder — or editing one that's already
 * real. Nothing here validates or generates the CONTENT beyond requiring it
 * non-empty: the content is exactly the thing no code in this repo is
 * allowed to invent, so this function's only job is to save what an
 * authorized admin actually typed.
 */
function compliance_guideline_update(string $code, string $title, string $summary, string $source, ?int $lastReviewedAt): bool
{
    if ($title === '' || $summary === '') return false;
    $pdo = compliance_db();
    if (!$pdo) return false;
    $pdo->prepare('UPDATE compliance_guidelines SET title = ?, summary = ?, source = ?, last_reviewed_at = ? WHERE code = ?')
        ->execute([$title, $summary, $source, $lastReviewedAt, $code]);
    return true;
}

/**
 * Forex checklist against what's actually been uploaded for this enquiry.
 * @return array<int, array{code:string,label:string,mandatory:bool,uploaded:bool}>
 */
function forex_checklist_status(array $documents): array
{
    $uploadedCodes = [];
    foreach ($documents as $d) {
        $uploadedCodes[$d['document_type_id']] = true;
    }
    require_once __DIR__ . '/documents.php';
    $allTypes = document_types_all();
    $codeById = [];
    foreach ($allTypes as $t) {
        $codeById[$t['id']] = $t['code'];
    }
    $uploadedTypeCodes = [];
    foreach (array_keys($uploadedCodes) as $typeId) {
        if (isset($codeById[$typeId])) $uploadedTypeCodes[$codeById[$typeId]] = true;
    }

    $out = [];
    foreach (FOREX_CHECKLIST_ITEMS as $code => [$label, $mandatory]) {
        $out[] = ['code' => $code, 'label' => $label, 'mandatory' => $mandatory, 'uploaded' => isset($uploadedTypeCodes[$code])];
    }
    return $out;
}

/** The hard gate: every MANDATORY checklist item present. Home delivery
 *  additionally needs each of those actually marked Accepted, but nothing
 *  can accept a document without an employee console (Phase 7), so that
 *  half of the check is a static "not yet possible" today, not a stub that
 *  quietly returns true. */
function forex_ready_for_delivery(array $checklist, array $documents): bool
{
    foreach ($checklist as $item) {
        if ($item['mandatory'] && !$item['uploaded']) return false;
    }
    $byType = [];
    foreach ($documents as $d) $byType[$d['document_type_id']] = $d;
    foreach ($documents as $d) {
        if ($d['status'] !== 'Accepted') return false;
    }
    return (bool) $documents;
}
