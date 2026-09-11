<?php
declare(strict_types=1);

/**
 * Sitewide "Enquire Now" dialog — included once from footer.php so
 * every "Enquire Now" entry point (header CTA, mobile menu, floating
 * widget) can open the same modal instead of navigating straight to
 * /enquire/ or /contact/. A service picker (Visa, Apostille & Attestation,
 * Forex, General Enquiry) transitions, in place, to the right form:
 * Visa/Apostille lazy-loads the real multi-step wizard from
 * pages/enquire-wizard-fragment.php (see enquiry-modal.js); Forex and
 * General use the small static form below, submitted to the same
 * /contact/ endpoint pages/contact.php already handles for those two
 * service types. Both paths submit via fetch — see enquiry-wizard.js's
 * and enquiry-modal.js's ajax-submit handling — so nothing here ever
 * causes a full page navigation; only the standalone /enquire/ and
 * /contact/ pages (the no-JS/direct-link fallback these CTAs still
 * point to) do a normal browser POST.
 */
?>
<div class="enquiry-modal" id="enquiry-modal" hidden>
    <div class="enquiry-modal__backdrop" data-enquiry-modal-close></div>
    <div class="enquiry-modal__dialog" role="dialog" aria-modal="true" aria-labelledby="enquiry-modal-title">
        <button type="button" class="enquiry-modal__close" data-enquiry-modal-close aria-label="Close">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" aria-hidden="true"><path d="M18 6 6 18M6 6l12 12"/></svg>
        </button>
        <div class="enquiry-modal__scroll">

            <div class="enquiry-modal__step" data-enquiry-modal-step="picker">
                <div class="enquiry-modal__header">
                    <span class="enquiry-modal__eyebrow">Enquire Now</span>
                    <h2 class="enquiry-modal__title" id="enquiry-modal-title">What service do you need?</h2>
                    <p class="enquiry-modal__subtitle">Choose a service and we'll open the right enquiry form for you.</p>
                </div>
                <div class="enquiry-modal__grid">
                    <button type="button" class="enquiry-modal__tile" data-enquiry-service="visa">
                        <span class="enquiry-modal__tile-title">Visa Services</span>
                        <span class="enquiry-modal__tile-desc">Tell us about your travel plans and upload your documents. Our visa team will review your requirements and contact you.</span>
                    </button>
                    <button type="button" class="enquiry-modal__tile" data-enquiry-service="apostille">
                        <span class="enquiry-modal__tile-title">Apostille &amp; Attestation</span>
                        <span class="enquiry-modal__tile-desc">Tell us which documents need apostille or attestation and our documentation team will guide you through it.</span>
                    </button>
                    <button type="button" class="enquiry-modal__tile" data-enquiry-service="forex">
                        <span class="enquiry-modal__tile-title">Forex</span>
                        <span class="enquiry-modal__tile-desc">Tell us your currency requirement and travel plans and our forex desk will get back to you.</span>
                    </button>
                    <button type="button" class="enquiry-modal__tile" data-enquiry-service="general">
                        <span class="enquiry-modal__tile-title">General Enquiry</span>
                        <span class="enquiry-modal__tile-desc">Anything else? Tell us what you need and our team will point you in the right direction.</span>
                    </button>
                </div>
            </div>

            <div class="enquiry-modal__step" data-enquiry-modal-step="simple-form" hidden>
                <button type="button" class="enquiry-modal__back" data-enquiry-modal-back>&larr; Back</button>
                <div class="enquiry-modal__header">
                    <span class="enquiry-modal__eyebrow" data-enquiry-modal-simple-eyebrow>General Enquiry</span>
                    <h2 class="enquiry-modal__title" data-enquiry-modal-simple-title>Tell us what you need</h2>
                </div>
                <form id="enquiry-modal-simple-form" data-ajax-submit="1" novalidate>
                    <?= csrf_field() ?>
                    <input type="hidden" name="service" id="enquiry-modal-simple-service" value="general">
                    <div class="form-group" style="position:absolute;left:-9999px" aria-hidden="true">
                        <label for="enquiry-modal-simple-website">Leave this field blank</label>
                        <input type="text" id="enquiry-modal-simple-website" name="website" tabindex="-1" autocomplete="off">
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="enquiry-modal-simple-name">Full Name</label>
                        <input class="form-input" type="text" id="enquiry-modal-simple-name" name="name" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="enquiry-modal-simple-email">Email Address</label>
                        <input class="form-input" type="email" id="enquiry-modal-simple-email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="enquiry-modal-simple-phone">Phone Number (optional)</label>
                        <input class="form-input" type="tel" id="enquiry-modal-simple-phone" name="phone" placeholder="e.g. +91 98765 43210">
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="enquiry-modal-simple-message">Message</label>
                        <textarea class="form-input" id="enquiry-modal-simple-message" name="message" rows="4" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary" style="width:100%" id="enquiry-modal-simple-submit">Send Message</button>
                </form>
            </div>

            <div class="enquiry-modal__step" data-enquiry-modal-step="wizard" hidden>
                <button type="button" class="enquiry-modal__back" data-enquiry-modal-back>&larr; Back</button>
                <div class="enquiry-modal__header">
                    <span class="enquiry-modal__eyebrow" data-enquiry-modal-wizard-eyebrow>Visa Services</span>
                    <h2 class="enquiry-modal__title" data-enquiry-modal-wizard-title>Request a Visa Quote</h2>
                </div>
                <div data-enquiry-modal-wizard-container>
                    <p class="enquiry-modal__loading">Loading form&hellip;</p>
                </div>
            </div>

            <div class="enquiry-modal__step" data-enquiry-modal-step="success" hidden>
                <div class="enquiry-modal__success">
                    <div class="alert alert-success" role="status">
                        <strong>Thank you for contacting Visagiri.</strong> Your enquiry has been received.
                    </div>
                    <p class="enquiry-modal__success-ref">
                        <strong>Reference No.:</strong> <span data-enquiry-modal-success-ref></span><br>
                        <span data-enquiry-modal-success-track-row hidden><strong>Tracking No.:</strong> <span data-enquiry-modal-success-track></span></span>
                    </p>
                    <p data-enquiry-modal-success-checklist-note hidden style="margin-top:var(--space-4)"></p>
                    <div class="button-group" style="justify-content:center;flex-wrap:wrap;margin-top:var(--space-5)">
                        <a href="#" class="btn btn-gold" data-enquiry-modal-success-checklist hidden>View Complete Checklist</a>
                        <a href="#" class="btn btn-gold" data-enquiry-modal-success-pdf target="_blank" rel="noopener noreferrer" hidden>Download PDF Receipt</a>
                        <a href="#" class="btn btn-outline" data-enquiry-modal-success-track-link target="_blank" rel="noopener noreferrer" hidden>Track Enquiry</a>
                        <button type="button" class="btn btn-outline" data-enquiry-modal-close>Close</button>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
