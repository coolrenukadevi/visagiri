<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\MorphOne;

#[Fillable(['name', 'email', 'mobile', 'nationality', 'passport_number', 'source'])]
class Customer extends Model
{
    public function partyLink(): MorphOne
    {
        return $this->morphOne(PartyLink::class, 'linkable');
    }
}
