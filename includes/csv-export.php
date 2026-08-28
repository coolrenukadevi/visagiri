<?php
declare(strict_types=1);

/**
 * Generic CSV download response — the first CSV export anywhere in
 * this codebase (confirmed by grep before writing this), so this is
 * the one shared helper every export action calls rather than each
 * page hand-rolling its own header()/fputcsv() sequence.
 */
function export_csv_response(string $filename, array $headerRow, iterable $rows): never
{
    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename="' . rawurlencode($filename) . '"');
    header('X-Content-Type-Options: nosniff');

    $out = fopen('php://output', 'w');
    // UTF-8 BOM so Excel (still the most common opener for a CSV like
    // this) renders non-ASCII partner/company names correctly instead
    // of guessing the wrong encoding.
    fwrite($out, "\xEF\xBB\xBF");
    fputcsv($out, $headerRow);
    foreach ($rows as $row) {
        fputcsv($out, $row);
    }
    fclose($out);
    exit;
}
