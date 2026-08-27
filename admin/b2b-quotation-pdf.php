<?php
require_once __DIR__ . '/includes/admin-auth.php';
require_once __DIR__ . '/../includes/b2b-db.php';
require_once __DIR__ . '/../includes/site-contact.php';
admin_require_login();

$quotationId = filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT);
if (!$quotationId) {
    http_response_code(400);
    exit('Invalid quotation id.');
}

$pdo = b2b_db();
// Only non-colliding partner columns are selected here — b2b_partners also
// has its own `id`/`status`/`country` columns, and a bare `p.*`/`p.country`
// alongside `q.*` would silently overwrite the quotation's own `country`
// (its destination) with the partner's registered country in PDO::FETCH_ASSOC.
$stmt = $pdo->prepare('SELECT q.*, p.application_ref, p.company_name, p.contact_name, p.contact_email, p.contact_mobile
    FROM b2b_quotations q JOIN b2b_partners p ON p.id = q.partner_id WHERE q.id = ?');
$stmt->execute([$quotationId]);
$q = $stmt->fetch(PDO::FETCH_ASSOC);
if (!$q) {
    http_response_code(404);
    exit('Quotation not found.');
}

require_once __DIR__ . '/../includes/lib/fpdf.php';

foreach ($q as $key => $value) {
    if (is_string($value)) {
        $q[$key] = b2b_pdf_safe($value);
    }
}

class B2bQuotationPdf extends FPDF
{
    public $docTitle = 'B2B Partner Quotation';

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
        $this->Cell(0, 5, 'This is a B2B partner quotation for services rendered by VisaAgency.in. Fees are subject to change without notice until accepted.', 0, 1, 'C');
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

$pdf = new B2bQuotationPdf();
$pdf->AliasNbPages();
$pdf->AddPage();

$pdf->LabelRow('Quotation No:', $q['quotation_ref'], true);
$pdf->LabelRow('Date:', date('d/m/Y', strtotime($q['created_at'])));
$pdf->Ln(4);

$pdf->SetFont('Arial', 'B', 11);
$pdf->SetTextColor(20, 20, 20);
$pdf->Cell(0, 7, 'Partner Details', 0, 1);
$pdf->LabelRow('Company:', $q['company_name']);
$pdf->LabelRow('Partner ID:', $q['application_ref']);
$pdf->LabelRow('Contact:', $q['contact_name']);
$pdf->LabelRow('Email:', $q['contact_email']);
$pdf->Ln(4);

$pdf->SetFont('Arial', 'B', 11);
$pdf->Cell(0, 7, 'Service Details', 0, 1);
$pdf->LabelRow('Service:', $q['service_category']);
$pdf->LabelRow('Destination:', $q['country']);
$pdf->LabelRow('Visa Type:', $q['visa_type']);
$pdf->LabelRow('Applicants:', (string) (int) $q['applicants_count']);
$pdf->Ln(2);

$pdf->SetFont('Arial', 'B', 11);
$pdf->Cell(0, 7, 'Fee Breakdown', 0, 1);
$pdf->LabelRow('Visa Fee:', 'Rs. ' . number_format((float) $q['visa_fee'], 2));
$pdf->LabelRow('Service Fee:', 'Rs. ' . number_format((float) $q['service_fee'], 2));
$pdf->LabelRow('Embassy Fee:', 'Rs. ' . number_format((float) $q['embassy_fee'], 2));
$pdf->LabelRow('Appointment Fee:', 'Rs. ' . number_format((float) $q['appointment_fee'], 2));
$pdf->LabelRow('Courier Fee:', 'Rs. ' . number_format((float) $q['courier_fee'], 2));
$pdf->LabelRow('Other Charges:', 'Rs. ' . number_format((float) $q['other_charges'], 2));
$pdf->LabelRow('Discount:', '- Rs. ' . number_format((float) $q['discount'], 2));
$pdf->LabelRow('GST:', 'Rs. ' . number_format((float) $q['gst'], 2));
$pdf->Ln(2);
$pdf->SetFont('Arial', 'B', 12);
$pdf->SetTextColor(21, 128, 61);
$pdf->Cell(60, 9, 'Total Payable:', 0, 0);
$pdf->Cell(0, 9, 'Rs. ' . number_format((float) $q['total'], 2), 0, 1);
$pdf->SetTextColor(20, 20, 20);
$pdf->Ln(2);

if ($q['valid_until']) {
    $pdf->LabelRow('Valid Until:', date('d/m/Y', strtotime($q['valid_until'])));
}

$pdf->Ln(4);
$pdf->SetFont('Arial', 'B', 10);
$pdf->Cell(0, 6, 'Terms & Conditions', 0, 1);
$pdf->SetFont('Arial', '', 8.5);
$pdf->SetTextColor(90, 90, 90);
$pdf->MultiCell(0, 4.5,
    "1. This quotation is valid only until the date stated above and is subject to change thereafter.\n" .
    "2. All charges are inclusive of applicable taxes unless stated otherwise.\n" .
    "3. This document does not constitute a guarantee of visa approval; approval decisions rest solely with the relevant embassy/consulate.\n" .
    "4. Please log in to your B2B Partner Portal to accept, reject or request a revision of this quotation."
);
$pdf->SetTextColor(20, 20, 20);

$pdf->Ln(6);
$pdf->SetFont('Arial', 'I', 8.5);
$pdf->SetTextColor(130, 130, 130);
$pdf->MultiCell(0, 4.5, 'For queries regarding this quotation, contact your Relationship Manager or write to info@visaagency.in, quoting reference ' . $q['quotation_ref'] . '.');

$pdf->Output('I', $q['quotation_ref'] . '-Quotation.pdf');
