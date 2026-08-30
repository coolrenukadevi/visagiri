<?php
/**
 * Forex-specific detail attached to an enquiry whose service is Forex
 * Services — a 1:1 extension of `enquiries`, same pattern as
 * visa_enquiries.php and for the same reason: a genuinely different
 * workflow, not a copy of the visa form with relabelled fields.
 */
declare(strict_types=1);

require_once __DIR__ . '/enquiries.php';

const FOREX_CURRENCIES = [
    'USD' => 'US Dollar', 'EUR' => 'Euro', 'GBP' => 'British Pound', 'AED' => 'UAE Dirham',
    'SGD' => 'Singapore Dollar', 'AUD' => 'Australian Dollar', 'CAD' => 'Canadian Dollar',
    'JPY' => 'Japanese Yen', 'CHF' => 'Swiss Franc', 'THB' => 'Thai Baht', 'MYR' => 'Malaysian Ringgit',
    'NZD' => 'New Zealand Dollar', 'SAR' => 'Saudi Riyal', 'HKD' => 'Hong Kong Dollar', 'ZAR' => 'South African Rand',
];
const FOREX_TYPES = ['Cash Forex', 'Forex Card', 'Currency Notes', 'Combination', 'Other'];
const FOREX_DELIVERY_METHODS = ['Branch Pickup', 'Home Delivery'];

function forex_enquiry_migrate(PDO $pdo): void
{
    $pdo->exec("
        CREATE TABLE IF NOT EXISTS forex_enquiries (
            id                    INTEGER PRIMARY KEY AUTOINCREMENT,
            enquiry_id            INTEGER NOT NULL UNIQUE REFERENCES enquiries(id) ON DELETE CASCADE,
            pan_number            TEXT NOT NULL DEFAULT '',
            passport_number       TEXT NOT NULL DEFAULT '',
            nationality           TEXT NOT NULL DEFAULT '',
            residential_address   TEXT NOT NULL DEFAULT '',
            city_of_visit         TEXT NOT NULL DEFAULT '',
            travel_start_date     TEXT,
            travel_end_date       TEXT,
            traveller_count       INTEGER NOT NULL DEFAULT 1,
            departure_city        TEXT NOT NULL DEFAULT '',
            forex_type            TEXT NOT NULL DEFAULT '',
            currency_code         TEXT NOT NULL DEFAULT '',
            amount_required       REAL NOT NULL DEFAULT 0,
            approx_inr_value      REAL NOT NULL DEFAULT 0,
            delivery_method       TEXT NOT NULL DEFAULT 'Branch Pickup',
            created_at            INTEGER NOT NULL,
            updated_at            INTEGER NOT NULL
        )");
    $pdo->exec("
        CREATE TABLE IF NOT EXISTS forex_transactions (
            id            INTEGER PRIMARY KEY AUTOINCREMENT,
            enquiry_id    INTEGER NOT NULL UNIQUE REFERENCES enquiries(id) ON DELETE CASCADE,
            stage         TEXT NOT NULL DEFAULT 'Forex Enquiry',
            created_at    INTEGER NOT NULL,
            updated_at    INTEGER NOT NULL
        )");
}

function forex_enquiry_db(): ?PDO
{
    static $migrated = false;
    $pdo = enquiry_db();
    if (!$pdo) return null;
    if (!$migrated) {
        forex_enquiry_migrate($pdo);
        $migrated = true;
    }
    return $pdo;
}

function forex_enquiry_for(int $enquiryId): ?array
{
    $pdo = forex_enquiry_db();
    if (!$pdo) return null;
    $st = $pdo->prepare('SELECT * FROM forex_enquiries WHERE enquiry_id = ?');
    $st->execute([$enquiryId]);
    return $st->fetch() ?: null;
}

/** The 11-stage pipeline from the spec. Only the first stage is ever
 *  reachable today — everything after it needs an employee console
 *  (Phase 7) to move the transaction forward, so the tracker below shows
 *  the rest as genuinely pending rather than fabricating progress. */
const FOREX_PIPELINE_STAGES = [
    'Forex Enquiry', 'Documents Submitted', 'Document Verification', 'Compliance Review',
    'Quotation / Rate', 'Customer Confirmation', 'Payment', 'Forex Processing',
    'Ready for Delivery', 'Home Delivery', 'Delivered',
];

function forex_transaction_for(int $enquiryId): ?array
{
    $pdo = forex_enquiry_db();
    if (!$pdo) return null;
    $st = $pdo->prepare('SELECT * FROM forex_transactions WHERE enquiry_id = ?');
    $st->execute([$enquiryId]);
    return $st->fetch() ?: null;
}

function forex_transaction_ensure(int $enquiryId): array
{
    $existing = forex_transaction_for($enquiryId);
    if ($existing) return $existing;
    $pdo = forex_enquiry_db();
    $now = time();
    $pdo->prepare('INSERT INTO forex_transactions (enquiry_id, stage, created_at, updated_at) VALUES (?, ?, ?, ?)')
        ->execute([$enquiryId, 'Forex Enquiry', $now, $now]);
    return forex_transaction_for($enquiryId);
}

/**
 * @param array $p Validated forex_enquiries fields — see enquiry.php for
 *                 the checks run before this is ever called.
 */
function forex_enquiry_save(int $enquiryId, array $p): bool
{
    $pdo = forex_enquiry_db();
    if (!$pdo) return false;
    $now = time();
    $existing = forex_enquiry_for($enquiryId);
    try {
        if ($existing) {
            $pdo->prepare('
                UPDATE forex_enquiries SET
                    pan_number = ?, passport_number = ?, nationality = ?, residential_address = ?,
                    city_of_visit = ?, travel_start_date = ?, travel_end_date = ?, traveller_count = ?,
                    departure_city = ?, forex_type = ?, currency_code = ?, amount_required = ?,
                    approx_inr_value = ?, delivery_method = ?, updated_at = ?
                WHERE enquiry_id = ?')
                ->execute([
                    $p['pan_number'], $p['passport_number'], $p['nationality'], $p['residential_address'],
                    $p['city_of_visit'], $p['travel_start_date'] ?: null, $p['travel_end_date'] ?: null, $p['traveller_count'],
                    $p['departure_city'], $p['forex_type'], $p['currency_code'], $p['amount_required'],
                    $p['approx_inr_value'], $p['delivery_method'], $now, $enquiryId,
                ]);
        } else {
            $pdo->prepare('
                INSERT INTO forex_enquiries
                    (enquiry_id, pan_number, passport_number, nationality, residential_address, city_of_visit,
                     travel_start_date, travel_end_date, traveller_count, departure_city, forex_type, currency_code,
                     amount_required, approx_inr_value, delivery_method, created_at, updated_at)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)')
                ->execute([
                    $enquiryId, $p['pan_number'], $p['passport_number'], $p['nationality'], $p['residential_address'],
                    $p['city_of_visit'], $p['travel_start_date'] ?: null, $p['travel_end_date'] ?: null, $p['traveller_count'],
                    $p['departure_city'], $p['forex_type'], $p['currency_code'], $p['amount_required'],
                    $p['approx_inr_value'], $p['delivery_method'], $now, $now,
                ]);
            forex_transaction_ensure($enquiryId);
        }
        return true;
    } catch (Throwable $e) {
        log_error('forex_enquiries: save failed — ' . $e->getMessage());
        return false;
    }
}
