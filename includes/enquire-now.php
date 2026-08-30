<?php
/**
 * Universal "Enquire Now" floating button + 2-step dialog, included from
 * footer.php on every page.
 *
 * Step 1 (service picker) is shared by every service; step 2 here is
 * deliberately GENERIC (country / purpose / date / message) rather than the
 * visa- or forex-specific forms the spec describes — those need fields
 * (visa type, currency, amount…) that belong to the dedicated Visa and Forex
 * modules landing in later phases. This phase's job is the enquiry engine
 * itself: every submission gets a real enquiry_code and a row in `enquiries`
 * regardless of which service was picked. Phase 5/6 extend this same
 * enquiry with service-specific detail tables, per the DB design already
 * agreed in the blueprint — they don't replace it.
 *
 * Enquiries are tied to a `customers` row (see customer_auth.php), not the
 * legacy OAuth `users` table — that's the identity the rest of the CRM
 * schema (customer_id everywhere) is built on. An OAuth-only visitor is
 * asked to get a Customer ID rather than silently blocked.
 */
$cvCanEnquire = (bool) ($cvCustomer ?? null);
$cvServiceTypes = service_types_all();
?>
<button type="button" class="enquire-fab" id="enquireNowBtn" aria-haspopup="dialog" aria-expanded="false" aria-controls="enquireNowDialog">
  <svg viewBox="0 0 24 24" width="18" height="18" aria-hidden="true"><path fill="currentColor" d="M12 2C6.5 2 2 6 2 11c0 2.4 1 4.6 2.7 6.2L4 22l5-2c1 .3 2 .4 3 .4 5.5 0 10-4 10-9s-4.5-9-10-9zm-1 13v-2h2v2h-2zm0-4V6h2v5h-2z"/></svg>
  <span class="enquire-fab-label">Enquire Now</span>
</button>

<div class="auth-dialog" id="enquireNowDialog" role="dialog" aria-modal="true" aria-label="Enquire now" hidden>
  <div class="auth-dialog-panel auth-card-wide">
    <div class="auth-dialog-head">
      <h2>Enquire Now</h2>
      <button type="button" class="auth-dialog-close" data-close-dialog aria-label="Close">
        <svg viewBox="0 0 24 24" width="16" height="16"><path fill="currentColor" d="M6.4 5 5 6.4 10.6 12 5 17.6 6.4 19 12 13.4 17.6 19 19 17.6 13.4 12 19 6.4 17.6 5 12 10.6z"/></svg>
      </button>
    </div>

    <?php if (!$cvCanEnquire): ?>
    <div class="auth-dialog-body">
      <p class="auth-dialog-status">
        You'll need a Convercession Customer ID to submit an enquiry — it's how we tie your enquiry,
        documents and updates together in one place.
      </p>
      <div class="auth-form-row">
        <a href="<?= url('/register') ?>" class="btn btn-primary btn-sm">Create an account</a>
        <a href="<?= url('/customer-login') ?>?next=<?= rawurlencode(auth_safe_next($_SERVER['REQUEST_URI'] ?? '/')) ?>" class="btn btn-outline-brand btn-sm">Sign in</a>
      </div>
    </div>
    <?php else: ?>
    <div class="wizard-steps" style="padding:0 20px">
      <div class="wizard-step-dot is-current" data-dot="1"><span class="dot-num">1</span><span class="dot-label">Service</span></div>
      <div class="wizard-step-line"></div>
      <div class="wizard-step-dot" data-dot="2"><span class="dot-num">2</span><span class="dot-label">Details</span></div>
    </div>

    <div id="enquireNowMsg" role="alert"></div>

    <form id="enquireNowForm" novalidate style="padding:0 20px 20px">
      <input type="hidden" name="csrf" value="<?= e(auth_csrf_token()) ?>">
      <input type="hidden" name="service_type_id" id="enqServiceTypeId">

      <fieldset class="wizard-step" data-step="1">
        <div class="enq-service-grid">
          <?php foreach ($cvServiceTypes as $st): ?>
          <button type="button" class="enq-service-card" data-service-id="<?= (int) $st['id'] ?>"><?= e($st['label']) ?></button>
          <?php endforeach; ?>
        </div>
        <div class="wizard-actions"><span></span><button type="button" class="btn btn-primary enq-next" disabled>Continue &rarr;</button></div>
      </fieldset>

      <fieldset class="wizard-step" data-step="2" hidden>
        <div class="enquiry-grid">
          <div class="enquiry-field"><label for="enqCountry">Destination Country *</label>
            <select id="enqCountry" name="country" required>
              <option value="">Select&hellip;</option>
              <?php foreach ($cvCountries as $c): ?><option value="<?= e($c) ?>"><?= e($c) ?></option><?php endforeach; ?>
            </select>
          </div>
          <div class="enquiry-field"><label for="enqPurpose">Travel Purpose *</label>
            <select id="enqPurpose" name="travel_purpose" required>
              <option value="">Select&hellip;</option>
              <?php foreach (['Tourism', 'Business', 'Study', 'Employment', 'Medical', 'Family Visit', 'Conference', 'Other'] as $purpose): ?>
              <option value="<?= e($purpose) ?>"><?= e($purpose) ?></option>
              <?php endforeach; ?>
            </select>
          </div>
          <div class="enquiry-field"><label for="enqDate">Preferred Travel Date</label><input type="date" id="enqDate" name="travel_date" min="<?= date('Y-m-d') ?>"></div>
          <div class="enquiry-field full"><label for="enqMessage">Anything else we should know?</label><textarea id="enqMessage" name="message" rows="3"></textarea></div>
        </div>
        <div class="wizard-actions"><button type="button" class="btn btn-ghost wizard-back">&larr; Back</button><button type="submit" class="btn btn-primary">Submit Enquiry</button></div>
      </fieldset>
    </form>
    <?php endif; ?>
  </div>
</div>
