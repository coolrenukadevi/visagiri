<?php
require_once __DIR__ . '/includes/admin-auth.php';
require_once __DIR__ . '/../includes/forex-db.php';
admin_require_login();

$ref = trim($_GET['ref'] ?? '');
$pdo = forex_db();
$stmt = $pdo->prepare('SELECT * FROM forex_requests WHERE forex_ref = ?');
$stmt->execute([$ref]);
$request = $stmt->fetch(PDO::FETCH_ASSOC);
if (!$request) {
    http_response_code(404);
    exit('Forex request not found.');
}

$delivStmt = $pdo->prepare('SELECT * FROM forex_deliveries WHERE forex_request_id = ?');
$delivStmt->execute([$request['id']]);
$delivery = $delivStmt->fetch(PDO::FETCH_ASSOC);
if (!$delivery) {
    http_response_code(404);
    exit('No delivery record exists for this request.');
}

$denomStmt = $pdo->prepare('SELECT * FROM forex_denominations WHERE delivery_id = ? ORDER BY denomination_value DESC');
$denomStmt->execute([$delivery['id']]);
$denominations = $denomStmt->fetchAll(PDO::FETCH_ASSOC);

foreach ($request as $k => $v) {
    if (is_string($v)) $request[$k] = forex_pdf_safe($v);
}
foreach ($delivery as $k => $v) {
    if (is_string($v)) $delivery[$k] = forex_pdf_safe($v);
}

require_once __DIR__ . '/../includes/lib/fpdf.php';

class ForexReceiptPdf extends FPDF
{
    public $docTitle = 'Forex Delivery Receipt';

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
        $this->SetDrawColor(21, 128, 61);
        $this->SetLineWidth(0.6);
        $this->Line(10, 34, 200, 34);
        $this->Ln(8);
        $this->SetFont('Arial', 'B', 14);
        $this->SetTextColor(20, 20, 20);
        $this->Cell(0, 8, $this->docTitle, 0, 1);
    }

    function Footer()
    {
        $this->SetY(-15);
        $this->SetFont('Arial', '', 8);
        $this->SetTextColor(130, 130, 130);
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

$pdf = new ForexReceiptPdf();
$pdf->AddPage();

$pdf->LabelRow('Forex Reference No:', $request['forex_ref'], true);
$pdf->LabelRow('Delivery Date:', $delivery['delivery_date'] . ' ' . $delivery['delivery_time']);
$pdf->Ln(4);

$pdf->SetFont('Arial', 'B', 11);
$pdf->SetTextColor(20, 20, 20);
$pdf->Cell(0, 7, 'Customer Details', 0, 1);
$pdf->LabelRow('Name:', $request['full_name']);
$pdf->LabelRow('Mobile:', $request['mobile']);
$pdf->LabelRow('Passport Number:', $request['passport_number'] ?: '-');
$pdf->Ln(4);

$pdf->SetFont('Arial', 'B', 11);
$pdf->Cell(0, 7, 'Delivery Details', 0, 1);
$pdf->LabelRow('Currency Delivered:', $delivery['currency_code'] . ' ' . number_format((float) $delivery['total_amount'], 2));
$pdf->LabelRow('Delivered By:', $delivery['delivered_by']);
$pdf->LabelRow('Received By:', $delivery['received_by']);
$pdf->LabelRow('Customer Acknowledgement:', $delivery['customer_ack'] ? 'Confirmed' : 'Not confirmed');
$pdf->Ln(4);

if ($denominations) {
    $pdf->SetFont('Arial', 'B', 11);
    $pdf->Cell(0, 7, 'Denomination Breakdown', 0, 1);
    $pdf->SetFont('Arial', 'B', 9);
    $pdf->SetFillColor(240, 241, 243);
    $pdf->Cell(60, 7, 'Denomination', 1, 0, 'L', true);
    $pdf->Cell(40, 7, 'Quantity', 1, 0, 'C', true);
    $pdf->Cell(50, 7, 'Subtotal', 1, 1, 'R', true);
    $pdf->SetFont('Arial', '', 9);
    foreach ($denominations as $d) {
        $pdf->Cell(60, 7, $delivery['currency_code'] . ' ' . number_format((float) $d['denomination_value'], 2), 1, 0, 'L');
        $pdf->Cell(40, 7, (string) (int) $d['quantity'], 1, 0, 'C');
        $pdf->Cell(50, 7, number_format((float) $d['denomination_value'] * (int) $d['quantity'], 2), 1, 1, 'R');
    }
    $pdf->Ln(4);
}

if ($delivery['remarks']) {
    $pdf->SetFont('Arial', 'B', 10);
    $pdf->Cell(0, 6, 'Remarks', 0, 1);
    $pdf->SetFont('Arial', '', 9);
    $pdf->MultiCell(0, 5, $delivery['remarks']);
    $pdf->Ln(4);
}

$pdf->Ln(10);
$pdf->SetFont('Arial', '', 9);
$pdf->Cell(90, 6, '_________________________', 0, 0);
$pdf->Cell(0, 6, '_________________________', 0, 1);
$pdf->Cell(90, 6, 'Customer Signature', 0, 0);
$pdf->Cell(0, 6, 'Authorized Signatory', 0, 1);

$pdf->Ln(10);
$pdf->SetFont('Arial', 'I', 8);
$pdf->SetTextColor(130, 130, 130);
$pdf->MultiCell(0, 4.5, 'This receipt confirms delivery of foreign currency under Forex Reference ' . $request['forex_ref'] . '. Please retain this receipt for your records.');

$pdf->Output('I', $request['forex_ref'] . '-Delivery-Receipt.pdf');
