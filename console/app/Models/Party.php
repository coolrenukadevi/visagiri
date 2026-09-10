<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

#[Fillable(['type', 'display_name', 'primary_email', 'primary_mobile'])]
class Party extends Model
{
    public function links(): HasMany
    {
        return $this->hasMany(PartyLink::class);
    }

    /**
     * Find the party for an existing linkable record, or create both the
     * party and the link in one step. Keeps every module resolving to the
     * same canonical party instead of creating its own customer identity.
     */
    public static function resolveFor(Model $linkable, string $type = 'customer'): self
    {
        $link = $linkable->partyLink()->first();

        if ($link) {
            return $link->party;
        }

        $party = self::create([
            'type' => $type,
            'display_name' => $linkable->name,
            'primary_email' => $linkable->email,
            'primary_mobile' => $linkable->mobile,
        ]);

        $linkable->partyLink()->create(['party_id' => $party->id]);

        return $party;
    }
}
