<?php
declare(strict_types=1);

function db(): PDO
{
    static $pdo = null;
    if ($pdo !== null) {
        return $pdo;
    }

    $dataDir = dirname(__DIR__) . '/data';
    if (!is_dir($dataDir)) {
        mkdir($dataDir, 0770, true);
        file_put_contents($dataDir . '/.htaccess', "Require all denied\n");
    }

    $dbFile = $dataDir . '/videshia.sqlite';
    $isNew = !file_exists($dbFile);

    $pdo = new PDO('sqlite:' . $dbFile);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    $pdo->exec('PRAGMA foreign_keys = ON');

    if ($isNew) {
        $pdo->exec(file_get_contents(dirname(__DIR__) . '/database/schema.sql'));
        require dirname(__DIR__) . '/database/seed.php';
        seed_database($pdo);
    }

    return $pdo;
}

function next_enquiry_reference(PDO $pdo): string
{
    $year = (int) date('Y');
    $pdo->beginTransaction();
    try {
        $stmt = $pdo->prepare('SELECT last_value FROM enquiry_counters WHERE year = ?');
        $stmt->execute([$year]);
        $row = $stmt->fetch();

        $next = ($row['last_value'] ?? 0) + 1;

        if ($row) {
            $pdo->prepare('UPDATE enquiry_counters SET last_value = ? WHERE year = ?')->execute([$next, $year]);
        } else {
            $pdo->prepare('INSERT INTO enquiry_counters (year, last_value) VALUES (?, ?)')->execute([$year, $next]);
        }
        $pdo->commit();
    } catch (Throwable $e) {
        $pdo->rollBack();
        throw $e;
    }

    return sprintf('TRP-%d-%06d', $year, $next);
}
