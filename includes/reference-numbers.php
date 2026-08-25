<?php
declare(strict_types=1);

/**
 * Centralized reference-number generator — every CRM record type
 * (customers, visa enquiries, visa applications, quotes, general
 * enquiries) gets one from here, in the format VG-{PREFIX}-YYYY-NNNNNN.
 * Counts real rows for the year rather than maintaining a separate
 * counter table — the same pragmatic approach already used for the
 * original VIS-YYYY-NNNNNN enquiry numbers (fine at this site's real
 * traffic volume: a handful of records a day, not a high-concurrency
 * system). The UNIQUE constraint on every reference-number column is
 * the actual safety net; callers retry once on the rare same-instant
 * collision — see callers for the retry loop.
 */
function generate_reference_number(string $prefix, string $table, string $column): string
{
    $year = date('Y');
    $likePattern = "VG-$prefix-$year-%";
    $stmt = db()->prepare("SELECT COUNT(*) FROM `$table` WHERE `$column` LIKE :prefix");
    $stmt->execute(['prefix' => $likePattern]);
    $count = (int) $stmt->fetchColumn() + 1;
    return sprintf('VG-%s-%s-%06d', $prefix, $year, $count);
}
