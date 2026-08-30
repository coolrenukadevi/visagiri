<?php
/**
 * /employee/enquiry/{code} — the employee-side workspace for one enquiry:
 * assignment, status, document verification and internal notes.
 *
 * Any signed-in employee can open and act on any enquiry — there is no
 * per-role restriction yet. That's a deliberate scope boundary, not an
 * oversight: role-based access is exactly what Phase 8 (Admin & compliance
 * configuration) is for, and a small internal ops team does not need it
 * enforced in code to function honestly today. What IS enforced here is the
 * same non-fabrication rule as everywhere else — every figure and status
 * shown is read straight from a real column, nothing is invented for
 * display.
 *
 * Visa/forex trip details are shown read-only. Editing what the customer
 * submitted is the customer's action, not the consultant's — a consultant
 * who spots wrong data adds an internal note or calls the customer, they
 * don't silently overwrite the submission.
 */
declare(strict_types=1);

require_once __DIR__ . '/includes/config.php';
require_once __DIR__ . '/includes/partials.php';
require_once __DIR__ . '/lib-php/auth.php';
require_once __DIR__ . '/lib-php/employee_auth.php';
require_once __DIR__ . '/lib-php/customer_auth.php';
require_once __DIR__ . '/lib-php/enquiries.php';
require_once __DIR__ . '/lib-php/visa_enquiries.php';
require_once __DIR__ . '/lib-php/forex_enquiries.php';
require_once __DIR__ . '/lib-php/documents.php';
require_once __DIR__ . '/lib-php/compliance.php';

header('Cache-Control: no-store, private');
auth_session_start();

$code = trim((string) ($_GET['code'] ?? ''));
$employee = employee_current();
if (!$employee) {
    header('Location: ' . url('/employee-login') . '?next=' . rawurlencode(auth_safe_next('/employee/enquiry/' . $code)), true, 302);
    exit;
}
$myName = (string) $employee['full_name'];

$enquiry = $code !== '' ? enquiry_find_by_code($code) : null;
if (!$enquiry) {
    http_response_code(404);
    require __DIR__ . '/404.php';
    exit;
}
$customer = customer_find((int) $enquiry['customer_id']);
$isVisa = $enquiry['service_code'] === 'visa';
$isForex = $enquiry['service_code'] === 'forex';

$actionMsg = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $csrfOk = auth_csrf_valid($_POST['csrf'] ?? null);
    $action = (string) ($_POST['action'] ?? '');

    if (!$csrfOk) {
        $actionMsg = 'Your session expired — please try again.';
    } elseif ($action === 'assign_to_me') {
        enquiry_assign((int) $enquiry['id'], $myName, (string) $employee['role']);
        $enquiry['assigned_employee'] = $myName;
        $enquiry['assigned_department'] = $employee['role'];
        $actionMsg = 'Assigned to you.';
    } elseif ($action === 'unassign') {
        enquiry_unassign((int) $enquiry['id']);
        $enquiry['assigned_employee'] = null;
        $enquiry['assigned_department'] = null;
        $actionMsg = 'Unassigned.';
    } elseif ($action === 'set_status') {
        $status = (string) ($_POST['status'] ?? '');
        $note = trim((string) ($_POST['status_note'] ?? ''));
        if (enquiry_set_status((int) $enquiry['id'], $status, $myName, $note)) {
            $enquiry['status'] = $status;
            $actionMsg = 'Status updated.';
        } else {
            $actionMsg = 'Could not update status — choose a valid status.';
        }
    } elseif ($action === 'add_internal_note') {
        $note = trim((string) ($_POST['internal_note'] ?? ''));
        if (strlen($note) > 2000) {
            $actionMsg = 'Note is too long (2000 characters max).';
        } elseif (internal_note_add((int) $enquiry['id'], $myName, $note)) {
            $actionMsg = 'Note added.';
        } else {
            $actionMsg = 'Note can\'t be empty.';
        }
    } elseif ($action === 'set_document_status') {
        $uid = (string) ($_POST['document_uid'] ?? '');
        $doc = $uid !== '' ? document_find_by_uid($uid) : null;
        $status = (string) ($_POST['doc_status'] ?? '');
        $reason = (string) ($_POST['reason'] ?? '');
        if (!$doc || (int) $doc['enquiry_id'] !== (int) $enquiry['id']) {
            $actionMsg = 'That document could not be found on this enquiry.';
        } elseif (!document_set_status($doc, $status, $reason)) {
            $actionMsg = 'Choose a status, and a reason for anything other than Accepted.';
        } else {
            $actionMsg = 'Document ' . strtolower($status) . '.';
        }
    }
}

$visaDetails = $isVisa ? (visa_enquiry_for((int) $enquiry['id']) ?? []) : [];
$forexDetails = $isForex ? (forex_enquiry_for((int) $enquiry['id']) ?? []) : [];
$documents = documents_for_enquiry((int) $enquiry['id']);
$forexChecklist = $isForex ? forex_checklist_status($documents) : [];
$forexTransaction = $isForex ? forex_transaction_ensure((int) $enquiry['id']) : null;
$forexReadyForDelivery = $isForex ? forex_ready_for_delivery($forexChecklist, $documents) : false;
$history = enquiry_status_history_for((int) $enquiry['id']);
$internalNotes = internal_notes_for((int) $enquiry['id']);

$statusLabels = ['New' => 'Received', 'In Progress' => 'In Progress', 'Completed' => 'Completed', 'Cancelled' => 'Cancelled'];
$statusLabel = $statusLabels[$enquiry['status']] ?? $enquiry['status'];

/** A read-only [label, value] grid — visa/forex detail display below. */
$detailGrid = static function (array $pairs): void { ?>
  <div class="enq-detail-grid">
    <?php foreach ($pairs as [$label, $value]): ?>
    <div><span class="enq-detail-label"><?= e($label) ?></span><span><?= $value !== '' ? e($value) : '—' ?></span></div>
    <?php endforeach; ?>
  </div>
<?php };

$crumb = [['label' => 'Home', 'href' => url('/')], ['label' => 'Employee Console', 'href' => url('/employee')], ['label' => $enquiry['enquiry_code']]];
$page = [
    'title'       => $enquiry['enquiry_code'] . ' | Employee Console | Convercession',
    'short_title' => $enquiry['enquiry_code'],
    'description' => 'Employee workspace for a Convercession enquiry.',
    'path'        => '/employee/enquiry/' . $enquiry['enquiry_code'],
    'noindex'     => true,
    'jsonld'      => [],
];
?><!DOCTYPE html>
<html lang="en">
<head><?php include __DIR__ . '/includes/head.php'; ?></head>
<body>
<?php include __DIR__ . '/includes/header.php'; ?>

<main>
  <section class="section auth-section">
    <div class="container"><?= breadcrumbs($crumb) ?></div>
    <div class="container">
      <div class="auth-card auth-card-wide">
        <?php if ($actionMsg !== ''): ?><p class="notice-inline"><?= e($actionMsg) ?></p><?php endif; ?>

        <div class="enq-detail-head">
          <div>
            <span class="mono enq-detail-code"><?= e($enquiry['enquiry_code']) ?></span>
            <h1><?= e($enquiry['service_label']) ?> — <?= e($enquiry['country']) ?></h1>
          </div>
          <span class="enq-status-badge status-<?= e(strtolower(str_replace(' ', '-', $enquiry['status']))) ?>"><?= e($statusLabel) ?></span>
        </div>

        <?php $detailGrid([
          ['Customer', $customer ? $customer['full_name'] . ' (' . $customer['customer_code'] . ')' : 'Unknown'],
          ['Customer Contact', $customer ? $customer['mobile'] . ' · ' . $customer['email'] : ''],
          ['Travel Purpose', $enquiry['travel_purpose']],
          ['Preferred Travel Date', $enquiry['travel_date'] ? date('j F Y', strtotime($enquiry['travel_date'])) : ''],
          ['Submitted', date('j F Y, g:i a', (int) $enquiry['created_at'])],
          ['Assigned To', $enquiry['assigned_employee'] ? $enquiry['assigned_employee'] . ($enquiry['assigned_department'] ? ' (' . $enquiry['assigned_department'] . ')' : '') : ''],
        ]); ?>

        <?php if ($enquiry['message']): ?>
        <div class="enq-detail-message"><span class="enq-detail-label">Customer's message</span><p><?= nl2br(e($enquiry['message'])) ?></p></div>
        <?php endif; ?>
        <?php if ($enquiry['customer_notes']): ?>
        <div class="enq-detail-message"><span class="enq-detail-label">Customer's notes</span><p><?= nl2br(e($enquiry['customer_notes'])) ?></p></div>
        <?php endif; ?>

        <div class="wizard-actions" style="margin-top:18px">
          <span></span>
          <?php if ($enquiry['assigned_employee'] === $myName): ?>
          <form method="post" action="<?= url('/employee/enquiry/' . $enquiry['enquiry_code']) ?>">
            <input type="hidden" name="csrf" value="<?= e(auth_csrf_token()) ?>">
            <input type="hidden" name="action" value="unassign">
            <button type="submit" class="btn btn-outline-brand btn-sm">Unassign from me</button>
          </form>
          <?php else: ?>
          <form method="post" action="<?= url('/employee/enquiry/' . $enquiry['enquiry_code']) ?>">
            <input type="hidden" name="csrf" value="<?= e(auth_csrf_token()) ?>">
            <input type="hidden" name="action" value="assign_to_me">
            <button type="submit" class="btn btn-primary btn-sm"><?= $enquiry['assigned_employee'] ? 'Reassign to me' : 'Assign to me' ?></button>
          </form>
          <?php endif; ?>
        </div>

        <h2 class="account-section-title" style="margin-top:32px">Status</h2>
        <form method="post" action="<?= url('/employee/enquiry/' . $enquiry['enquiry_code']) ?>" class="enquiry-grid">
          <input type="hidden" name="csrf" value="<?= e(auth_csrf_token()) ?>">
          <input type="hidden" name="action" value="set_status">
          <div class="enquiry-field">
            <label for="status">New status</label>
            <select id="status" name="status">
              <?php foreach (ENQUIRY_STATUSES as $s): ?>
              <option value="<?= e($s) ?>" <?= $enquiry['status'] === $s ? 'selected' : '' ?>><?= e($s) ?></option>
              <?php endforeach; ?>
            </select>
          </div>
          <div class="enquiry-field full"><label for="status_note">Note (appears on the customer's status timeline)</label><input type="text" id="status_note" name="status_note" maxlength="300" placeholder="Optional"></div>
          <div class="wizard-actions" style="grid-column:1/-1"><span></span><button type="submit" class="btn btn-primary btn-sm">Update status</button></div>
        </form>

        <?php if ($isVisa): ?>
        <h2 class="account-section-title" style="margin-top:32px">Visa Details <span class="auth-note" style="display:inline">(read-only — submitted by the customer)</span></h2>
        <?php $detailGrid([
          ['Applicant Name', $visaDetails['applicant_name'] ?? ''],
          ['Passport Number', $visaDetails['passport_number'] ?? ''],
          ['Country of Residence', $visaDetails['country_of_residence'] ?? ''],
          ['Destination City', $visaDetails['destination_city'] ?? ''],
          ['Visa Type', $visaDetails['visa_type'] ?? ''],
          ['Expected Return Date', $visaDetails['expected_return_date'] ?? ''],
          ['Number of Travellers', (string) ($visaDetails['traveller_count'] ?? '')],
          ['Applicant Type', $visaDetails['applicant_type'] ?? ''],
          ['Previous Visa Refusal?', empty($visaDetails) ? '' : (!empty($visaDetails['previous_refusal']) ? 'Yes' : 'No')],
          ['Current Visa Status', $visaDetails['current_visa_status'] ?? ''],
          ['Previous Visa History', $visaDetails['previous_visa_history'] ?? ''],
        ]); ?>
        <?php endif; ?>

        <?php if ($isForex): ?>
        <h2 class="account-section-title" style="margin-top:32px">Forex Details <span class="auth-note" style="display:inline">(read-only — submitted by the customer)</span></h2>
        <?php $detailGrid([
          ['PAN Number', $forexDetails['pan_number'] ?? ''],
          ['Passport Number', $forexDetails['passport_number'] ?? ''],
          ['Nationality', $forexDetails['nationality'] ?? ''],
          ['Residential Address', $forexDetails['residential_address'] ?? ''],
          ['City of Visit', $forexDetails['city_of_visit'] ?? ''],
          ['Departure City', $forexDetails['departure_city'] ?? ''],
          ['Travel Dates', ($forexDetails['travel_start_date'] ?? '') ? $forexDetails['travel_start_date'] . ' to ' . $forexDetails['travel_end_date'] : ''],
          ['Forex Type', $forexDetails['forex_type'] ?? ''],
          ['Currency', isset($forexDetails['currency_code']) && $forexDetails['currency_code'] !== '' ? $forexDetails['currency_code'] . ' — ' . (FOREX_CURRENCIES[$forexDetails['currency_code']] ?? '') : ''],
          ['Amount Required', isset($forexDetails['amount_required']) ? number_format((float) $forexDetails['amount_required'], 2) : ''],
          ['Approx. INR Value', isset($forexDetails['approx_inr_value']) ? number_format((float) $forexDetails['approx_inr_value'], 2) : ''],
          ['Delivery Method', $forexDetails['delivery_method'] ?? ''],
        ]); ?>

        <h2 class="account-section-title" style="margin-top:32px">Forex Document Checklist</h2>
        <div class="forex-checklist">
          <?php foreach ($forexChecklist as $item): ?>
          <div class="forex-checklist-item <?= $item['uploaded'] ? 'is-done' : '' ?>">
            <span class="forex-checklist-check"><?= $item['uploaded'] ? '&check;' : '' ?></span>
            <span class="forex-checklist-label"><?= e($item['label']) ?></span>
            <span class="forex-checklist-tag <?= $item['mandatory'] ? 'is-mandatory' : 'is-conditional' ?>"><?= $item['mandatory'] ? 'Mandatory' : 'Conditional' ?></span>
          </div>
          <?php endforeach; ?>
        </div>

        <h2 class="account-section-title" style="margin-top:32px">Delivery Pipeline</h2>
        <div class="forex-pipeline">
          <?php foreach (FOREX_PIPELINE_STAGES as $i => $stage): $reached = $stage === $forexTransaction['stage']; $done = array_search($forexTransaction['stage'], FOREX_PIPELINE_STAGES, true) > $i; ?>
          <div class="forex-pipeline-stage <?= $done ? 'is-done' : ($reached ? 'is-current' : '') ?>">
            <span class="forex-pipeline-dot"></span><span><?= e($stage) ?></span>
          </div>
          <?php endforeach; ?>
        </div>
        <?php if (!$forexReadyForDelivery): ?>
        <p class="doc-passport-status is-missing" style="margin-top:14px">&#128274; Locked until every mandatory checklist item above is uploaded <strong>and Accepted</strong> below.</p>
        <?php else: ?>
        <p class="doc-passport-status is-ok" style="margin-top:14px">&check; All documents accepted — this transaction can move to Ready for Delivery. (Moving it forward is a Phase 8+ operator action; nothing here does that automatically.)</p>
        <?php endif; ?>
        <?php endif; ?>

        <h2 class="account-section-title" style="margin-top:32px" id="documents">Documents</h2>
        <?php if (!$documents): ?>
        <p class="account-empty">No documents uploaded yet.</p>
        <?php endif; ?>
        <div class="doc-list">
          <?php foreach ($documents as $doc): ?>
          <div class="doc-item" style="flex-wrap:wrap">
            <div class="doc-item-main">
              <a href="<?= url('/document?uid=' . $doc['document_uid']) ?>" target="_blank" rel="noopener"><?= e($doc['original_filename']) ?></a>
              <span class="doc-item-meta"><?= e($doc['type_label']) ?> &middot; <?= number_format($doc['size_bytes'] / 1024, 0) ?> KB &middot; uploaded <?= e(date('j M Y', (int) $doc['uploaded_at'])) ?></span>
              <?php if ($doc['rejection_reason']): ?><p class="doc-item-reason">Reason on file: <?= e($doc['rejection_reason']) ?></p><?php endif; ?>
            </div>
            <span class="enq-status-badge status-<?= e(strtolower(str_replace(' ', '-', $doc['status']))) ?>"><?= e($doc['status']) ?></span>
            <form method="post" action="<?= url('/employee/enquiry/' . $enquiry['enquiry_code']) ?>#documents" class="emp-doc-verify">
              <input type="hidden" name="csrf" value="<?= e(auth_csrf_token()) ?>">
              <input type="hidden" name="action" value="set_document_status">
              <input type="hidden" name="document_uid" value="<?= e($doc['document_uid']) ?>">
              <select name="doc_status" aria-label="Set status for <?= e($doc['original_filename']) ?>">
                <?php foreach (DOCUMENT_VERIFICATION_STATUSES as $ds): ?>
                <option value="<?= e($ds) ?>" <?= $doc['status'] === $ds ? 'selected' : '' ?>><?= e($ds) ?></option>
                <?php endforeach; ?>
              </select>
              <input type="text" name="reason" maxlength="300" placeholder="Reason (required unless Accepted)" value="<?= $doc['status'] !== 'Accepted' ? e($doc['rejection_reason']) : '' ?>">
              <button type="submit" class="btn btn-outline-brand btn-sm">Update</button>
            </form>
          </div>
          <?php endforeach; ?>
        </div>

        <h2 class="account-section-title" style="margin-top:32px">Status Timeline <span class="auth-note" style="display:inline">(customer sees this too)</span></h2>
        <div class="enq-timeline">
          <?php foreach ($history as $h): ?>
          <div class="enq-tl-item"><span class="enq-tl-dot"></span>
            <div class="enq-tl-body"><b><?= e($h['status']) ?></b><?= $h['note'] ? '<p>' . e($h['note']) . '</p>' : '' ?><span><?= e(date('j M Y, g:i a', (int) $h['created_at'])) ?></span></div>
          </div>
          <?php endforeach; ?>
        </div>

        <h2 class="account-section-title" style="margin-top:32px">Internal Notes <span class="auth-note" style="display:inline">(staff only — never shown to the customer)</span></h2>
        <form method="post" action="<?= url('/employee/enquiry/' . $enquiry['enquiry_code']) ?>">
          <input type="hidden" name="csrf" value="<?= e(auth_csrf_token()) ?>">
          <input type="hidden" name="action" value="add_internal_note">
          <div class="field"><textarea name="internal_note" rows="2" placeholder="Add a note for the team…" required></textarea></div>
          <button type="submit" class="btn btn-sm btn-outline-brand" style="margin-top:10px">Add note</button>
        </form>
        <?php if ($internalNotes): ?>
        <div class="enq-timeline" style="margin-top:18px">
          <?php foreach ($internalNotes as $n): ?>
          <div class="enq-tl-item"><span class="enq-tl-dot"></span>
            <div class="enq-tl-body"><b><?= e($n['employee_name']) ?></b><p><?= nl2br(e($n['note'])) ?></p><span><?= e(date('j M Y, g:i a', (int) $n['created_at'])) ?></span></div>
          </div>
          <?php endforeach; ?>
        </div>
        <?php endif; ?>

        <p class="auth-note account-note-wide" style="margin-top:28px">
          <a href="<?= url('/employee') ?>">&larr; Back to Employee Console</a>
        </p>
      </div>
    </div>
  </section>
</main>

<?php include __DIR__ . '/includes/footer.php'; ?>
</body>
</html>
