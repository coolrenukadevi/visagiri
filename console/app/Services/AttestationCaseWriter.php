<?php

namespace App\Services;

use App\Models\AttestationCase;
use Illuminate\Support\Facades\DB;
use InvalidArgumentException;

/**
 * Creates attestation cases and transitions their status — every
 * transition writes an attestation_case_status_history row in the same
 * transaction as the status change, so "real audit trail" is actually
 * true rather than just the case's current status overwritten in place.
 */
class AttestationCaseWriter
{
    /**
     * @param  array{name:string,email?:string,mobile?:string,nationality?:string}  $customer
     */
    public static function create(array $customer, array $caseData, string $source, ?int $createdBy = null): AttestationCase
    {
        $name = trim($customer['name'] ?? '');
        $email = trim($customer['email'] ?? '');
        $mobile = trim($customer['mobile'] ?? '');

        if ($name === '' || ($email === '' && $mobile === '')) {
            throw new InvalidArgumentException('Name and at least one contact method are required.');
        }

        if (empty($caseData['document_type'])) {
            throw new InvalidArgumentException('document_type is required.');
        }

        return DB::transaction(function () use ($customer, $caseData, $source, $createdBy) {
            [$customerModel, $party] = PartyResolver::resolve($customer, $source);

            $case = AttestationCase::create([
                'case_number' => AttestationCaseNumberGenerator::next(),
                'customer_id' => $customerModel->id,
                'party_id' => $party->id,
                'document_type' => $caseData['document_type'],
                'issuing_country_id' => $caseData['issuing_country_id'] ?? null,
                'destination_country_id' => $caseData['destination_country_id'] ?? null,
                'status' => AttestationCase::STATUSES[0],
                'priority' => 'Normal',
                'notes' => $caseData['notes'] ?? null,
                'created_by' => $createdBy,
            ]);

            $case->statusHistory()->create([
                'from_status' => null,
                'to_status' => $case->status,
                'notes' => 'Case opened.',
                'changed_by' => $createdBy,
            ]);

            return $case;
        });
    }

    public static function transition(AttestationCase $case, string $toStatus, ?int $changedBy, ?string $notes = null): AttestationCase
    {
        if (! in_array($toStatus, AttestationCase::STATUSES, true)) {
            throw new InvalidArgumentException("Unknown status: {$toStatus}");
        }

        DB::transaction(function () use ($case, $toStatus, $changedBy, $notes) {
            $fromStatus = $case->status;

            $case->update(['status' => $toStatus, 'updated_by' => $changedBy]);

            if ($fromStatus !== $toStatus) {
                $case->statusHistory()->create([
                    'from_status' => $fromStatus,
                    'to_status' => $toStatus,
                    'notes' => $notes,
                    'changed_by' => $changedBy,
                ]);
            }
        });

        return $case->fresh();
    }
}
