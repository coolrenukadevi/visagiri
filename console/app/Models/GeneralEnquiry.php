<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

#[Fillable(['enquiry_id', 'subject', 'message'])]
class GeneralEnquiry extends Model
{
    public $incrementing = false;

    protected $primaryKey = 'enquiry_id';

    public $timestamps = false;

    public function enquiry(): BelongsTo
    {
        return $this->belongsTo(Enquiry::class);
    }
}
