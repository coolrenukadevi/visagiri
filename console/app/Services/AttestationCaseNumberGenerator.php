<?php

namespace App\Services;

use Illuminate\Support\Facades\DB;

/**
 * Generates ATT-YYYY-NNNNNN case numbers. Same atomic LAST_INSERT_ID(expr)
 * approach as EnquiryReferenceGenerator (see its docblock for why both the
 * insert value and the update expression must be wrapped in
 * LAST_INSERT_ID(...), not just the update side), against its own counter
 * table so case numbers don't share the enquiry sequence.
 */
class AttestationCaseNumberGenerator
{
    public static function next(): string
    {
        $year = (int) date('Y');

        DB::statement(
            'INSERT INTO attestation_case_counters (year, last_value) VALUES (?, LAST_INSERT_ID(1))
             ON DUPLICATE KEY UPDATE last_value = LAST_INSERT_ID(last_value + 1)',
            [$year]
        );

        $value = (int) DB::selectOne('SELECT LAST_INSERT_ID() AS value')->value;

        return sprintf('ATT-%d-%06d', $year, $value);
    }
}
