<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

#[Fillable(['name', 'type', 'contact_name', 'email', 'mobile', 'commission_rate', 'credit_limit', 'status', 'created_by'])]
class Partner extends Model
{
    public const TYPES = ['Travel Agency', 'Corporate', 'Freelance Agent', 'Other'];

    public const STATUSES = ['Active', 'Inactive'];

    protected function casts(): array
    {
        return [
            'commission_rate' => 'decimal:2',
            'credit_limit' => 'decimal:2',
        ];
    }

    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function agreements(): HasMany
    {
        return $this->hasMany(PartnerAgreement::class)->latest('start_date');
    }

    public function invoices(): HasMany
    {
        return $this->hasMany(Invoice::class);
    }
}
