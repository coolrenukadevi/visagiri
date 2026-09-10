<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

#[Fillable(['partner_id', 'terms', 'commission_rate', 'start_date', 'end_date', 'status', 'created_by'])]
class PartnerAgreement extends Model
{
    public const STATUSES = ['Active', 'Expired', 'Terminated'];

    protected function casts(): array
    {
        return [
            'commission_rate' => 'decimal:2',
            'start_date' => 'date',
            'end_date' => 'date',
        ];
    }

    public function partner(): BelongsTo
    {
        return $this->belongsTo(Partner::class);
    }

    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }
}
