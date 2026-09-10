<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;

#[Fillable([
    'reference_no', 'service_type', 'customer_id', 'party_id', 'country', 'destination',
    'travel_date', 'status', 'priority', 'source', 'assigned_to', 'department_id', 'branch_id',
    'notes', 'dedupe_key', 'created_by', 'updated_by',
])]
class Enquiry extends Model
{
    /** Pipeline statuses shared by every service type — matches the live public site's CRM today. */
    public const STATUSES = ['New', 'Contacted', 'In Progress', 'Converted', 'Lost'];

    public const PRIORITIES = ['High', 'Normal', 'Low'];

    public const VISA_APPLICATION_STATUSES = [
        'New', 'Contacted', 'Documents Pending', 'Documents Received', 'Application Prepared',
        'Appointment Pending', 'Submitted', 'Under Processing', 'Approved', 'Rejected', 'Closed',
    ];

    public const PAYMENT_STATUSES = ['Pending', 'Partial', 'Paid'];

    protected function casts(): array
    {
        return [
            'travel_date' => 'date',
        ];
    }

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

    public function visaDetail(): HasOne
    {
        return $this->hasOne(VisaEnquiry::class);
    }

    public function generalDetail(): HasOne
    {
        return $this->hasOne(GeneralEnquiry::class);
    }

    public function followups(): HasMany
    {
        return $this->hasMany(Followup::class);
    }
}
