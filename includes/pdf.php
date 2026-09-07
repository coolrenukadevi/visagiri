<?php
declare(strict_types=1);

/**
 * Minimal hand-rolled PDF writer — no TCPDF/FPDF/mPDF/dompdf, matching
 * this project's zero-dependency convention (no Composer/vendor/
 * directory anywhere; see includes/mail.php's hand-rolled SMTP client
 * for the same discipline applied to email). Writes just enough of
 * the PDF 1.4 object model — a Catalog, Pages, one or more Page
 * objects, a base-14 Helvetica/Helvetica-Bold font (no embedding
 * needed since those are guaranteed present in every PDF reader), and
 * one embedded JPEG image (the Visagiri logo, via the DCTDecode
 * filter — raw JPEG bytes need no re-compression, which is what keeps
 * this simple rather than needing PNG/FlateDecode + alpha-channel
 * handling) — to produce a genuinely valid, openable PDF.
 *
 * Coordinate system matches PDF's own: origin at the bottom-left of
 * the page, y increasing upward. build_enquiry_pdf() below is the
 * only thing other code should call; this class is the low-level tool
 * it's built with.
 */
final class SimplePdfWriter
{
    private const PAGE_WIDTH = 595.28;
    private const PAGE_HEIGHT = 841.89;

    /** @var list<string> raw PDF objects, 1-indexed by array position + 1 */
    private array $objects = [];
    private array $pageContentStreams = [];
    private ?int $imageObjectId = null;
    private string $currentContent = '';

    public function __construct()
    {
        // Reserve object 1 = Catalog, object 2 = Pages, object 3/4 = fonts.
        // Real ids get assigned once we know the full object count, in output().
    }

    public function embedJpegLogo(string $jpegPath): array
    {
        $bytes = file_get_contents($jpegPath);
        if ($bytes === false) {
            throw new RuntimeException("Could not read logo JPEG at $jpegPath");
        }
        [$width, $height] = getimagesize($jpegPath);
        $this->imageBytes = $bytes;
        $this->imageWidth = $width;
        $this->imageHeight = $height;
        return ['width' => $width, 'height' => $height];
    }

    private string $imageBytes = '';
    private int $imageWidth = 0;
    private int $imageHeight = 0;

    public function newPage(): void
    {
        if ($this->currentContent !== '') {
            $this->pageContentStreams[] = $this->currentContent;
        }
        $this->currentContent = '';
    }

    /**
     * A base-14 Type1 font with WinAnsiEncoding reads a PDF string
     * literal one byte per glyph — it does not decode UTF-8. Passing
     * raw UTF-8 customer input straight through renders as blank or
     * garbled glyphs for any accented/non-Latin character. Convert to
     * Latin-1 first (substituting '?' for anything outside it, e.g.
     * emoji or non-Latin scripts) so every character position maps to
     * a real WinAnsi glyph, then escape the PDF string-literal
     * metacharacters.
     */
    private function esc(string $text): string
    {
        $latin1 = @mb_convert_encoding($text, 'ISO-8859-1', 'UTF-8');
        if ($latin1 === false) {
            $latin1 = preg_replace('/[^\x20-\x7E]/', '?', $text) ?? '';
        }
        return str_replace(['\\', '(', ')'], ['\\\\', '\\(', '\\)'], $latin1);
    }

    public function text(float $x, float $y, string $text, float $size, bool $bold = false, array $color = [0, 0, 0]): void
    {
        $font = $bold ? '/FB' : '/F1';
        [$r, $g, $b] = $color;
        $this->currentContent .= sprintf(
            "BT %s %.2f Tf %.3f %.3f %.3f rg %.2f %.2f Td (%s) Tj ET\n",
            $font, $size, $r, $g, $b, $x, $y, $this->esc($text)
        );
    }

    /** Wraps $text to fit within $maxWidth (approximated for Helvetica) and draws each line, returning the y position after the last line. */
    public function textBlock(float $x, float $y, string $text, float $size, float $maxWidth, float $lineHeight, bool $bold = false, array $color = [0, 0, 0]): float
    {
        $avgCharWidth = $size * 0.5;
        $maxCharsPerLine = max(10, (int) ($maxWidth / $avgCharWidth));
        $wrapped = wordwrap($text, $maxCharsPerLine, "\n", true);
        foreach (explode("\n", $wrapped) as $line) {
            $this->text($x, $y, $line, $size, $bold, $color);
            $y -= $lineHeight;
        }
        return $y;
    }

    public function line(float $x1, float $y1, float $x2, float $y2, float $width = 0.75, array $color = [0.7, 0.7, 0.7]): void
    {
        [$r, $g, $b] = $color;
        $this->currentContent .= sprintf(
            "%.3f %.3f %.3f RG %.2f w %.2f %.2f m %.2f %.2f l S\n",
            $r, $g, $b, $width, $x1, $y1, $x2, $y2
        );
    }

    /**
     * Draws a small checkmark using two line segments rather than a
     * Unicode glyph — a base-14 Type1 font with WinAnsiEncoding can't
     * render U+2713 (CHECK MARK) from raw UTF-8 bytes in a PDF string
     * literal (each byte is read as one WinAnsi character code, not
     * decoded as UTF-8), so vector-drawing it is what actually works
     * reliably across every PDF reader.
     */
    public function checkmark(float $x, float $y, float $size = 7, array $color = [0.16, 0.55, 0.28]): void
    {
        [$r, $g, $b] = $color;
        $w = $size * 0.35;
        $this->currentContent .= sprintf(
            "%.3f %.3f %.3f RG %.2f w 1 J 1 j %.2f %.2f m %.2f %.2f l %.2f %.2f l S\n",
            $r, $g, $b, $w,
            $x, $y + $size * 0.4,
            $x + $size * 0.35, $y,
            $x + $size, $y + $size * 0.85
        );
    }

    public function rect(float $x, float $y, float $w, float $h, array $fillColor): void
    {
        [$r, $g, $b] = $fillColor;
        $this->currentContent .= sprintf(
            "%.3f %.3f %.3f rg %.2f %.2f %.2f %.2f re f\n",
            $r, $g, $b, $x, $y, $w, $h
        );
    }

    public function image(float $x, float $y, float $w, float $h): void
    {
        $this->currentContent .= sprintf(
            "q %.2f 0 0 %.2f %.2f %.2f cm /Im1 Do Q\n",
            $w, $h, $x, $y
        );
    }

    public static function pageWidth(): float
    {
        return self::PAGE_WIDTH;
    }

    public static function pageHeight(): float
    {
        return self::PAGE_HEIGHT;
    }

    /** Assembles the full PDF byte string with a correct xref table and trailer. */
    public function output(): string
    {
        if ($this->currentContent !== '') {
            $this->pageContentStreams[] = $this->currentContent;
        }
        $pageCount = count($this->pageContentStreams);
        if ($pageCount === 0) {
            $this->pageContentStreams[] = '';
            $pageCount = 1;
        }

        // Object id plan:
        // 1 = Catalog, 2 = Pages, 3 = Font Helvetica, 4 = Font Helvetica-Bold,
        // 5 = Image XObject (if any), then one Content-stream object and one
        // Page object per page, alternating.
        $hasImage = $this->imageBytes !== '';
        $nextId = $hasImage ? 6 : 5;
        $imageObjId = $hasImage ? 5 : null;

        $pageIds = [];
        $contentIds = [];
        for ($i = 0; $i < $pageCount; $i++) {
            $pageIds[] = $nextId++;
            $contentIds[] = $nextId++;
        }

        $objects = [];

        $kids = implode(' ', array_map(static fn($id) => "$id 0 R", $pageIds));
        $objects[1] = "<< /Type /Catalog /Pages 2 0 R >>";
        $objects[2] = "<< /Type /Pages /Kids [$kids] /Count $pageCount >>";
        // /Encoding /WinAnsiEncoding must be explicit: with none specified,
        // a reader falls back to the font's built-in encoding (Standard-
        // Encoding for the base-14 fonts), whose high byte range (0x80-0xFF)
        // is completely different from Latin-1/WinAnsi — without this,
        // esc()'s Latin-1 conversion produces the wrong glyph for every
        // accented character instead of no glyph at all.
        $objects[3] = "<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica /Encoding /WinAnsiEncoding >>";
        $objects[4] = "<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica-Bold /Encoding /WinAnsiEncoding >>";

        if ($hasImage) {
            $objects[$imageObjId] = [
                'dict' => sprintf(
                    "<< /Type /XObject /Subtype /Image /Width %d /Height %d /ColorSpace /DeviceRGB /BitsPerComponent 8 /Filter /DCTDecode /Length %d >>",
                    $this->imageWidth, $this->imageHeight, strlen($this->imageBytes)
                ),
                'stream' => $this->imageBytes,
            ];
        }

        for ($i = 0; $i < $pageCount; $i++) {
            $resources = "<< /Font << /F1 3 0 R /FB 4 0 R >>" . ($hasImage ? " /XObject << /Im1 $imageObjId 0 R >>" : '') . " >>";
            $objects[$pageIds[$i]] = sprintf(
                "<< /Type /Page /Parent 2 0 R /MediaBox [0 0 %.2f %.2f] /Resources %s /Contents %d 0 R >>",
                self::PAGE_WIDTH, self::PAGE_HEIGHT, $resources, $contentIds[$i]
            );
            $stream = $this->pageContentStreams[$i];
            $objects[$contentIds[$i]] = [
                'dict' => sprintf('<< /Length %d >>', strlen($stream)),
                'stream' => $stream,
            ];
        }

        ksort($objects);

        $pdf = "%PDF-1.4\n%\xE2\xE3\xCF\xD3\n";
        $offsets = [0];
        foreach ($objects as $id => $obj) {
            $offsets[$id] = strlen($pdf);
            if (is_array($obj)) {
                $pdf .= "$id 0 obj\n{$obj['dict']}\nstream\n{$obj['stream']}\nendstream\nendobj\n";
            } else {
                $pdf .= "$id 0 obj\n$obj\nendobj\n";
            }
        }

        $xrefStart = strlen($pdf);
        $totalObjects = max(array_keys($objects)) + 1;
        $pdf .= "xref\n0 $totalObjects\n";
        $pdf .= "0000000000 65535 f \n";
        for ($id = 1; $id < $totalObjects; $id++) {
            $offset = $offsets[$id] ?? 0;
            $pdf .= sprintf("%010d 00000 n \n", $offset);
        }
        $pdf .= "trailer\n<< /Size $totalObjects /Root 1 0 R >>\nstartxref\n$xrefStart\n%%EOF";

        return $pdf;
    }
}

/**
 * Builds the official Visagiri enquiry receipt PDF for one enquiry
 * row (as fetched by admin/pages/enquiries.php or pages/enquire.php's
 * confirmation step) and saves it under storage/documents/enquiry-pdfs/,
 * returning the relative storage path. The PDF is a receipt/checklist
 * of what was submitted — it does not embed the actual uploaded
 * document files themselves (client spec §25).
 */
function build_enquiry_pdf(array $enquiry, array $documents): string
{
    $pdf = new SimplePdfWriter();
    $logoPath = __DIR__ . '/../public/assets/images/logo-pdf.jpg';
    if (is_file($logoPath)) {
        $pdf->embedJpegLogo($logoPath);
    }

    $pageW = SimplePdfWriter::pageWidth();
    $margin = 48;
    $contentW = $pageW - ($margin * 2);
    $y = SimplePdfWriter::pageHeight() - 50;

    $navy = [0.031, 0.165, 0.404]; // #082A67
    $gold = [0.957, 0.706, 0.0];   // #F4B400
    $gray = [0.4, 0.4, 0.4];
    $dark = [0.1, 0.1, 0.1];

    if (is_file($logoPath)) {
        $logoW = 160;
        $logoH = $logoW * (175 / 700);
        $pdf->image($margin, $y - $logoH + 10, $logoW, $logoH);
    }
    $pdf->text($pageW - $margin - 180, $y, 'ENQUIRY RECEIPT', 16, true, $navy);
    $y -= 45;

    $pdf->line($margin, $y, $pageW - $margin, $y, 1.2, $gold);
    $y -= 28;

    // Enquiry Information
    $pdf->text($margin, $y, 'ENQUIRY INFORMATION', 11, true, $navy);
    $y -= 18;
    $enquiryRows = [
        ['Enquiry No.', $enquiry['enquiry_number']],
        ['Tracking No.', $enquiry['tracking_token']],
        ['Submission Date', date('d M Y, h:i A', strtotime($enquiry['created_at']))],
        ['Service Type', $enquiry['service_category'] === 'visa' ? 'Visa Enquiry' : 'Apostille / Document Legalisation'],
        ['Current Status', enquiry_customer_status_label($enquiry['status'])],
    ];
    $y = pdf_render_kv_rows($pdf, $margin, $y, $enquiryRows, $dark, $gray);
    $y -= 12;

    // Customer Details
    $pdf->text($margin, $y, 'CUSTOMER DETAILS', 11, true, $navy);
    $y -= 18;
    $customerRows = [
        ['Customer Name', $enquiry['name']],
        ['Mobile Number', $enquiry['mobile_normalized']],
        ['Email', $enquiry['email']],
        ['Current City', $enquiry['current_city']],
        ['Current State', $enquiry['current_state']],
    ];
    $y = pdf_render_kv_rows($pdf, $margin, $y, $customerRows, $dark, $gray);
    $y -= 12;

    if ($enquiry['service_category'] === 'visa') {
        $pdf->text($margin, $y, 'VISA DETAILS', 11, true, $navy);
        $y -= 18;
        $passportDisplay = $enquiry['passport_number_plain'] ?? null;
        $visaRows = [
            ['Destination Country', $enquiry['destination_country_name'] ?? '—'],
            ['Visa Type', $enquiry['visa_type_name'] ?? '—'],
            ['Passport Number', $passportDisplay !== null ? mask_passport_number($passportDisplay) : '—'],
            ['Passport Issued From', $enquiry['passport_issued_from'] ?? '—'],
            ['Date of Journey', $enquiry['journey_date'] ? date('d M Y', strtotime($enquiry['journey_date'])) : '—'],
            ['Number of Pax', (string) $enquiry['pax_count']],
        ];
        $y = pdf_render_kv_rows($pdf, $margin, $y, $visaRows, $dark, $gray);
    } else {
        $pdf->text($margin, $y, 'APOSTILLE DETAILS', 11, true, $navy);
        $y -= 18;
        $apostilleRows = [
            ['Document Type', $enquiry['apostille_document_type'] ?? '—'],
            ['Number of Documents', $enquiry['apostille_document_count'] !== null ? (string) $enquiry['apostille_document_count'] : '—'],
            ['Destination Country', $enquiry['apostille_country_name'] ?? '—'],
            ['Purpose', $enquiry['apostille_purpose'] ?? '—'],
        ];
        $y = pdf_render_kv_rows($pdf, $margin, $y, $apostilleRows, $dark, $gray);
    }
    $y -= 12;

    if (!empty($enquiry['remarks'])) {
        $pdf->text($margin, $y, 'CUSTOMER REMARKS', 11, true, $navy);
        $y -= 16;
        $y = $pdf->textBlock($margin, $y, $enquiry['remarks'], 9.5, $contentW, 13, false, $dark);
        $y -= 10;
    }

    // Submitted Documents checklist
    $pdf->text($margin, $y, 'SUBMITTED DOCUMENTS', 11, true, $navy);
    $y -= 18;
    if ($documents === []) {
        $pdf->text($margin, $y, 'No documents were attached to this enquiry.', 9.5, false, $gray);
        $y -= 16;
    } else {
        foreach ($documents as $doc) {
            $label = ENQUIRY_DOCUMENT_CATEGORIES[$doc['document_category']] ?? $doc['document_category'];
            $pdf->checkmark($margin, $y - 1, 8);
            $pdf->text($margin + 16, $y, $label, 9.5, false, $dark);
            $y -= 16;
            if ($y < 120) {
                $pdf->newPage();
                $y = SimplePdfWriter::pageHeight() - 60;
            }
        }
    }

    // Footer disclaimer + contact, pinned near the bottom of the current page
    $footerY = 70;
    $pdf->line($margin, $footerY + 30, $pageW - $margin, $footerY + 30, 0.75, $gray);
    $phone = setting('contact_phone_display', '+91 7065 819 819');
    $email = setting('contact_email', 'info@visagiri.com');
    $pdf->text($margin, $footerY + 14, "Phone: $phone   |   Email: $email", 8.5, false, $gray);
    $pdf->textBlock($margin, $footerY, enquiry_disclaimer_text(), 7.5, $contentW, 10, false, $gray);

    $bytes = $pdf->output();

    $dir = STORAGE_PATH . '/documents/enquiry-pdfs';
    if (!is_dir($dir)) {
        mkdir($dir, 0755, true);
    }
    $filename = $enquiry['enquiry_number'] . '.pdf';
    $path = $dir . '/' . $filename;
    file_put_contents($path, $bytes);

    return 'storage/documents/enquiry-pdfs/' . $filename;
}

/** Draws a two-column label/value list, returning the y position after the last row. */
function pdf_render_kv_rows(SimplePdfWriter $pdf, float $x, float $y, array $rows, array $valueColor, array $labelColor): float
{
    foreach ($rows as [$label, $value]) {
        $pdf->text($x, $y, $label . ':', 9.5, false, $labelColor);
        $pdf->text($x + 160, $y, (string) $value, 9.5, false, $valueColor);
        $y -= 16;
    }
    return $y;
}
