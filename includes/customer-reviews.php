<?php
declare(strict_types=1);

/**
 * Lets a logged-in customer submit their own testimonial — name and
 * city come from their real account (current_customer()), never
 * free-text, so a review can't be attributed to a name the submitter
 * doesn't actually hold. See dashboard/pages/review.php for the form
 * and database/schema-testimonials-customer-submission.sql for the
 * schema this builds on.
 *
 * Photos are stored under public/assets/uploads/reviews/ — a PUBLIC,
 * web-servable directory, deliberately separate from
 * storage/documents/ (private visa paperwork; see includes/documents.php).
 * A review photo is meant to be seen by every site visitor, so it does
 * not belong in the private documents pipeline.
 */

const TESTIMONIAL_PHOTO_DIR = __DIR__ . '/../public/assets/uploads/reviews';
const TESTIMONIAL_PHOTO_PUBLIC_PATH = '/assets/uploads/reviews';
const TESTIMONIAL_PHOTO_MAX_BYTES = 3 * 1024 * 1024; // 3MB
const TESTIMONIAL_PHOTO_DIMENSION = 240; // square avatar, px

/**
 * Validates an optional review-photo upload. Returns an error message,
 * or null if there's no file at all (photo is optional) or it's safe
 * to store. Verifies real image content with getimagesize() rather
 * than trusting the extension or client-supplied MIME type.
 */
function validate_testimonial_photo_upload(array $file): ?string
{
    if (($file['error'] ?? UPLOAD_ERR_NO_FILE) === UPLOAD_ERR_NO_FILE) {
        return null;
    }
    if ($file['error'] !== UPLOAD_ERR_OK) {
        return match ($file['error']) {
            UPLOAD_ERR_INI_SIZE, UPLOAD_ERR_FORM_SIZE => 'Photo is too large.',
            default => 'Photo upload failed. Please try again.',
        };
    }
    if (!is_uploaded_file($file['tmp_name'])) {
        return 'Invalid upload.';
    }
    if ($file['size'] <= 0 || $file['size'] > TESTIMONIAL_PHOTO_MAX_BYTES) {
        return 'Photo must be under 3MB.';
    }

    $actualMime = detect_file_mime_type($file['tmp_name']);
    if (!in_array($actualMime, ['image/jpeg', 'image/png'], true)) {
        return 'Photo must be a JPG or PNG file.';
    }

    $imageInfo = @getimagesize($file['tmp_name']);
    if ($imageInfo === false) {
        return "File content doesn't look like a real image — upload rejected.";
    }

    return null;
}

/**
 * Stores an already-validated photo: re-encodes it via GD into a fixed
 * square JPEG (never trusts/keeps the original file), so every avatar
 * is a consistent size regardless of what was uploaded, and any
 * non-pixel-data payload smuggled in the original file is discarded in
 * the process. Returns the new file's public path (for testimonials.photo_path).
 */
function store_testimonial_photo_upload(array $file): string
{
    if (!is_dir(TESTIMONIAL_PHOTO_DIR)) {
        mkdir(TESTIMONIAL_PHOTO_DIR, 0755, true);
    }

    $mime = detect_file_mime_type($file['tmp_name']);
    $source = $mime === 'image/png' ? imagecreatefrompng($file['tmp_name']) : imagecreatefromjpeg($file['tmp_name']);
    if ($source === false) {
        throw new RuntimeException('Failed to read uploaded photo.');
    }

    $width = imagesx($source);
    $height = imagesy($source);
    $side = min($width, $height);
    $srcX = (int) (($width - $side) / 2);
    $srcY = (int) (($height - $side) / 2);

    $canvas = imagecreatetruecolor(TESTIMONIAL_PHOTO_DIMENSION, TESTIMONIAL_PHOTO_DIMENSION);
    imagecopyresampled(
        $canvas, $source,
        0, 0, $srcX, $srcY,
        TESTIMONIAL_PHOTO_DIMENSION, TESTIMONIAL_PHOTO_DIMENSION, $side, $side
    );
    imagedestroy($source);

    $storedFilename = bin2hex(random_bytes(24)) . '.jpg';
    $destination = TESTIMONIAL_PHOTO_DIR . '/' . $storedFilename;
    imagejpeg($canvas, $destination, 85);
    imagedestroy($canvas);

    return TESTIMONIAL_PHOTO_PUBLIC_PATH . '/' . $storedFilename;
}

/** The current customer's own testimonial row, if they've submitted one, or null. */
function fetch_customer_testimonial(int $customerId): ?array
{
    $stmt = db()->prepare('SELECT * FROM testimonials WHERE customer_id = :id LIMIT 1');
    $stmt->execute(['id' => $customerId]);
    $row = $stmt->fetch();
    return $row ?: null;
}

/**
 * Creates or updates (upserts, via the UNIQUE customer_id key) the
 * logged-in customer's own review — never creates a second row for the
 * same customer. $photoPath is null to leave an existing photo
 * untouched (e.g. the customer edited their quote but didn't re-upload
 * a photo); pass a real path only when a new photo was just stored.
 */
function save_customer_testimonial(
    int $customerId,
    string $customerName,
    ?string $customerLocation,
    int $rating,
    string $quote,
    ?string $photoPath
): void {
    $existing = fetch_customer_testimonial($customerId);
    $finalPhotoPath = $photoPath ?? ($existing['photo_path'] ?? null);

    db()->prepare(
        "INSERT INTO testimonials (customer_id, customer_name, customer_location, rating, quote, photo_path, status, display_order)
         VALUES (:customer_id, :name, :location, :rating, :quote, :photo_path, 'published', 0)
         ON DUPLICATE KEY UPDATE
             customer_name = VALUES(customer_name), customer_location = VALUES(customer_location),
             rating = VALUES(rating), quote = VALUES(quote), photo_path = VALUES(photo_path)"
    )->execute([
        'customer_id' => $customerId,
        'name' => $customerName,
        'location' => $customerLocation,
        'rating' => $rating,
        'quote' => $quote,
        'photo_path' => $finalPhotoPath,
    ]);
}
