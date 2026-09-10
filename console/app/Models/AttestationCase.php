<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\MorphMany;

#[Fillable([
    'case_number', 'customer_id', 'party_id', 'document_type', 'issuing_country_id',
    'destination_country_id', 'status', 'priority', 'assigned_to', 'department_id',
    'branch_id', 'notes', 'created_by', 'updated_by',
])]
class AttestationCase extends Model
{
    /** The real Attestation lifecycle from the architecture doc, minus the
     *  pre-case "Enquiry" state — a case doesn't exist until it's opened. */
    public const STATUSES = [
        'Document Collection', 'Verification', 'Processing', 'Authority Submission',
        'Attestation', 'QC', 'Dispatch', 'Completed', 'Cancelled',
    ];

    public const TERMINAL_STATUSES = ['Completed', 'Cancelled'];

    public const PRIORITIES = ['High', 'Normal', 'Low'];

    public const DOC_TYPES_REQUIRED = [
        'Educational Certificate', 'Marriage Certificate', 'Birth Certificate',
        'Commercial Document', 'Passport', 'Other',
    ];

    public function customer(): BelongsTo
    {
        return $this->belongsTo(Customer::class);
    }

    public function party(): BelongsTo
    {
        return $this->belongsTo(Party::class);
    }

    public function assignedTo(): BelongsTo
    {
        return $this->belongsTo(User::class, 'assigned_to');
    }

    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function updater(): BelongsTo
    {
        return $this->belongsTo(User::class, 'updated_by');
    }

    public function department(): BelongsTo
    {
        return $this->belongsTo(Department::class);
    }

    public function branch(): BelongsTo
    {
        return $this->belongsTo(Branch::class);
    }

    public function issuingCountry(): BelongsTo
    {
        return $this->belongsTo(Country::class, 'issuing_country_id');
    }

    public function destinationCountry(): BelongsTo
    {
        return $this->belongsTo(Country::class, 'destination_country_id');
    }

    public function statusHistory(): HasMany
    {
        return $this->hasMany(AttestationCaseStatusHistory::class)->latest('created_at');
    }

    public function documents(): MorphMany
    {
        return $this->morphMany(Document::class, 'documentable')->latest('created_at');
    }
}
