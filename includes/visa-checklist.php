<?php
declare(strict_types=1);

/**
 * Visa Checklist Engine data layer — one reusable system driving every
 * /visa/{country}/{type}/ page's checklist, not a per-country
 * implementation. A checklist is looked up strictly by
 * (country_id, visa_type_id); nothing here ever falls back to another
 * country's or type's data, matching the "never share checklists
 * blindly" requirement. See database/schema-visa-checklist.sql and
 * AUDIT.md's "Visa Checklist Engine" entry for the full design.
 */

const CHECKLIST_ACCESS_TTL_DAYS = 180;

const CHECKLIST_DEFAULT_DISCLAIMER = 'Visa requirements may change. The competent Embassy/Consulate may request additional documents based on individual circumstances. This checklist is provided for document-preparation guidance only and does not guarantee visa approval.';

/**
 * A published checklist for this country+visa-type, with its sections
 * and documents nested, or null if none has been published yet — the
 * page renders its existing generic checklist-free layout in that
 * case, never a fabricated one.
 */
function fetch_visa_checklist(int $countryId, int $visaTypeId): ?array
{
    $stmt = db()->prepare(
        "SELECT * FROM visa_checklists
         WHERE country_id = :country_id AND visa_type_id = :visa_type_id AND status = 'published'
         LIMIT 1"
    );
    $stmt->execute(['country_id' => $countryId, 'visa_type_id' => $visaTypeId]);
    $checklist = $stmt->fetch();
    if (!$checklist) {
        return null;
    }

    $sectionsStmt = db()->prepare(
        'SELECT * FROM visa_checklist_sections WHERE checklist_id = :id ORDER BY display_order, id'
    );
    $sectionsStmt->execute(['id' => $checklist['id']]);
    $sections = $sectionsStmt->fetchAll();

    if ($sections) {
        $sectionIds = array_column($sections, 'id');
        $placeholders = implode(',', array_fill(0, count($sectionIds), '?'));
        $docsStmt = db()->prepare(
            "SELECT * FROM visa_checklist_documents WHERE section_id IN ($placeholders) ORDER BY display_order, id"
        );
        $docsStmt->execute($sectionIds);
        $docsBySection = [];
        foreach ($docsStmt->fetchAll() as $doc) {
            $docsBySection[(int) $doc['section_id']][] = $doc;
        }
        foreach ($sections as &$section) {
            $section['documents'] = $docsBySection[(int) $section['id']] ?? [];
        }
        unset($section);
    }

    $checklist['sections'] = $sections;
    return $checklist;
}

/** Manually admin-controlled visa fee for a country+visa-type, or null if not set. */
function fetch_visa_fee(int $countryId, int $visaTypeId): ?array
{
    $stmt = db()->prepare('SELECT * FROM visa_fees WHERE country_id = :country_id AND visa_type_id = :visa_type_id LIMIT 1');
    $stmt->execute(['country_id' => $countryId, 'visa_type_id' => $visaTypeId]);
    $row = $stmt->fetch();
    return $row ?: null;
}

/**
 * Updates (or creates) a country+visa-type's fee, logging the change
 * to visa_fee_history first when a fee already exists — the record an
 * admin panel would call; not yet wired to any UI this pass (fees are
 * seeded directly via SQL for now), but the function itself is the
 * real, safe way to change a fee, so building that UI later is wiring
 * a form to this, not new logic.
 */
function set_visa_fee(int $countryId, int $visaTypeId, ?float $amount, string $currency, ?string $label, ?string $note, ?string $effectiveDate, ?string $sourceUrl, ?string $updatedBy, ?string $reason = null): void
{
    $existing = fetch_visa_fee($countryId, $visaTypeId);

    if ($existing !== null && (float) $existing['amount'] !== (float) $amount) {
        db()->prepare(
            'INSERT INTO visa_fee_history (country_id, visa_type_id, old_amount, new_amount, currency, updated_by, reason)
             VALUES (:country_id, :visa_type_id, :old_amount, :new_amount, :currency, :updated_by, :reason)'
        )->execute([
            'country_id' => $countryId,
            'visa_type_id' => $visaTypeId,
            'old_amount' => $existing['amount'],
            'new_amount' => $amount,
            'currency' => $currency,
            'updated_by' => $updatedBy,
            'reason' => $reason,
        ]);
    }

    db()->prepare(
        'INSERT INTO visa_fees (country_id, visa_type_id, amount, currency, label, note, effective_date, last_updated, source_url, updated_by)
         VALUES (:country_id, :visa_type_id, :amount, :currency, :label, :note, :effective_date, NOW(), :source_url, :updated_by)
         ON DUPLICATE KEY UPDATE
             amount = VALUES(amount), currency = VALUES(currency), label = VALUES(label), note = VALUES(note),
             effective_date = VALUES(effective_date), last_updated = NOW(), source_url = VALUES(source_url), updated_by = VALUES(updated_by)'
    )->execute([
        'country_id' => $countryId,
        'visa_type_id' => $visaTypeId,
        'amount' => $amount,
        'currency' => $currency,
        'label' => $label,
        'note' => $note,
        'effective_date' => $effectiveDate,
        'source_url' => $sourceUrl,
        'updated_by' => $updatedBy,
    ]);
}

/**
 * Creates a new checklist-access authorization after a successful
 * enquiry and returns the raw token — the ONLY time the raw value
 * exists; only its SHA-256 hash is stored, so a database leak alone
 * can't be used to forge access (same discipline as the tracking-token
 * pattern already used for enquiry PDFs).
 */
function generate_checklist_access_token(int $checklistId, int $countryId, int $visaTypeId, ?int $enquiryId): string
{
    $token = bin2hex(random_bytes(32));
    $expiresAt = date('Y-m-d H:i:s', strtotime('+' . CHECKLIST_ACCESS_TTL_DAYS . ' days'));

    db()->prepare(
        "INSERT INTO checklist_access_tokens (token_hash, enquiry_id, checklist_id, country_id, visa_type_id, status, expires_at)
         VALUES (:hash, :enquiry_id, :checklist_id, :country_id, :visa_type_id, 'active', :expires_at)"
    )->execute([
        'hash' => hash('sha256', $token),
        'enquiry_id' => $enquiryId,
        'checklist_id' => $checklistId,
        'country_id' => $countryId,
        'visa_type_id' => $visaTypeId,
        'expires_at' => $expiresAt,
    ]);

    return $token;
}

/**
 * Verifies a checklist-access token against a specific country+type —
 * a token issued for Mexico Tourist never unlocks Singapore Business,
 * even if somehow replayed. Timing-safe comparison happens implicitly
 * via the hash lookup (an attacker can't binary-search a SHA-256
 * column the way they could a raw string compare).
 */
function verify_checklist_access_token(string $token, int $countryId, int $visaTypeId): bool
{
    if ($token === '') {
        return false;
    }
    $stmt = db()->prepare(
        "SELECT 1 FROM checklist_access_tokens
         WHERE token_hash = :hash AND country_id = :country_id AND visa_type_id = :visa_type_id
           AND status = 'active' AND expires_at > NOW()
         LIMIT 1"
    );
    $stmt->execute([
        'hash' => hash('sha256', $token),
        'country_id' => $countryId,
        'visa_type_id' => $visaTypeId,
    ]);
    return (bool) $stmt->fetchColumn();
}

/** Cookie name for a given country+visa-type's checklist access — one cookie per pair, never a single sitewide "unlocked" flag. */
function checklist_access_cookie_name(int $countryId, int $visaTypeId): string
{
    return "vg_checklist_{$countryId}_{$visaTypeId}";
}

/**
 * Whether the current request already carries valid checklist access
 * for this country+type, via the httpOnly cookie set at unlock time.
 * Never reads localStorage/sessionStorage — there is nothing for
 * client-side JS to read here at all.
 */
function has_checklist_access(int $countryId, int $visaTypeId): bool
{
    $cookieName = checklist_access_cookie_name($countryId, $visaTypeId);
    $token = $_COOKIE[$cookieName] ?? '';
    return $token !== '' && verify_checklist_access_token($token, $countryId, $visaTypeId);
}

/**
 * Splits a checklist's sections into what's shown before an enquiry
 * (fully rendered, only truly public documents) vs. what's locked
 * (section titles only, never their documents) — server-side, so a
 * locked document's name/description never reaches the client's HTML
 * at all when access hasn't been granted.
 *
 * @return array{public: list<array>, lockedTitles: list<string>}
 */
function split_checklist_for_visibility(array $checklist, bool $hasAccess): array
{
    if ($hasAccess) {
        return ['public' => $checklist['sections'], 'lockedTitles' => []];
    }

    $publicSections = [];
    $lockedTitles = [];
    foreach ($checklist['sections'] as $section) {
        $allDocs = $section['documents'];
        $publicDocs = array_values(array_filter($allDocs, static fn(array $d): bool => (bool) $d['is_public']));

        if ($publicDocs) {
            $section['documents'] = $publicDocs;
            $publicSections[] = $section;
        }

        // A section belongs in the locked teaser whenever it has ANY
        // non-public document, even if it also contributed some
        // public ones (e.g. "Application & Photograph" showing half
        // its items) — its full content still isn't visible yet.
        if (count($publicDocs) < count($allDocs)) {
            $lockedTitles[] = $section['title'];
        }
    }

    return ['public' => $publicSections, 'lockedTitles' => $lockedTitles];
}
