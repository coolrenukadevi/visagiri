<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\MorphTo;

#[Fillable(['party_id', 'linkable_type', 'linkable_id'])]
class PartyLink extends Model
{
    public function party(): BelongsTo
    {
        return $this->belongsTo(Party::class);
    }

    public function linkable(): MorphTo
    {
        return $this->morphTo();
    }
}
