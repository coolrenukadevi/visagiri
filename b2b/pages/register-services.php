<?php
declare(strict_types=1);

/**
 * B2B Travel Partner Portal — Step 4: Visa Services + Preferred
 * Destination Countries. Countries come from the real countries
 * master (includes/data.php's countries_all()), grouped by region —
 * never a hard-coded list, so an admin adding a country elsewhere in
 * the CMS is automatically selectable here too.
 */

$partner = current_b2b_partner();

$countries = countries_all();
$countriesByRegion = [];
foreach ($countries as $country) {
    $region = $country['region'] ?? 'Other';
    $countriesByRegion[$region][] = $country;
}
ksort($countriesByRegion);

$selectedServices = db()->prepare('SELECT service_key FROM b2b_partner_services WHERE b2b_partner_id = :id');
$selectedServices->execute(['id' => $partner['id']]);
$oldServices = $selectedServices->fetchAll(PDO::FETCH_COLUMN);

$selectedCountries = db()->prepare('SELECT country_id FROM b2b_partner_countries WHERE b2b_partner_id = :id');
$selectedCountries->execute(['id' => $partner['id']]);
$oldCountryIds = array_map('intval', $selectedCountries->fetchAll(PDO::FETCH_COLUMN));

$errors = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();

    $postedServices = array_values(array_intersect((array) ($_POST['services'] ?? []), array_keys(B2B_VISA_SERVICES)));
    $validCountryIds = array_column($countries, 'id');
    $postedCountryIds = array_values(array_intersect(array_map('intval', (array) ($_POST['countries'] ?? [])), $validCountryIds));

    if (!$postedServices) {
        $errors[] = 'Select at least one visa service you are interested in.';
    }

    if (!$errors) {
        $pdo = db();
        $pdo->beginTransaction();
        try {
            $pdo->prepare('DELETE FROM b2b_partner_services WHERE b2b_partner_id = :id')->execute(['id' => $partner['id']]);
            $insertService = $pdo->prepare('INSERT INTO b2b_partner_services (b2b_partner_id, service_key) VALUES (:id, :key)');
            foreach ($postedServices as $key) {
                $insertService->execute(['id' => $partner['id'], 'key' => $key]);
            }

            $pdo->prepare('DELETE FROM b2b_partner_countries WHERE b2b_partner_id = :id')->execute(['id' => $partner['id']]);
            $insertCountry = $pdo->prepare('INSERT INTO b2b_partner_countries (b2b_partner_id, country_id) VALUES (:id, :country_id)');
            foreach ($postedCountryIds as $countryId) {
                $insertCountry->execute(['id' => $partner['id'], 'country_id' => $countryId]);
            }
            $pdo->commit();
        } catch (Throwable $e) {
            $pdo->rollBack();
            if (APP_DEBUG) {
                error_log('[b2b register-services] failed: ' . $e->getMessage());
            }
            $errors[] = 'Something went wrong saving your selections. Please try again.';
        }

        if (!$errors) {
            redirect('/b2b/register-billing/');
        }
    }

    $oldServices = $postedServices;
    $oldCountryIds = $postedCountryIds;
}

$pageTitle = 'Become a B2B Travel Partner - Step 4 - Visagiri';
$canonicalUrl = APP_URL . '/b2b/register-services/';
$noindex = true;
require __DIR__ . '/../../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:760px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">B2B Travel Partner Portal</span>
            <h1>Become a Travel Partner</h1>
        </div>
        <?php render_b2b_enrollment_steps(4); ?>
        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>
        <form method="post" action="/b2b/register-services/" class="card" style="padding:var(--space-6)">
            <?= csrf_field() ?>
            <h2 style="margin-top:0">Which visa services are you interested in?</h2>
            <div class="checkbox-grid" style="display:grid;grid-template-columns:repeat(auto-fill,minmax(200px,1fr));gap:var(--space-2)">
                <?php foreach (B2B_VISA_SERVICES as $key => $label): ?>
                <label style="display:flex;align-items:center;gap:var(--space-2);font-weight:var(--font-weight-regular)">
                    <input type="checkbox" name="services[]" value="<?= e($key) ?>"<?= in_array($key, $oldServices, true) ? ' checked' : '' ?>>
                    <?= e($label) ?>
                </label>
                <?php endforeach; ?>
            </div>

            <h2 style="margin-top:var(--space-6)">Preferred Destination Countries</h2>
            <p style="color:var(--text-muted);font-size:var(--font-size-sm)">Select the countries you most commonly need visa services for. Optional — you can update this any time.</p>
            <input class="form-input" type="search" id="country-filter" placeholder="Search countries…" style="margin-bottom:var(--space-3)">
            <div id="country-groups" style="max-height:360px;overflow-y:auto;border:1px solid var(--border);border-radius:var(--radius-md);padding:var(--space-4)">
                <?php foreach ($countriesByRegion as $region => $regionCountries): ?>
                <div class="country-group" data-region-group>
                    <strong><?= e($region) ?></strong>
                    <div style="display:grid;grid-template-columns:repeat(auto-fill,minmax(180px,1fr));gap:var(--space-1);margin:var(--space-2) 0 var(--space-4)">
                        <?php foreach ($regionCountries as $country): ?>
                        <label data-country-label style="display:flex;align-items:center;gap:var(--space-2);font-weight:var(--font-weight-regular);font-size:var(--font-size-sm)">
                            <input type="checkbox" name="countries[]" value="<?= (int) $country['id'] ?>"<?= in_array((int) $country['id'], $oldCountryIds, true) ? ' checked' : '' ?>>
                            <?= e($country['name']) ?>
                        </label>
                        <?php endforeach; ?>
                    </div>
                </div>
                <?php endforeach; ?>
            </div>

            <button type="submit" class="btn btn-primary" style="width:100%;margin-top:var(--space-5)">Continue &rarr;</button>
        </form>
    </div>
</section>
<script src="<?= e(asset_url('/assets/js/b2b-country-filter.js')) ?>"></script>
<?php require __DIR__ . '/../../includes/footer.php'; ?>
