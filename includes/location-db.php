<?php
/**
 * State/city location SEO pages (/visa-consultant/{state}/ and
 * /visa-consultant/{state}/{city}/) — shares the same SQLite connection as
 * includes/visa-content-db.php (enquiry_db()) rather than a new database
 * file, matching the pattern already established there.
 *
 * Deliberately NOT a LocalBusiness-per-city generator: only Patna carries a
 * physical-office address (matches includes/schema.php's real Organization
 * address). Every other state/city page must describe service as
 * remote/online consultancy coverage, never a branch office, unless
 * is_hq is explicitly set true with a real verified address on file.
 */
require_once __DIR__ . '/visa-content-db.php';

function location_db(): PDO
{
    static $migrated = false;
    $pdo = enquiry_db();
    if ($migrated) {
        return $pdo;
    }

    $pdo->exec("CREATE TABLE IF NOT EXISTS states (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        slug TEXT UNIQUE NOT NULL,
        kind TEXT NOT NULL DEFAULT 'state',
        intro_html TEXT,
        service_model_html TEXT,
        seo_title TEXT,
        meta_description TEXT,
        status TEXT NOT NULL DEFAULT 'draft',
        sort_order INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS cities (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        state_id INTEGER NOT NULL REFERENCES states(id) ON DELETE CASCADE,
        name TEXT NOT NULL,
        slug TEXT NOT NULL,
        intro_html TEXT,
        local_notes_html TEXT,
        seo_title TEXT,
        meta_description TEXT,
        is_hq INTEGER NOT NULL DEFAULT 0,
        office_address TEXT,
        status TEXT NOT NULL DEFAULT 'draft',
        sort_order INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        UNIQUE(state_id, slug)
    )");

    $pdo->exec("CREATE TABLE IF NOT EXISTS location_faqs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        state_id INTEGER NOT NULL REFERENCES states(id) ON DELETE CASCADE,
        city_id INTEGER REFERENCES cities(id) ON DELETE CASCADE,
        question TEXT NOT NULL,
        answer_html TEXT NOT NULL,
        sort_order INTEGER NOT NULL DEFAULT 0
    )");

    location_seed_all($pdo);

    $migrated = true;
    return $pdo;
}

function location_state_url(string $stateSlug): string
{
    return 'visa-consultant/' . $stateSlug;
}

function location_city_url(string $stateSlug, string $citySlug): string
{
    return 'visa-consultant/' . $stateSlug . '/' . $citySlug;
}

/** FAQs attached directly to a state hub (city_id IS NULL). */
function location_state_faqs(PDO $pdo, int $stateId): array
{
    $stmt = $pdo->prepare('SELECT * FROM location_faqs WHERE state_id = ? AND city_id IS NULL ORDER BY sort_order, id');
    $stmt->execute([$stateId]);
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

function location_city_faqs(PDO $pdo, int $cityId): array
{
    $stmt = $pdo->prepare('SELECT * FROM location_faqs WHERE city_id = ? ORDER BY sort_order, id');
    $stmt->execute([$cityId]);
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

function location_cities_for_state(PDO $pdo, int $stateId): array
{
    $stmt = $pdo->prepare("SELECT * FROM cities WHERE state_id = ? AND status = 'published' ORDER BY sort_order, name");
    $stmt->execute([$stateId]);
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

/**
 * Idempotent seed from includes/location-seed-data.php — inserts a
 * state/city/FAQ only if its slug doesn't already exist, so re-running
 * this (it runs on every location_db() bootstrap) never clobbers a manual
 * edit made after the initial seed.
 */
function location_seed_all(PDO $pdo): void
{
    require_once __DIR__ . '/location-seed-data.php';
    require_once __DIR__ . '/location-seed-data-phase2.php';
    $now = gmdate('c');

    $allStateDefs = array_merge(location_seed_states_def(), location_seed_states_def_phase2());

    foreach ($allStateDefs as $stateDef) {
        $stmt = $pdo->prepare('SELECT id FROM states WHERE slug = ?');
        $stmt->execute([$stateDef['slug']]);
        $stateId = $stmt->fetchColumn();

        if (!$stateId) {
            $pdo->prepare('INSERT INTO states (name, slug, kind, intro_html, service_model_html, seo_title, meta_description, status, sort_order, created_at, updated_at)
                VALUES (:name, :slug, :kind, :intro_html, :service_model_html, :seo_title, :meta_description, :status, :sort_order, :now, :now)')
                ->execute([
                    'name' => $stateDef['name'],
                    'slug' => $stateDef['slug'],
                    'kind' => $stateDef['kind'] ?? 'state',
                    'intro_html' => $stateDef['intro_html'] ?? null,
                    'service_model_html' => $stateDef['service_model_html'] ?? null,
                    'seo_title' => $stateDef['seo_title'] ?? null,
                    'meta_description' => $stateDef['meta_description'] ?? null,
                    'status' => 'published',
                    'sort_order' => $stateDef['sort_order'] ?? 0,
                    'now' => $now,
                ]);
            $stateId = (int) $pdo->lastInsertId();

            foreach (($stateDef['faqs'] ?? []) as $i => $faq) {
                $pdo->prepare('INSERT INTO location_faqs (state_id, city_id, question, answer_html, sort_order) VALUES (?, NULL, ?, ?, ?)')
                    ->execute([$stateId, $faq['q'], $faq['a'], $i]);
            }
        }

        foreach (($stateDef['cities'] ?? []) as $cityDef) {
            $stmt = $pdo->prepare('SELECT id FROM cities WHERE state_id = ? AND slug = ?');
            $stmt->execute([$stateId, $cityDef['slug']]);
            if ($stmt->fetchColumn()) {
                continue;
            }

            $pdo->prepare('INSERT INTO cities (state_id, name, slug, intro_html, local_notes_html, seo_title, meta_description, is_hq, office_address, status, sort_order, created_at, updated_at)
                VALUES (:state_id, :name, :slug, :intro_html, :local_notes_html, :seo_title, :meta_description, :is_hq, :office_address, :status, :sort_order, :now, :now)')
                ->execute([
                    'state_id' => $stateId,
                    'name' => $cityDef['name'],
                    'slug' => $cityDef['slug'],
                    'intro_html' => $cityDef['intro_html'] ?? null,
                    'local_notes_html' => $cityDef['local_notes_html'] ?? null,
                    'seo_title' => $cityDef['seo_title'] ?? null,
                    'meta_description' => $cityDef['meta_description'] ?? null,
                    'is_hq' => !empty($cityDef['is_hq']) ? 1 : 0,
                    'office_address' => $cityDef['office_address'] ?? null,
                    'status' => 'published',
                    'sort_order' => $cityDef['sort_order'] ?? 0,
                    'now' => $now,
                ]);
            $cityId = (int) $pdo->lastInsertId();

            foreach (($cityDef['faqs'] ?? []) as $i => $faq) {
                $pdo->prepare('INSERT INTO location_faqs (state_id, city_id, question, answer_html, sort_order) VALUES (?, ?, ?, ?, ?)')
                    ->execute([$stateId, $cityId, $faq['q'], $faq['a'], $i]);
            }
        }
    }
}
