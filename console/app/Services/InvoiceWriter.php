<?php

namespace App\Services;

use App\Models\Invoice;
use App\Models\LedgerEntry;
use App\Models\User;
use Illuminate\Support\Facades\DB;
use InvalidArgumentException;

/**
 * Every state change an invoice goes through — creation, approval,
 * rejection, payment — happens here, in a transaction, alongside the
 * ledger entry and/or approval-log row it implies. The one rule this
 * class exists to enforce in code, not just convention: the person who
 * approves or rejects an invoice can never be the person who created it
 * (the architecture doc's "four-eyes" diagram, made real).
 */
class InvoiceWriter
{
    public static function create(array $data, int $createdBy): Invoice
    {
        if (empty($data['description']) || empty($data['amount'])) {
            throw new InvalidArgumentException('description and amount are required.');
        }

        return DB::transaction(function () use ($data, $createdBy) {
            $invoice = new Invoice([
                'invoice_number' => InvoiceNumberGenerator::next(),
                'party_id' => $data['party_id'] ?? null,
                'customer_id' => $data['customer_id'] ?? null,
                'partner_id' => $data['partner_id'] ?? null,
                'description' => $data['description'],
                'amount' => $data['amount'],
                'due_date' => $data['due_date'] ?? null,
                'department_id' => $data['department_id'] ?? null,
                'branch_id' => $data['branch_id'] ?? null,
                'created_by' => $createdBy,
            ]);

            // Below the four-eyes threshold, an invoice needs no second
            // signature and is approved the moment it's raised.
            $invoice->status = $invoice->requiresApproval() ? 'Pending Approval' : 'Approved';
            $invoice->save();

            if ($invoice->status === 'Approved') {
                self::recordLedgerEntry($invoice, 'Invoice Raised', 'Debit', $invoice->amount, $createdBy);
            }

            return $invoice;
        });
    }

    public static function decide(Invoice $invoice, string $action, User $actor, ?string $notes = null): Invoice
    {
        if (! in_array($action, ['Approved', 'Rejected'], true)) {
            throw new InvalidArgumentException("Unknown action: {$action}");
        }

        if ($invoice->status !== 'Pending Approval') {
            throw new InvalidArgumentException('Only invoices pending approval can be decided.');
        }

        if ($invoice->created_by === $actor->id) {
            throw new InvalidArgumentException('The invoice creator cannot approve or reject their own invoice — four-eyes requires a second person.');
        }

        return DB::transaction(function () use ($invoice, $action, $actor, $notes) {
            $invoice->approvals()->create([
                'action' => $action,
                'actor_id' => $actor->id,
                'notes' => $notes,
            ]);

            $invoice->update(['status' => $action, 'updated_by' => $actor->id]);

            if ($action === 'Approved') {
                self::recordLedgerEntry($invoice, 'Invoice Raised', 'Debit', $invoice->amount, $actor->id);
            }

            return $invoice->fresh();
        });
    }

    public static function recordPayment(Invoice $invoice, array $data, int $receivedBy): Invoice
    {
        if (! in_array($invoice->status, ['Approved', 'Partially Paid'], true)) {
            throw new InvalidArgumentException('Payments can only be recorded against an approved invoice.');
        }

        if (empty($data['amount']) || (float) $data['amount'] <= 0) {
            throw new InvalidArgumentException('Payment amount must be greater than zero.');
        }

        return DB::transaction(function () use ($invoice, $data, $receivedBy) {
            $payment = $invoice->payments()->create([
                'amount' => $data['amount'],
                'method' => $data['method'] ?? 'Bank Transfer',
                'reference_no' => $data['reference_no'] ?? null,
                'notes' => $data['notes'] ?? null,
                'received_by' => $receivedBy,
            ]);

            self::recordLedgerEntry($invoice, 'Payment Received', 'Credit', $payment->amount, $receivedBy, $payment->id);

            $invoice->refresh();
            $newStatus = (float) $invoice->balanceDue() <= 0 ? 'Paid' : 'Partially Paid';
            $invoice->update(['status' => $newStatus, 'updated_by' => $receivedBy]);

            return $invoice->fresh();
        });
    }

    private static function recordLedgerEntry(Invoice $invoice, string $type, string $direction, string $amount, int $createdBy, ?int $paymentId = null): void
    {
        LedgerEntry::create([
            'entry_type' => $type,
            'direction' => $direction,
            'amount' => $amount,
            'invoice_id' => $invoice->id,
            'payment_id' => $paymentId,
            'created_by' => $createdBy,
        ]);
    }
}
