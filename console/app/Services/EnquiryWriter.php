<?php

namespace App\Services;

use App\Models\Enquiry;
use Illuminate\Support\Facades\DB;
use InvalidArgumentException;

/**
 * Creates enquiries the same way the public site's includes/enquiry.php
 * does today: find-or-create the customer, dedupe on customer+service+
 * destination+travel-date within the same minute (absorbs a double-click,
 * not a legitimate later resubmit), then write the header row, its
 * service-specific detail row, and an initial follow-up. Shared by the
 * web "new enquiry" form and the /api/v1/enquiries endpoint so there is
 * exactly one creation path.
 */
class EnquiryWriter
{
    public const VALID_SERVICE_TYPES = ['visa', 'general'];

    /**
     * @param  array{name:string,email?:string,mobile?:string,nationality?:string}  $customer
     */
    public static function create(string $serviceType, array $customer, array $serviceData, string $source = 'Website', ?int $createdBy = null): Enquiry
    {
        if (! in_array($serviceType, self::VALID_SERVICE_TYPES, true)) {
            throw new InvalidArgumentException("Unknown service type: {$serviceType}");
        }

        $name = trim($customer['name'] ?? '');
        $email = trim($customer['email'] ?? '');
        $mobile = trim($customer['mobile'] ?? '');

        if ($name === '' || ($email === '' && $mobile === '')) {
            throw new InvalidArgumentException('Name and at least one contact method are required.');
        }

        $dedupeKey = hash('sha256', implode('|', [
            strtolower($email ?: $mobile),
            $serviceType,
            $serviceData['destination'] ?? $serviceData['country'] ?? '',
            $serviceData['travel_date'] ?? '',
            now()->format('Y-m-d H:i'),
        ]));

        $existing = Enquiry::where('dedupe_key', $dedupeKey)->first();
        if ($existing) {
            return $existing;
        }

        return DB::transaction(function () use ($serviceType, $customer, $serviceData, $source, $dedupeKey, $createdBy) {
            [$customerModel, $party] = PartyResolver::resolve($customer, $source);

            $enquiry = Enquiry::create([
                'reference_no' => EnquiryReferenceGenerator::next(),
                'service_type' => $serviceType,
                'customer_id' => $customerModel->id,
                'party_id' => $party->id,
                'country' => $serviceData['country'] ?? null,
                'destination' => $serviceData['destination'] ?? $serviceData['country'] ?? null,
                'travel_date' => $serviceData['travel_date'] ?? null,
                'status' => 'New',
                'priority' => 'Normal',
                'source' => $source,
                'dedupe_key' => $dedupeKey,
                'created_by' => $createdBy,
            ]);

            if ($serviceType === 'visa') {
                $enquiry->visaDetail()->create([
                    'nationality' => $serviceData['nationality'] ?? null,
                    'country_id' => $serviceData['country_id'] ?? null,
                    'visa_category_id' => $serviceData['visa_category_id'] ?? null,
                    'travel_date' => $serviceData['travel_date'] ?? null,
                    'travellers_count' => $serviceData['travellers_count'] ?? 1,
                ]);
            } else {
                $enquiry->generalDetail()->create([
                    'subject' => $serviceData['subject'] ?? null,
                    'message' => $serviceData['message'] ?? null,
                ]);
            }

            $enquiry->followups()->create([
                'follow_up_date' => now()->addDay()->toDateString(),
                'notes' => 'Initial follow-up on new enquiry.',
                'status' => 'Pending',
            ]);

            return $enquiry;
        });
    }
}
