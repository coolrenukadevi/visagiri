<?php
declare(strict_types=1);

/**
 * Quotations + invoices for B2B Travel Partner Portal visa enquiries
 * (Phase B7). Manual payment tracking only — no payment gateway
 * integration exists or was requested anywhere in this project (see
 * database/schema-crm.sql's visa_payments), so an invoice is marked
 * paid by staff recording what was actually collected, never by a
 * fake "Pay Now" button.
 */

const B2B_QUOTATION_STATUS_LABELS = [
    'draft' => 'Draft',
    'sent' => 'Sent to Partner',
    'accepted' => 'Accepted',
    'rejected' => 'Rejected',
];

const B2B_INVOICE_STATUS_LABELS = [
    'issued' => 'Issued',
    'paid' => 'Paid',
    'cancelled' => 'Cancelled',
];

/** VG-B2BQT-YYYY-NNNNNN */
function b2b_generate_quotation_reference(): string
{
    return generate_reference_number('B2BQT', 'b2b_enquiry_quotations', 'quotation_reference_no');
}

/** VG-B2BINV-YYYY-NNNNNN */
function b2b_generate_invoice_reference(): string
{
    return generate_reference_number('B2BINV', 'b2b_enquiry_invoices', 'invoice_reference_no');
}
