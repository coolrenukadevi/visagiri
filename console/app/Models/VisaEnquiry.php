<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

#[Fillable([
    'enquiry_id', 'passport_number', 'nationality', 'country_id', 'visa_category_id',
    'travel_date', 'return_date', 'travellers_count', 'appointment_date', 'visa_fee',
    'service_fee', 'payment_status', 'application_status',
])]
class VisaEnquiry extends Model
{
    public $incrementing = false;

    protected $primaryKey = 'enquiry_id';

    public $timestamps = false;

    protected function casts(): array
    {
        return [
            'travel_date' => 'date',
            'return_date' => 'date',
            'appointment_date' => 'date',
        ];
    }

    public function enquiry(): BelongsTo
    {
        return $this->belongsTo(Enquiry::class);
    }

    public function country(): BelongsTo
    {
        return $this->belongsTo(Country::class);
    }

    public function visaCategory(): BelongsTo
    {
        return $this->belongsTo(VisaCategory::class);
    }
}
