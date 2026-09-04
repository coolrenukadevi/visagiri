<?php
declare(strict_types=1);

require_once __DIR__ . '/db.php';

const VALID_SERVICE_TYPES = ['visa', 'hotel', 'flight', 'tour', 'insurance', 'forex', 'general'];

/**
 * Finds or creates the customer, then creates an enquiry (plus its
 * service-specific detail row) and an initial follow-up. A dedupe key —
 * customer + service + destination + travel date, rounded to the minute —
 * is unique-constrained in the schema, so an accidental double submit
 * returns the same reference instead of creating a second enquiry.
 */
function create_enquiry(string $serviceType, array $customer, array $serviceData, string $source = 'Website'): array
{
    if (!in_array($serviceType, VALID_SERVICE_TYPES, true)) {
        throw new InvalidArgumentException('Unknown service type: ' . $serviceType);
    }

    $name = trim((string) ($customer['name'] ?? ''));
    $email = trim((string) ($customer['email'] ?? ''));
    $mobile = trim((string) ($customer['mobile'] ?? ''));

    if ($name === '' || ($email === '' && $mobile === '')) {
        throw new InvalidArgumentException('Name and at least one contact method are required.');
    }

    $pdo = db();

    $dedupeSeed = implode('|', [
        strtolower($email ?: $mobile),
        $serviceType,
        $serviceData['destination'] ?? $serviceData['country'] ?? '',
        $serviceData['travel_date'] ?? $serviceData['departure_date'] ?? $serviceData['check_in'] ?? '',
        date('Y-m-d H:i'), // minute-granularity window absorbs double-click, not legitimate re-submits later
    ]);
    $dedupeKey = hash('sha256', $dedupeSeed);

    $existingRef = $pdo->prepare('SELECT reference_no FROM enquiries WHERE dedupe_key = ?');
    $existingRef->execute([$dedupeKey]);
    if ($ref = $existingRef->fetchColumn()) {
        return ['reference_no' => $ref, 'duplicate' => true];
    }

    $customerId = find_or_create_customer($pdo, $name, $email, $mobile, $customer['nationality'] ?? null, $source);
    $referenceNo = next_enquiry_reference($pdo);

    $pdo->beginTransaction();
    try {
        $pdo->prepare(
            'INSERT INTO enquiries (reference_no, service_type, customer_id, country, destination, travel_date, source, dedupe_key, created_by)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)'
        )->execute([
            $referenceNo, $serviceType, $customerId,
            $serviceData['country'] ?? null,
            $serviceData['destination'] ?? $serviceData['country'] ?? $serviceData['travel_country'] ?? $serviceData['to_city'] ?? null,
            $serviceData['travel_date'] ?? $serviceData['departure_date'] ?? $serviceData['check_in'] ?? $serviceData['travel_start'] ?? null,
            $source, $dedupeKey, 'website',
        ]);
        $enquiryId = (int) $pdo->lastInsertId();

        insert_service_detail($pdo, $serviceType, $enquiryId, $serviceData);

        $pdo->prepare('INSERT INTO followups (enquiry_id, follow_up_date, notes, status) VALUES (?, ?, ?, ?)')
            ->execute([$enquiryId, date('Y-m-d', strtotime('+1 day')), 'Initial follow-up on new enquiry.', 'Pending']);

        $pdo->commit();
    } catch (Throwable $e) {
        $pdo->rollBack();
        throw $e;
    }

    return ['reference_no' => $referenceNo, 'duplicate' => false, 'enquiry_id' => $enquiryId];
}

function find_or_create_customer(PDO $pdo, string $name, string $email, string $mobile, ?string $nationality, string $source): int
{
    if ($email !== '' || $mobile !== '') {
        $stmt = $pdo->prepare('SELECT id FROM customers WHERE (email = ? AND email != \'\') OR (mobile = ? AND mobile != \'\') LIMIT 1');
        $stmt->execute([$email, $mobile]);
        if ($id = $stmt->fetchColumn()) {
            return (int) $id;
        }
    }

    $pdo->prepare('INSERT INTO customers (name, email, mobile, nationality, source) VALUES (?, ?, ?, ?, ?)')
        ->execute([$name, $email ?: null, $mobile ?: null, $nationality ?: null, $source]);

    return (int) $pdo->lastInsertId();
}

function insert_service_detail(PDO $pdo, string $serviceType, int $enquiryId, array $d): void
{
    switch ($serviceType) {
        case 'visa':
            $pdo->prepare(
                'INSERT INTO visa_enquiries (enquiry_id, nationality, country_id, visa_category_id, travel_date, travellers_count)
                 VALUES (?, ?, ?, ?, ?, ?)'
            )->execute([$enquiryId, $d['nationality'] ?? null, $d['country_id'] ?? null, $d['visa_category_id'] ?? null, $d['travel_date'] ?? null, $d['travellers_count'] ?? 1]);
            break;
        case 'hotel':
            $pdo->prepare(
                'INSERT INTO hotel_enquiries (enquiry_id, destination, check_in, check_out, rooms, adults, children, hotel_category, budget)
                 VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)'
            )->execute([$enquiryId, $d['destination'] ?? null, $d['check_in'] ?? null, $d['check_out'] ?? null, $d['rooms'] ?? 1, $d['adults'] ?? 1, $d['children'] ?? 0, $d['hotel_category'] ?? null, $d['budget'] ?? null]);
            break;
        case 'flight':
            $pdo->prepare(
                'INSERT INTO flight_enquiries (enquiry_id, from_city, to_city, departure_date, return_date, trip_type, adults, children, cabin_class)
                 VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)'
            )->execute([$enquiryId, $d['from_city'] ?? null, $d['to_city'] ?? null, $d['departure_date'] ?? null, $d['return_date'] ?? null, $d['trip_type'] ?? 'One-way', $d['adults'] ?? 1, $d['children'] ?? 0, $d['cabin_class'] ?? 'Economy']);
            break;
        case 'tour':
            $pdo->prepare(
                'INSERT INTO tour_enquiries (enquiry_id, destination, travel_date, duration, travellers, budget)
                 VALUES (?, ?, ?, ?, ?, ?)'
            )->execute([$enquiryId, $d['destination'] ?? null, $d['travel_date'] ?? null, $d['duration'] ?? null, $d['travellers'] ?? 1, $d['budget'] ?? null]);
            break;
        case 'insurance':
            $pdo->prepare(
                'INSERT INTO insurance_enquiries (enquiry_id, destination, travel_start, travel_end, traveller_count, traveller_ages, insurance_type)
                 VALUES (?, ?, ?, ?, ?, ?, ?)'
            )->execute([$enquiryId, $d['destination'] ?? null, $d['travel_start'] ?? null, $d['travel_end'] ?? null, $d['traveller_count'] ?? 1, $d['traveller_ages'] ?? null, $d['insurance_type'] ?? null]);
            break;
        case 'forex':
            $pdo->prepare(
                'INSERT INTO forex_enquiries (enquiry_id, currency, amount, travel_country, travel_date, forex_type, delivery_pref)
                 VALUES (?, ?, ?, ?, ?, ?, ?)'
            )->execute([$enquiryId, $d['currency'] ?? null, $d['amount'] ?? null, $d['travel_country'] ?? null, $d['travel_date'] ?? null, $d['forex_type'] ?? null, $d['delivery_pref'] ?? null]);
            break;
        case 'general':
        default:
            $pdo->prepare('INSERT INTO general_enquiries (enquiry_id, subject, message) VALUES (?, ?, ?)')
                ->execute([$enquiryId, $d['subject'] ?? null, $d['message'] ?? null]);
            break;
    }
}
