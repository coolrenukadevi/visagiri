<?php
declare(strict_types=1);

/**
 * Floating "Visa Assistant" — a keyword-matching search over the real
 * FAQ database (visa_faqs), not a generative AI. Deliberately built
 * this way rather than wiring in an LLM: a freeform conversational
 * assistant could paraphrase or guess at visa fees/documents/
 * processing times when it doesn't actually know them, which is
 * exactly the fabrication risk this whole project avoids elsewhere
 * (visa_requirements/embassies ship empty rather than guessed). This
 * widget only ever echoes back a real FAQ's real answer verbatim, or
 * a small set of fixed quick-links to real pages — it never
 * generates new text. A true generative assistant is a separate,
 * larger decision (needs a chosen LLM provider and API key) — see
 * AUDIT.md.
 */

$assistantQuickLinks = [
    ['label' => 'Document Checklists', 'href' => '/document-templates/'],
    ['label' => 'Track My Application', 'href' => '/track-visa/'],
    ['label' => 'Embassy Directory', 'href' => '/embassy-directory/'],
    ['label' => 'Browse by Continent', 'href' => '/visa/'],
    ['label' => 'Talk to a Human', 'href' => '/contact/'],
];
?>
<div class="visa-assistant" id="visa-assistant">
    <div class="visa-assistant__panel" id="visa-assistant-panel" hidden>
        <div class="visa-assistant__header">
            <span>Visa Assistant</span>
            <button type="button" class="visa-assistant__close" id="visa-assistant-close" aria-label="Close">&times;</button>
        </div>
        <div class="visa-assistant__body" id="visa-assistant-body">
            <div class="visa-assistant__message visa-assistant__message--bot">
                Hi! Ask me about visa requirements, documents, or how to track your application — or pick an option below.
            </div>
            <div class="visa-assistant__quick-links">
                <?php foreach ($assistantQuickLinks as $link): ?>
                <a href="<?= e($link['href']) ?>" class="visa-assistant__quick-link"><?= e($link['label']) ?></a>
                <?php endforeach; ?>
            </div>
        </div>
        <form class="visa-assistant__form" id="visa-assistant-form">
            <input type="text" class="visa-assistant__input" id="visa-assistant-input" placeholder="Ask a question…" autocomplete="off">
            <button type="submit" class="visa-assistant__send" aria-label="Send">&rarr;</button>
        </form>
    </div>
    <button type="button" class="visa-assistant__toggle" id="visa-assistant-toggle" aria-expanded="false" aria-controls="visa-assistant-panel" aria-label="Open Visa Assistant">
        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M12 2a10 10 0 1 0 4.6 18.9L22 22l-1.15-4.4A10 10 0 0 0 12 2Z"/><line x1="8" y1="10" x2="16" y2="10"/><line x1="8" y1="14" x2="13" y2="14"/></svg>
    </button>
</div>
<script type="application/json" id="visa-assistant-faqs"><?= json_encode(all_active_faqs(), JSON_UNESCAPED_SLASHES | JSON_HEX_TAG | JSON_HEX_AMP) ?></script>
