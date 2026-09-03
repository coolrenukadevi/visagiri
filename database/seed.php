<?php
declare(strict_types=1);

require __DIR__ . '/countries-data.php';
require __DIR__ . '/visa-content.php';

function seed_database(PDO $pdo): void
{
    $roles = [
        ['super_admin', 'Super Admin'],
        ['admin', 'Admin'],
        ['sales_manager', 'Sales Manager'],
        ['travel_consultant', 'Travel Consultant'],
        ['visa_consultant', 'Visa Consultant'],
        ['forex_consultant', 'Forex Consultant'],
        ['operations', 'Operations'],
    ];
    $roleStmt = $pdo->prepare('INSERT INTO roles (slug, name) VALUES (?, ?)');
    foreach ($roles as [$slug, $name]) {
        $roleStmt->execute([$slug, $name]);
    }
    $roleIds = $pdo->query('SELECT slug, id FROM roles')->fetchAll(PDO::FETCH_KEY_PAIR);

    // Demo accounts so the CRM is explorable without a real onboarding flow yet.
    $demoUsers = [
        ['Admin User', 'admin@videshia.com', 'Videshia@123', 'super_admin'],
        ['Priya Sharma', 'visa.consultant@videshia.com', 'Videshia@123', 'visa_consultant'],
    ];
    $userStmt = $pdo->prepare('INSERT INTO users (role_id, name, email, password_hash, status) VALUES (?, ?, ?, ?, ?)');
    foreach ($demoUsers as [$name, $email, $password, $roleSlug]) {
        $userStmt->execute([$roleIds[$roleSlug], $name, $email, password_hash($password, PASSWORD_BCRYPT), 'active']);
    }

    $catalog = visa_category_catalog();
    $catStmt = $pdo->prepare('INSERT INTO visa_categories (slug, name, description) VALUES (?, ?, ?)');
    foreach ($catalog as $slug => $meta) {
        $catStmt->execute([$slug, $meta['name'], 'For ' . $meta['purpose'] . '.']);
    }
    $categoryIds = $pdo->query('SELECT slug, id FROM visa_categories')->fetchAll(PDO::FETCH_KEY_PAIR);

    $flagship = flagship_country_facts();

    $countryStmt = $pdo->prepare(
        'INSERT INTO countries (slug, name, iso2, iso3, region, capital, currency, hero_summary, seo_title, seo_description, indexable)
         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)'
    );
    $countryIds = [];
    foreach (all_countries_data() as [$slug, $name, $iso2, $iso3, $region, $capital, $currency]) {
        $isFlagship = isset($flagship[$slug]);
        $hero = "Planning a trip to {$name}? Videshia handles your visa application end-to-end — document checklist, "
            . "application, appointment booking and status tracking, with a consultant assigned to your case.";
        $seoTitle = "{$name} Visa from India — Apply Online | Videshia";
        $seoDesc = "Apply for a {$name} visa from India with Videshia. Document checklists, processing times and expert guidance for tourist, business and other visa categories.";

        $countryStmt->execute([$slug, $name, $iso2, $iso3, $region, $capital, $currency, $hero, $seoTitle, $seoDesc, $isFlagship ? 1 : 0]);
        $countryIds[$slug] = (int) $pdo->lastInsertId();
    }

    $cvcStmt = $pdo->prepare(
        'INSERT INTO country_visa_categories
         (country_id, visa_category_id, overview, eligibility, documents_required, process_steps, processing_time, visa_fee,
          validity, stay_duration, entry_requirements, financial_requirements, common_rejection_reasons, important_notes,
          seo_title, seo_description, indexable, last_reviewed_at)
         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 1, datetime(\'now\'))'
    );
    $faqStmt = $pdo->prepare('INSERT INTO faqs (scope_type, scope_id, question, answer, sort_order) VALUES (\'country_visa\', ?, ?, ?, ?)');

    foreach ($flagship as $slug => $facts) {
        $countryId = $countryIds[$slug] ?? null;
        if (!$countryId) {
            continue;
        }
        $countryName = null;
        foreach (all_countries_data() as $row) {
            if ($row[0] === $slug) {
                $countryName = $row[1];
                break;
            }
        }

        foreach ($facts['categories'] as $categorySlug) {
            if (!isset($catalog[$categorySlug], $categoryIds[$categorySlug])) {
                continue;
            }
            $category = $catalog[$categorySlug];
            $content = compose_visa_content($slug, $countryName, $facts, $categorySlug, $category);

            $cvcStmt->execute([
                $countryId, $categoryIds[$categorySlug],
                $content['overview'], $content['eligibility'], $content['documents_required'], $content['process_steps'],
                $content['processing_time'], $content['visa_fee'], $content['validity'], $content['stay_duration'],
                $content['entry_requirements'], $content['financial_requirements'], $content['common_rejection_reasons'],
                $content['important_notes'], $content['seo_title'], $content['seo_description'],
            ]);
            $cvcId = (int) $pdo->lastInsertId();

            $order = 0;
            foreach (visa_faqs_for($countryName, $category, $facts) as [$q, $a]) {
                $faqStmt->execute([$cvcId, $q, $a, $order++]);
            }
        }
    }
}
