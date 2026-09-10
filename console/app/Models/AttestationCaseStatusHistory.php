<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

#[Fillable(['attestation_case_id', 'from_status', 'to_status', 'notes', 'changed_by'])]
class AttestationCaseStatusHistory extends Model
{
    protected $table = 'attestation_case_status_history';

    const UPDATED_AT = null;

    public function case(): BelongsTo
    {
        return $this->belongsTo(AttestationCase::class, 'attestation_case_id');
    }

    public function changedBy(): BelongsTo
    {
        return $this->belongsTo(User::class, 'changed_by');
    }
}
