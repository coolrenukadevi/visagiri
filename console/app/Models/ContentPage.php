<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

#[Fillable(['slug', 'title', 'content', 'status', 'created_by', 'updated_by', 'published_at'])]
class ContentPage extends Model
{
    public const STATUSES = ['Draft', 'In Review', 'Approved', 'Published'];

    /** Forward-only — publishing a live page requires going through review again, not a silent revert. */
    public const NEXT_STATUS = [
        'Draft' => 'In Review',
        'In Review' => 'Approved',
        'Approved' => 'Published',
    ];

    protected function casts(): array
    {
        return ['published_at' => 'datetime'];
    }

    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function updater(): BelongsTo
    {
        return $this->belongsTo(User::class, 'updated_by');
    }

    public function revisions(): HasMany
    {
        return $this->hasMany(ContentRevision::class)->latest('created_at');
    }
}
