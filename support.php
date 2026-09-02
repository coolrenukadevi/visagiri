<?php
/**
 * /support — a customer's support tickets: list + raise a new one.
 *
 * Separate feature from enquiries.php on purpose (see lib-php/support.php's
 * docblock) — a complaint or query is not the same object as a visa/forex
 * enquiry, even though one can optionally point at the other.
 */
declare(strict_types=1);

require_once __DIR__ . '/includes/config.php';
require_once __DIR__ . '/includes/partials.php';
require_once __DIR__ . '/lib-php/auth.php';
require_once __DIR__ . '/lib-php/customer_auth.php';
require_once __DIR__ . '/lib-php/enquiries.php';
require_once __DIR__ . '/lib-php/support.php';

header('Cache-Control: no-store, private');
auth_session_start();

$customer = customer_current();
if (!$customer) {
    header('Location: ' . url('/customer-login') . '?next=' . rawurlencode(auth_safe_next('/support')), true, 302);
    exit;
}

$errors = [];
$preselectEnquiry = trim((string) ($_GET['enquiry'] ?? ''));

if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? '') === 'create_ticket') {
    if (!auth_csrf_valid($_POST['csrf'] ?? null)) {
        $errors['form'] = 'Your session expired — please try again.';
    } else {
        $subject = trim((string) ($_POST['subject'] ?? ''));
        $category = (string) ($_POST['category'] ?? '');
        $message = trim((string) ($_POST['message'] ?? ''));
        $enquiryCode = trim((string) ($_POST['enquiry_code'] ?? ''));

        if ($subject === '' || strlen($subject) > 200) $errors['subject'] = 'Enter a subject (up to 200 characters).';
        if (!in_array($category, TICKET_CATEGORIES, true)) $errors['category'] = 'Choose a category.';
        if ($message === '' || strlen($message) > 2000) $errors['message'] = 'Tell us what\'s going on (up to 2000 characters).';

        $enquiryId = null;
        if ($enquiryCode !== '') {
            $linkedEnquiry = enquiry_find_by_code($enquiryCode);
            if (!$linkedEnquiry || (int) $linkedEnquiry['customer_id'] !== (int) $customer['id']) {
                $errors['enquiry_code'] = 'That enquiry could not be found on your account.';
            } else {
                $enquiryId = (int) $linkedEnquiry['id'];
            }
        }

        if (!$errors) {
            [$id, $error, $code] = ticket_create((int) $customer['id'], (string) $customer['full_name'], [
                'subject' => $subject, 'category' => $category, 'message' => $message, 'enquiry_id' => $enquiryId,
            ]);
            if ($id !== null) {
                header('Location: ' . url('/support/' . $code), true, 302);
                exit;
            }
            $errors['form'] = $error;
        }
    }
    $preselectEnquiry = $enquiryCode ?? '';
}

$tickets = tickets_for_customer((int) $customer['id']);
$myEnquiries = enquiries_for_customer((int) $customer['id']);

$crumb = [['label' => 'Home', 'href' => url('/')], ['label' => 'My account', 'href' => url('/account')], ['label' => 'Support']];
$page = [
    'title'       => 'Support Tickets | Convercession',
    'short_title' => 'Support',
    'description' => 'Raise and track support tickets with your Convercession account.',
    'path'        => '/support',
    'noindex'     => true,
    'jsonld'      => [breadcrumb_schema($crumb)],
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
        <div class="auth-head">
          <h1>Support Tickets</h1>
          <p>Raise a complaint or query and track it here — every reply from our team shows up in the same thread.</p>
        </div>

        <h2 class="account-section-title">Your Tickets</h2>
        <?php if ($tickets): ?>
        <div class="enquiry-card-row">
          <?php foreach ($tickets as $t): ?>
          <a class="enquiry-card" href="<?= url('/support/' . $t['ticket_code']) ?>">
            <div class="enquiry-card-main">
              <span class="enquiry-card-code"><?= e($t['ticket_code']) ?></span>
              <div class="enquiry-card-title"><?= e($t['subject']) ?></div>
              <div class="enquiry-card-meta"><?= e($t['category']) ?> &middot; Raised <?= e(date('j M Y', (int) $t['created_at'])) ?></div>
            </div>
            <span class="enq-status-badge status-<?= e(strtolower(str_replace(' ', '-', $t['status']))) ?>"><?= e($t['status']) ?></span>
          </a>
          <?php endforeach; ?>
        </div>
        <?php else: ?>
        <div class="enquiries-panel"><div class="enquiries-empty">
          <h3>No tickets yet</h3>
          <p>If something isn't right with an enquiry, or you have a question our consultants haven't answered, raise a ticket below.</p>
        </div></div>
        <?php endif; ?>

        <h2 class="account-section-title" style="margin-top:32px">Raise a New Ticket</h2>
        <?php if (isset($errors['form'])): ?><p class="auth-error" role="alert"><?= e($errors['form']) ?></p><?php endif; ?>
        <form method="post" action="<?= url('/support') ?>" class="enquiry-grid">
          <input type="hidden" name="csrf" value="<?= e(auth_csrf_token()) ?>">
          <input type="hidden" name="action" value="create_ticket">
          <div class="enquiry-field full"><label for="subject">Subject *</label><input type="text" id="subject" name="subject" maxlength="200" value="<?= e((string) ($_POST['subject'] ?? '')) ?>" required>
            <?php if (isset($errors['subject'])): ?><span class="field-error"><?= e($errors['subject']) ?></span><?php endif; ?>
          </div>
          <div class="enquiry-field"><label for="category">Category *</label>
            <select id="category" name="category" required>
              <option value="">Select&hellip;</option>
              <?php foreach (TICKET_CATEGORIES as $cat): ?><option value="<?= e($cat) ?>" <?= ($_POST['category'] ?? '') === $cat ? 'selected' : '' ?>><?= e($cat) ?></option><?php endforeach; ?>
            </select>
            <?php if (isset($errors['category'])): ?><span class="field-error"><?= e($errors['category']) ?></span><?php endif; ?>
          </div>
          <div class="enquiry-field"><label for="enquiry_code">Related Enquiry</label>
            <select id="enquiry_code" name="enquiry_code">
              <option value="">None &mdash; general query</option>
              <?php foreach ($myEnquiries as $enq): ?><option value="<?= e($enq['enquiry_code']) ?>" <?= $preselectEnquiry === $enq['enquiry_code'] ? 'selected' : '' ?>><?= e($enq['enquiry_code'] . ' — ' . $enq['service_label'] . ' — ' . $enq['country']) ?></option><?php endforeach; ?>
            </select>
            <?php if (isset($errors['enquiry_code'])): ?><span class="field-error"><?= e($errors['enquiry_code']) ?></span><?php endif; ?>
          </div>
          <div class="enquiry-field full"><label for="message">Tell us what's going on *</label><textarea id="message" name="message" rows="4" maxlength="2000" required><?= e((string) ($_POST['message'] ?? '')) ?></textarea>
            <?php if (isset($errors['message'])): ?><span class="field-error"><?= e($errors['message']) ?></span><?php endif; ?>
          </div>
          <div class="wizard-actions" style="grid-column:1/-1"><span></span><button type="submit" class="btn btn-primary btn-sm">Submit ticket</button></div>
        </form>

        <p class="auth-note account-note-wide" style="margin-top:28px">
          <a href="<?= url('/account') ?>">&larr; Back to My Account</a>
        </p>
      </div>
    </div>
  </section>
</main>

<?php include __DIR__ . '/includes/footer.php'; ?>
</body>
</html>
