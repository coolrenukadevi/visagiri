<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

#[Fillable(['entry_type', 'direction', 'amount', 'invoice_id', 'payment_id', 'created_by'])]
class LedgerEntry extends Model
{
    const UPDATED_AT = null;

    public const TYPES = ['Invoice Raised', 'Payment Received', 'Invoice Cancelled'];

    public const DIRECTIONS = ['Debit', 'Credit'];

    protected function casts(): array
    {
        return ['amount' => 'decimal:2'];
    }

    public function invoice(): BelongsTo
    {
        return $this->belongsTo(Invoice::class);
    }

    public function payment(): BelongsTo
    {
        return $this->belongsTo(Payment::class);
    }

    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }
}
