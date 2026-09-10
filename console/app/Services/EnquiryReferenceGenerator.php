<?php

namespace App\Services;

use Illuminate\Support\Facades\DB;

/**
 * Generates VDH-YYYY-NNNNNN reference numbers, matching the format the
 * public site already issues (includes/db.php's next_enquiry_reference)
 * and that customers already use on the public Track Application page.
 *
 * Uses MySQL's LAST_INSERT_ID(expr) trick so the increment-and-read is
 * atomic per connection even under concurrent requests — two enquiries
 * created in the same second can never collide on the same number.
 */
class EnquiryReferenceGenerator
{
    public static function next(): string
    {
        $year = (int) date('Y');

        DB::statement(
            'INSERT INTO enquiry_counters (year, last_value) VALUES (?, 1)
             ON DUPLICATE KEY UPDATE last_value = LAST_INSERT_ID(last_value + 1)',
            [$year]
        );

        $value = (int) DB::selectOne('SELECT LAST_INSERT_ID() AS value')->value;

        return sprintf('VDH-%d-%06d', $year, $value);
    }
}
