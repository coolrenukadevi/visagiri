<?php

namespace App\Services;

use Illuminate\Support\Facades\DB;

/**
 * Generates INV-YYYY-NNNNNN invoice numbers. Same atomic counter approach
 * as EnquiryReferenceGenerator / AttestationCaseNumberGenerator — see
 * EnquiryReferenceGenerator's docblock for why the insert value must be
 * wrapped in LAST_INSERT_ID(...) too, not just the update expression.
 */
class InvoiceNumberGenerator
{
    public static function next(): string
    {
        $year = (int) date('Y');

        DB::statement(
            'INSERT INTO invoice_counters (year, last_value) VALUES (?, LAST_INSERT_ID(1))
             ON DUPLICATE KEY UPDATE last_value = LAST_INSERT_ID(last_value + 1)',
            [$year]
        );

        $value = (int) DB::selectOne('SELECT LAST_INSERT_ID() AS value')->value;

        return sprintf('INV-%d-%06d', $year, $value);
    }
}
