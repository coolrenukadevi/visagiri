<?php
/**
 * Visa-specific detail attached to an enquiry whose service is Visa Services
 * — a 1:1 extension of `enquiries`, not a replacement (see enquiries.php's
 * docblock: the enquiry engine stays the single source of the customer_id/
 * status/code, this table only adds the fields the spec's visa form asks
 * for that a Forex or Travel Insurance enquiry has no use for).
 *
 * Captured on the enquiry detail page as a follow-up step after the quick
 * "Enquire Now" submission, not crammed into that same dialog — the spec
 * itself warns against overloading the first screen with 30+ fields, and
 * this form alone has eleven.
 */
declare(strict_types=1);

require_once __DIR__ . '/enquiries.php';

function visa_enquiry_migrate(PDO $pdo): void
{
    $pdo->exec("
        CREATE TABLE IF NOT EXISTS visa_enquiries (
            id                     INTEGER PRIMARY KEY AUTOINCREMENT,
            enquiry_id             INTEGER NOT NULL UNIQUE REFERENCES enquiries(id) ON DELETE CASCADE,
            applicant_name         TEXT NOT NULL,
            passport_number        TEXT NOT NULL,
            country_of_residence   TEXT NOT NULL,
            destination_city       TEXT NOT NULL DEFAULT '',
            visa_type              TEXT NOT NULL,
            expected_return_date   TEXT,
            traveller_count        INTEGER NOT NULL DEFAULT 1,
            applicant_type         TEXT NOT NULL DEFAULT 'Single',
            previous_refusal       INTEGER NOT NULL DEFAULT 0,
            current_visa_status    TEXT NOT NULL DEFAULT '',
            previous_visa_history  TEXT NOT NULL DEFAULT '',
            created_at             INTEGER NOT NULL,
            updated_at             INTEGER NOT NULL
        )");
}

function visa_enquiry_db(): ?PDO
{
    static $migrated = false;
    $pdo = enquiry_db();
    if (!$pdo) return null;
    if (!$migrated) {
        visa_enquiry_migrate($pdo);
        $migrated = true;
    }
    return $pdo;
}

function visa_enquiry_for(int $enquiryId): ?array
{
    $pdo = visa_enquiry_db();
    if (!$pdo) return null;
    $st = $pdo->prepare('SELECT * FROM visa_enquiries WHERE enquiry_id = ?');
    $st->execute([$enquiryId]);
    return $st->fetch() ?: null;
}

/**
 * Insert-or-update — a customer revisiting the form after submitting once
 * edits the same row rather than creating a second one.
 *
 * @param array $p Validated {applicant_name, passport_number,
 *                 country_of_residence, destination_city, visa_type,
 *                 expected_return_date, traveller_count, applicant_type,
 *                 previous_refusal, current_visa_status, previous_visa_history}
 */
function visa_enquiry_save(int $enquiryId, array $p): bool
{
    $pdo = visa_enquiry_db();
    if (!$pdo) return false;
    $now = time();
    $existing = visa_enquiry_for($enquiryId);
    try {
        if ($existing) {
            $pdo->prepare('
                UPDATE visa_enquiries SET
                    applicant_name = ?, passport_number = ?, country_of_residence = ?, destination_city = ?,
                    visa_type = ?, expected_return_date = ?, traveller_count = ?, applicant_type = ?,
                    previous_refusal = ?, current_visa_status = ?, previous_visa_history = ?, updated_at = ?
                WHERE enquiry_id = ?')
                ->execute([
                    $p['applicant_name'], $p['passport_number'], $p['country_of_residence'], $p['destination_city'],
                    $p['visa_type'], $p['expected_return_date'] ?: null, $p['traveller_count'], $p['applicant_type'],
                    $p['previous_refusal'] ? 1 : 0, $p['current_visa_status'], $p['previous_visa_history'], $now,
                    $enquiryId,
                ]);
        } else {
            $pdo->prepare('
                INSERT INTO visa_enquiries
                    (enquiry_id, applicant_name, passport_number, country_of_residence, destination_city, visa_type,
                     expected_return_date, traveller_count, applicant_type, previous_refusal, current_visa_status,
                     previous_visa_history, created_at, updated_at)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)')
                ->execute([
                    $enquiryId, $p['applicant_name'], $p['passport_number'], $p['country_of_residence'], $p['destination_city'],
                    $p['visa_type'], $p['expected_return_date'] ?: null, $p['traveller_count'], $p['applicant_type'],
                    $p['previous_refusal'] ? 1 : 0, $p['current_visa_status'], $p['previous_visa_history'], $now, $now,
                ]);
        }
        return true;
    } catch (Throwable $e) {
        log_error('visa_enquiries: save failed — ' . $e->getMessage());
        return false;
    }
}

/**
 * Visa type labels this destination country actually offers, reusing the
 * SAME per-country data the public visa guides already show — not a
 * separate, hand-maintained list that could drift from what's on
 * /visa/{country}. Falls back to the generic set if the country has no
 * page-level data yet (mirrors data.php's own generic-content fallback).
 */
function visa_types_for_country(string $countryName): array
{
    require_once __DIR__ . '/data.php';
    require_once __DIR__ . '/../includes/nav.php';
    $country = country_by_slug(cv_slug($countryName));
    $types = array_column($country['visaTypes'] ?? [], 'visaType');
    return $types ?: ['Tourist Visa'];
}
