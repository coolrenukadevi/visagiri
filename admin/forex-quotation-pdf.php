<?php
require_once __DIR__ . '/includes/admin-auth.php';
require_once __DIR__ . '/../includes/forex-db.php';
require_once __DIR__ . '/../includes/site-contact.php';
admin_require_login();

$quotationId = filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT);
if (!$quotationId) {
    http_response_code(400);
    exit('Invalid quotation id.');
}

$pdo = forex_db();
$stmt = $pdo->prepare('SELECT q.*, r.forex_ref, r.full_name, r.mobile, r.email, r.city, r.country_visit
    FROM forex_quotations q JOIN forex_requests r ON r.id = q.forex_request_id WHERE q.id = ?');
$stmt->execute([$quotationId]);
$q = $stmt->fetch(PDO::FETCH_ASSOC);
if (!$q) {
    http_response_code(404);
    exit('Quotation not found.');
}

require_once __DIR__ . '/../includes/lib/fpdf.php';

/**
 * FPDF's core fonts only support single-byte Windows-1252, not UTF-8 — any
 * database value (customer name, payment terms, etc.) that contains a
 * genuinely non-Latin1 character would otherwise render as garbled bytes.
 * Transliterates what it can and drops the rest rather than corrupting output.
 */
function forex_pdf_safe(?string $text): string
{
    $text = (string) $text;
    $converted = @iconv('UTF-8', 'CP1252//TRANSLIT//IGNORE', $text);
    return $converted !== false ? $converted : preg_replace('/[^\x20-\x7E]/', '', $text);
}

foreach ($q as $key => $value) {
    if (is_string($value)) {
        $q[$key] = forex_pdf_safe($value);
    }
}

class ForexPdf extends FPDF
{
    public $docTitle = 'Forex Quotation';

    function Header()
    {
        $this->SetFont('Arial', 'B', 16);
        $this->SetTextColor(11, 27, 51);
        $this->Cell(0, 10, 'VisaAgency.in', 0, 1);
        $this->SetFont('Arial', '', 9);
        $this->SetTextColor(90, 90, 90);
        $this->Cell(0, 5, 'A unit of Tripgation Private Limited', 0, 1);
        $this->Cell(0, 5, '#302, Sharda Mansion Apartment, Kailash Puri, Hanuman Nagar, Patna, Bihar 800020', 0, 1);
        $this->Cell(0, 5, 'info@visaagency.in | +91 78448 19819', 0, 1);
        $this->SetDrawColor(36, 86, 216);
        $this->SetLineWidth(0.6);
        $this->Line(10, 34, 200, 34);
        $this->Ln(8);
        $this->SetFont('Arial', 'B', 14);
        $this->SetTextColor(20, 20, 20);
        $this->Cell(0, 8, $this->docTitle, 0, 1);
    }

    function Footer()
    {
        $this->SetY(-18);
        $this->SetFont('Arial', '', 8);
        $this->SetTextColor(130, 130, 130);
        $this->Cell(0, 5, 'Forex requirements, exchange rates and charges are subject to change without notice and applicable regulatory rules. VisaAgency.in provides consultancy and processing support only.', 0, 1, 'C');
        $this->Cell(0, 5, 'Page ' . $this->PageNo(), 0, 0, 'C');
    }

    function LabelRow($label, $value, $bold = false)
    {
        $this->SetFont('Arial', '', 10);
        $this->SetTextColor(100, 100, 100);
        $this->Cell(60, 7, $label, 0, 0);
        $this->SetFont('Arial', $bold ? 'B' : '', 10);
        $this->SetTextColor(20, 20, 20);
        $this->Cell(0, 7, (string) $value, 0, 1);
    }
}

$pdf = new ForexPdf();
$pdf->AliasNbPages();
$pdf->AddPage();

$pdf->LabelRow('Reference No:', $q['forex_ref'], true);
$pdf->LabelRow('Date:', date('d/m/Y', strtotime($q['created_at'])));
$pdf->Ln(4);

$pdf->SetFont('Arial', 'B', 11);
$pdf->SetTextColor(20, 20, 20);
$pdf->Cell(0, 7, 'Customer Details', 0, 1);
$pdf->LabelRow('Name:', $q['full_name']);
$pdf->LabelRow('Mobile:', $q['mobile']);
if ($q['email']) $pdf->LabelRow('Email:', $q['email']);
if ($q['country_visit']) $pdf->LabelRow('Destination:', $q['country_visit']);
$pdf->Ln(4);

$pdf->SetFont('Arial', 'B', 11);
$pdf->Cell(0, 7, 'Forex Quotation', 0, 1);
$rateTypeNote = $q['rate_type'] === 'Indicative' ? ' (indicative - not a locked rate)' : ($q['rate_type'] === 'Locked / Confirmed' ? ' (locked / confirmed)' : ' (quoted)');
$pdf->LabelRow('Currency:', $q['currency_code']);
$pdf->LabelRow('Currency Amount:', $q['currency_code'] . ' ' . number_format((float) $q['currency_amount'], 2));
$pdf->LabelRow('Exchange Rate:', 'Rs. ' . number_format((float) $q['exchange_rate'], 4) . $rateTypeNote);
$pdf->LabelRow('Base Amount:', 'Rs. ' . number_format((float) $q['base_inr'], 2));
$pdf->LabelRow('Service Charges:', 'Rs. ' . number_format((float) $q['service_charge'], 2));
$pdf->LabelRow('Commission / Markup:', 'Rs. ' . number_format((float) $q['markup'], 2));
$pdf->LabelRow('GST:', 'Rs. ' . number_format((float) $q['gst'], 2));
$pdf->LabelRow('Other Charges:', 'Rs. ' . number_format((float) $q['other_charges'], 2));
$pdf->Ln(2);
$pdf->SetFont('Arial', 'B', 12);
$pdf->SetTextColor(21, 128, 61);
$pdf->Cell(60, 9, 'Total Payable:', 0, 0);
$pdf->Cell(0, 9, 'Rs. ' . number_format((float) $q['total_inr'], 2), 0, 1);
$pdf->SetTextColor(20, 20, 20);
$pdf->Ln(2);

if ($q['valid_until']) {
    $pdf->LabelRow('Valid Until:', date('d/m/Y H:i', strtotime($q['valid_until'])));
}
if ($q['payment_terms']) {
    $pdf->Ln(4);
    $pdf->SetFont('Arial', 'B', 10);
    $pdf->Cell(0, 6, 'Payment Terms', 0, 1);
    $pdf->SetFont('Arial', '', 9);
    $pdf->MultiCell(0, 5, $q['payment_terms']);
}

$pdf->Ln(4);
$pdf->SetFont('Arial', 'B', 10);
$pdf->Cell(0, 6, 'Terms & Conditions', 0, 1);
$pdf->SetFont('Arial', '', 8.5);
$pdf->SetTextColor(90, 90, 90);
$pdf->MultiCell(0, 4.5,
    "1. This quotation is valid only until the date/time stated above and is subject to change thereafter.\n" .
    "2. The exchange rate shown is " . strtolower($q['rate_type']) . " and may be revised until payment is received and the rate is confirmed as locked.\n" .
    "3. Delivery of foreign currency is subject to completion of mandatory KYC and compliance verification (passport, PAN, visa/declaration and other applicable documents).\n" .
    "4. All charges are inclusive of applicable taxes unless stated otherwise.\n" .
    "5. This document does not constitute a guarantee of currency availability at the quoted rate; final rate is confirmed at the time of transaction."
);
$pdf->SetTextColor(20, 20, 20);

$pdf->Ln(6);
$pdf->SetFont('Arial', 'I', 8.5);
$pdf->SetTextColor(130, 130, 130);
$pdf->MultiCell(0, 4.5, 'For queries regarding this quotation, contact us at info@visaagency.in or +91 78448 19819, quoting reference ' . $q['forex_ref'] . '.');

$pdf->Output('I', $q['forex_ref'] . '-Quotation.pdf');
