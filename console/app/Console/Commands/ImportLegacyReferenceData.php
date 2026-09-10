<?php

namespace App\Console\Commands;

use App\Models\Country;
use App\Models\VisaCategory;
use Illuminate\Console\Command;
use PDO;

/**
 * Imports the real countries + visa_categories reference data from the
 * public site's live SQLite database (data/videshia.sqlite). These are
 * the only two tables in that database with genuine, non-empty content
 * today — customers/enquiries there are empty, so there is nothing to
 * migrate for those yet (see the Enquiry seeder/module instead).
 *
 * Opened read-only: this command must never be able to write back to the
 * production SQLite file the public site still serves from.
 */
class ImportLegacyReferenceData extends Command
{
    protected $signature = 'console:import-legacy-data {--path= : Path to the legacy videshia.sqlite file}';

    protected $description = 'Import real countries + visa categories from the public site\'s SQLite database';

    public function handle(): int
    {
        $path = $this->option('path') ?: base_path('../data/videshia.sqlite');

        if (! is_file($path)) {
            $this->error("SQLite file not found at: {$path}");

            return self::FAILURE;
        }

        $pdo = new PDO('sqlite:'.$path, options: [
            PDO::SQLITE_ATTR_OPEN_FLAGS => PDO::SQLITE_OPEN_READONLY,
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        ]);

        $countries = $pdo->query('SELECT slug, name, iso2, iso3, region, capital, currency, hero_summary, seo_title, seo_description, indexable FROM countries')->fetchAll(PDO::FETCH_ASSOC);
        foreach ($countries as $row) {
            $row['indexable'] = (bool) $row['indexable'];
            Country::updateOrCreate(['slug' => $row['slug']], $row);
        }
        $this->info(count($countries).' countries imported.');

        $categories = $pdo->query('SELECT slug, name, description FROM visa_categories')->fetchAll(PDO::FETCH_ASSOC);
        foreach ($categories as $row) {
            VisaCategory::updateOrCreate(['slug' => $row['slug']], $row);
        }
        $this->info(count($categories).' visa categories imported.');

        return self::SUCCESS;
    }
}
