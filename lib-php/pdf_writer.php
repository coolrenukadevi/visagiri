<?php
/**
 * A minimal, dependency-free single-page PDF writer, purpose-built for one
 * thing: the reports Summary PDF (employee-reports.php). Same reasoning as
 * xlsx_writer.php — this project pulls in zero external libraries anywhere,
 * and a PDF with plain text, lines and the built-in Helvetica/Helvetica-Bold
 * fonts (part of every PDF reader's Base-14 set, no embedding needed) is a
 * well-understood, bounded byte format to hand-write correctly.
 *
 * Deliberately NOT a general-purpose PDF library: no multi-page flow, no
 * images, no embedded fonts, ASCII text only. The summary report's content
 * is sized to fit comfortably on one page specifically so this class never
 * has to solve pagination — a real general PDF engine is speculative
 * machinery this project has exactly one caller for.
 */
declare(strict_types=1);

final class SimplePdf
{
    private const WIDTH = 595;  // A4 in points, rounded
    private const HEIGHT = 842;
    private array $ops = [];

    public function text(float $x, float $y, string $text, string $font = 'F1', float $size = 10): void
    {
        $this->ops[] = sprintf('BT /%s %s Tf %s %s Td (%s) Tj ET', $font, self::num($size), self::num($x), self::num($y), self::escape($text));
    }

    public function line(float $x1, float $y1, float $x2, float $y2, float $width = 0.5): void
    {
        $this->ops[] = sprintf('%s w %s %s m %s %s l S', self::num($width), self::num($x1), self::num($y1), self::num($x2), self::num($y2));
    }

    private static function num(float $n): string
    {
        return rtrim(rtrim(number_format($n, 2, '.', ''), '0'), '.') ?: '0';
    }

    /** PDF literal strings need \, ( and ) backslash-escaped. Content here
     *  is always our own fixed ASCII labels/numbers, never raw user text —
     *  the byte-for-byte guard is defence in depth, not a Unicode feature. */
    private static function escape(string $s): string
    {
        $s = preg_replace('/[^\x20-\x7e]/', '?', $s) ?? $s;
        return str_replace(['\\', '(', ')'], ['\\\\', '\\(', '\\)'], $s);
    }

    public function save(string $path): bool
    {
        $stream = implode("\n", $this->ops) . "\n";
        $streamLen = strlen($stream);

        $objects = [];
        $objects[1] = "<< /Type /Catalog /Pages 2 0 R >>";
        $objects[2] = "<< /Type /Pages /Kids [3 0 R] /Count 1 >>";
        $objects[3] = "<< /Type /Page /Parent 2 0 R /MediaBox [0 0 " . self::WIDTH . " " . self::HEIGHT . "] "
            . "/Resources << /Font << /F1 5 0 R /F2 6 0 R >> >> /Contents 4 0 R >>";
        $objects[4] = "<< /Length {$streamLen} >>\nstream\n{$stream}endstream";
        $objects[5] = "<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica >>";
        $objects[6] = "<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica-Bold >>";

        $out = "%PDF-1.4\n";
        $offsets = [];
        foreach ($objects as $num => $body) {
            $offsets[$num] = strlen($out);
            $out .= "{$num} 0 obj\n{$body}\nendobj\n";
        }

        $xrefOffset = strlen($out);
        $count = count($objects) + 1;
        $out .= "xref\n0 {$count}\n";
        $out .= "0000000000 65535 f \n";
        for ($i = 1; $i <= count($objects); $i++) {
            $out .= sprintf("%010d 00000 n \n", $offsets[$i]);
        }
        $out .= "trailer\n<< /Size {$count} /Root 1 0 R >>\nstartxref\n{$xrefOffset}\n%%EOF";

        return file_put_contents($path, $out) !== false;
    }
}
