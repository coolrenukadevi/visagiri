<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Model;

#[Fillable(['slug', 'name', 'iso2', 'iso3', 'region', 'capital', 'currency', 'hero_summary', 'seo_title', 'seo_description', 'indexable'])]
class Country extends Model
{
    public $timestamps = false;

    protected function casts(): array
    {
        return ['indexable' => 'boolean'];
    }
}
