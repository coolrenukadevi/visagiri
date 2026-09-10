<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

#[Fillable([
    'invoice_number', 'party_id', 'customer_id', 'partner_id', 'description', 'amount',
    'status', 'due_date', 'department_id', 'branch_id', 'created_by', 'updated_by',
])]
class Invoice extends Model
{
    public const STATUSES = ['Draft', 'Pending Approval', 'Approved', 'Partially Paid', 'Paid', 'Rejected', 'Cancelled'];

    /** Invoices at or above this amount need a second person's approval before they can be sent. */
    public const APPROVAL_THRESHOLD = 100000.00;

    protected function casts(): array
    {
        return [
            'amount' => 'decimal:2',
            'due_date' => 'date',
        ];
    }

    public function party(): BelongsTo
    {
        return $this->belongsTo(Party::class);
    }

    public function customer(): BelongsTo
    {
        return $this->belongsTo(Customer::class);
    }

    public function partner(): BelongsTo
    {
        return $this->belongsTo(Partner::class);
    }

    public function department(): BelongsTo
    {
        return $this->belongsTo(Department::class);
    }

    public function branch(): BelongsTo
    {
        return $this->belongsTo(Branch::class);
    }

    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function updater(): BelongsTo
    {
        return $this->belongsTo(User::class, 'updated_by');
    }

    public function approvals(): HasMany
    {
        return $this->hasMany(InvoiceApproval::class)->latest('created_at');
    }

    public function payments(): HasMany
    {
        return $this->hasMany(Payment::class)->latest('received_at');
    }

    public function ledgerEntries(): HasMany
    {
        return $this->hasMany(LedgerEntry::class)->latest('created_at');
    }

    /**
     * Money math done in integer paise/cents rather than bcmath (not
     * available in every PHP install) or raw float subtraction — exact
     * for currency magnitudes far beyond anything this app will see,
     * since doubles are exact integers up to 2^53.
     */
    private static function toCents(string|int|float $amount): int
    {
        return (int) round(((float) $amount) * 100);
    }

    public function requiresApproval(): bool
    {
        return self::toCents($this->amount) >= self::toCents(self::APPROVAL_THRESHOLD);
    }

    public function totalPaid(): string
    {
        return number_format((float) $this->payments()->sum('amount'), 2, '.', '');
    }

    public function balanceDue(): string
    {
        $cents = self::toCents($this->amount) - self::toCents($this->totalPaid());

        return number_format($cents / 100, 2, '.', '');
    }

    public function isOverdue(): bool
    {
        return $this->due_date
            && $this->due_date->isPast()
            && ! in_array($this->status, ['Paid', 'Cancelled', 'Rejected'], true);
    }
}
