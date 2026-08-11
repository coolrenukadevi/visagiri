<?php
declare(strict_types=1);

/** POST /consultant/documents/{id}/approve/ — $id set by consultant/index.php. */

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    redirect('/consultant/documents/');
}

csrf_require();

$consultant = current_user();
$pdo = db();
$doc = fetch_application_document_for_consultant($pdo, $id, $consultant['id']);

if (!$doc) {
    render_not_found("We couldn't find that document.");
}

$backTo = filter_var($_POST['redirect_to'] ?? '', FILTER_VALIDATE_REGEXP, ['options' => ['regexp' => '#^/consultant/#']])
    ?: '/consultant/documents/';

if (!$doc['stored_filename'] || !in_array($doc['status'], ['uploaded', 'under_review'], true)) {
    flash_set('notice', 'This document is not awaiting review.');
    redirect($backTo);
}

mark_document_approved($pdo, $doc['id'], $consultant['id']);

flash_set('notice', "{$doc['document_name']} approved.");
redirect($backTo);
