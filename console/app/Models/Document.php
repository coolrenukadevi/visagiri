<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\MorphTo;

#[Fillable([
    'documentable_type', 'documentable_id', 'doc_type', 'original_filename',
    'stored_filename', 'disk', 'mime_type', 'size_bytes', 'status', 'uploaded_by',
])]
class Document extends Model
{
    public const DOC_TYPES = [
        'Passport', 'Educational Certificate', 'Marriage Certificate',
        'Birth Certificate', 'Commercial Document', 'Supporting', 'Other',
    ];

    public const STATUSES = ['Uploaded', 'Verified', 'Rejected'];

    public function documentable(): MorphTo
    {
        return $this->morphTo();
    }

    public function uploadedBy(): BelongsTo
    {
        return $this->belongsTo(User::class, 'uploaded_by');
    }
}
