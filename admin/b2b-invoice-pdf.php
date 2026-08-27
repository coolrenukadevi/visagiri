<?php
require_once __DIR__ . '/includes/admin-auth.php';
require_once __DIR__ . '/../includes/b2b-db.php';
require_once __DIR__ . '/../includes/site-contact.php';
admin_require_login();

$invoiceId = filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT);
if (!$invoiceId) {
    http_response_code(400);
    exit('Invalid invoice id.');
}

$pdo = b2b_db();
$stmt = $pdo->prepare('SELECT i.*, p.application_ref, p.company_name, p.contact_name, p.contact_email, p.address AS partner_address, p.city AS partner_city, p.state AS partner_state, p.country AS partner_country
    FROM b2b_invoices i JOIN b2b_partners p ON p.id = i.partner_id WHERE i.id = ?');
$stmt->execute([$invoiceId]);
$inv = $stmt->fetch(PDO::FETCH_ASSOC);
if (!$inv) {
    http_response_code(404);
    exit('Invoice not found.');
}

$paidStmt = $pdo->prepare('SELECT COALESCE(SUM(amount), 0) FROM b2b_invoice_payments WHERE invoice_id = ?');
$paidStmt->execute([$invoiceId]);
$inv['paid_to_date'] = (float) $paidStmt->fetchColumn();
$inv['balance_due'] = max(0, (float) $inv['total'] - $inv['paid_to_date']);

require_once __DIR__ . '/../includes/lib/fpdf.php';

foreach ($inv as $key => $value) {
    if (is_string($value)) {
        $inv[$key] = b2b_pdf_safe($value);
    }
}

class B2bInvoicePdf extends FPDF
{
    public $docTitle = 'B2B Partner Invoice';

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
        $this->Cell(0, 5, 'This is a tax invoice for B2B partner services rendered by VisaAgency.in.', 0, 1, 'C');
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

$pdf = new B2bInvoicePdf();
$pdf->AliasNbPages();
$pdf->AddPage();

$pdf->LabelRow('Invoice No:', $inv['invoice_number'], true);
$pdf->LabelRow('Date:', date('d/m/Y', strtotime($inv['created_at'])));
if ($inv['due_date']) {
    $pdf->LabelRow('Due Date:', date('d/m/Y', strtotime($inv['due_date'])));
}
$pdf->Ln(4);

$pdf->SetFont('Arial', 'B', 11);
$pdf->SetTextColor(20, 20, 20);
$pdf->Cell(0, 7, 'Billed To', 0, 1);
$pdf->LabelRow('Company:', $inv['company_name']);
$pdf->LabelRow('Partner ID:', $inv['application_ref']);
$pdf->LabelRow('Contact:', $inv['contact_name']);
$pdf->LabelRow('Email:', $inv['contact_email']);
$partnerAddressLine = trim(implode(', ', array_filter([$inv['partner_address'], $inv['partner_city'], $inv['partner_state'], $inv['partner_country']])));
if ($partnerAddressLine !== '') {
    $pdf->LabelRow('Address:', $partnerAddressLine);
}
$pdf->Ln(4);

$pdf->SetFont('Arial', 'B', 11);
$pdf->Cell(0, 7, 'Amount Breakdown', 0, 1);
$pdf->LabelRow('Taxable Amount:', 'Rs. ' . number_format((float) $inv['taxable_amount'], 2));
$pdf->LabelRow('GST:', 'Rs. ' . number_format((float) $inv['gst'], 2));
$pdf->LabelRow('Discount:', '- Rs. ' . number_format((float) $inv['discount'], 2));
$pdf->Ln(2);
$pdf->SetFont('Arial', 'B', 12);
$pdf->SetTextColor(21, 128, 61);
$pdf->Cell(60, 9, 'Total Payable:', 0, 0);
$pdf->Cell(0, 9, 'Rs. ' . number_format((float) $inv['total'], 2), 0, 1);
$pdf->SetTextColor(20, 20, 20);
$pdf->Ln(2);

$pdf->LabelRow('Paid to Date:', 'Rs. ' . number_format($inv['paid_to_date'], 2));
$pdf->SetFont('Arial', 'B', 11);
$pdf->SetTextColor($inv['balance_due'] > 0 ? 197 : 21, $inv['balance_due'] > 0 ? 57 : 128, $inv['balance_due'] > 0 ? 46 : 61);
$pdf->Cell(60, 8, 'Balance Due:', 0, 0);
$pdf->Cell(0, 8, 'Rs. ' . number_format($inv['balance_due'], 2), 0, 1);
$pdf->SetTextColor(20, 20, 20);

$pdf->Ln(6);
$pdf->SetFont('Arial', 'B', 10);
$pdf->Cell(0, 6, 'Status', 0, 1);
$pdf->SetFont('Arial', '', 9);
$pdf->Cell(0, 6, $inv['status'], 0, 1);

$pdf->Ln(6);
$pdf->SetFont('Arial', 'I', 8.5);
$pdf->SetTextColor(130, 130, 130);
$pdf->MultiCell(0, 4.5, 'For queries regarding this invoice, contact your Relationship Manager or write to info@visaagency.in, quoting invoice ' . $inv['invoice_number'] . '.');

$pdf->Output('I', $inv['invoice_number'] . '-Invoice.pdf');
