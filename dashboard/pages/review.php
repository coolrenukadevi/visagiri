<?php
declare(strict_types=1);

$customer = current_customer();
$existingTestimonial = fetch_customer_testimonial((int) $customer['id']);
$errors = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();

    $rating = (int) ($_POST['rating'] ?? 0);
    $quote = trim((string) ($_POST['quote'] ?? ''));

    if ($rating < 1 || $rating > 5) {
        $errors[] = 'Please choose a star rating.';
    }
    if ($quote === '') {
        $errors[] = 'Please write a few words about your experience.';
    } elseif (mb_strlen($quote) > 800) {
        $errors[] = 'Please keep your review under 800 characters.';
    }

    $photoPath = null;
    $photoError = validate_testimonial_photo_upload($_FILES['photo'] ?? []);
    if ($photoError !== null) {
        $errors[] = $photoError;
    }

    if (!$errors) {
        if (($_FILES['photo']['error'] ?? UPLOAD_ERR_NO_FILE) === UPLOAD_ERR_OK) {
            $photoPath = store_testimonial_photo_upload($_FILES['photo']);
        }

        $customerName = trim($customer['first_name'] . ' ' . ($customer['last_name'] ?? ''));
        $customerLocation = $customer['city'] ?: null;

        save_customer_testimonial((int) $customer['id'], $customerName, $customerLocation, $rating, $quote, $photoPath);
        flash_set('notice', $existingTestimonial ? 'Your review has been updated.' : 'Thanks — your review is now live on our site.');
        redirect('/dashboard/review/');
    }
}

render_dashboard_start('review', 'My Review');
?>
<p style="color:var(--text-muted);margin-top:calc(-1 * var(--space-4));margin-bottom:var(--space-6)">Share your experience with Visagiri — it appears publicly using your account name and city.</p>

<?php foreach ($errors as $error): ?><div class="alert alert-danger"><?= e($error) ?></div><?php endforeach; ?>

<form method="post" action="/dashboard/review/" enctype="multipart/form-data" class="card" style="padding:var(--space-6);max-width:520px">
    <?= csrf_field() ?>

    <div class="form-group">
        <label class="form-label">Your Rating</label>
        <div class="button-group" role="radiogroup" aria-label="Star rating">
            <?php for ($i = 5; $i >= 1; $i--): ?>
            <label style="display:inline-flex;align-items:center;gap:4px;font-weight:var(--font-weight-medium)">
                <input type="radio" name="rating" value="<?= $i ?>" <?= ((int) ($existingTestimonial['rating'] ?? 5)) === $i ? 'checked' : '' ?> required>
                <?= $i ?>&#9733;
            </label>
            <?php endfor; ?>
        </div>
    </div>

    <div class="form-group">
        <label class="form-label" for="quote">Your Review</label>
        <textarea class="form-input" id="quote" name="quote" rows="5" maxlength="800" required placeholder="Tell us about your experience with Visagiri..."><?= e($existingTestimonial['quote'] ?? '') ?></textarea>
    </div>

    <div class="form-group">
        <label class="form-label" for="photo">Your Photo (optional)</label>
        <?php if (!empty($existingTestimonial['photo_path'])): ?>
        <img src="<?= e($existingTestimonial['photo_path']) ?>" alt="" width="64" height="64" style="border-radius:50%;display:block;margin-bottom:var(--space-2)">
        <span class="form-hint">Leave blank to keep your current photo.</span>
        <?php endif; ?>
        <input type="file" id="photo" name="photo" accept=".jpg,.jpeg,.png">
        <span class="form-hint">JPG or PNG, up to 3MB.</span>
    </div>

    <div class="form-group" style="background:var(--background);padding:var(--space-3);border-radius:var(--radius-md);font-size:var(--font-size-sm);color:var(--text-muted)">
        Will be shown publicly as: <strong><?= e(trim($customer['first_name'] . ' ' . ($customer['last_name'] ?? ''))) ?></strong><?php if (!empty($customer['city'])): ?>, <?= e($customer['city']) ?><?php endif; ?>
    </div>

    <button type="submit" class="btn btn-gold"><?= $existingTestimonial ? 'Update My Review' : 'Publish My Review' ?></button>
</form>
<?php render_dashboard_end(); ?>
