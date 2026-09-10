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
 *
 * Both the insert value and the update expression are wrapped in
 * LAST_INSERT_ID(...): MySQL only threads a bare column assignment
 * through to a later SELECT LAST_INSERT_ID() on the ON DUPLICATE KEY
 * UPDATE path, not on a fresh INSERT (year is not an auto_increment
 * column) — leaving the very first number of each year to pick up
 * whatever unrelated auto_increment id the connection last touched.
 */
class EnquiryReferenceGenerator
{
    public static function next(): string
    {
        $year = (int) date('Y');

        DB::statement(
            'INSERT INTO enquiry_counters (year, last_value) VALUES (?, LAST_INSERT_ID(1))
             ON DUPLICATE KEY UPDATE last_value = LAST_INSERT_ID(last_value + 1)',
            [$year]
        );

        $value = (int) DB::selectOne('SELECT LAST_INSERT_ID() AS value')->value;

        return sprintf('VDH-%d-%06d', $year, $value);
    }
}
