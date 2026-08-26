/**
 * Visa Assistant — keyword search over the real FAQ list embedded by
 * includes/visa-assistant-widget.php. Scores each FAQ by how many of
 * the visitor's words appear in its question+answer text and shows
 * the best real match verbatim; if nothing scores above the
 * threshold, it says so honestly and points to a human/quick-link
 * instead of guessing. No network request, no generated text.
 */
(function () {
    'use strict';

    var root = document.getElementById('visa-assistant');
    if (!root) return;

    var toggle = document.getElementById('visa-assistant-toggle');
    var panel = document.getElementById('visa-assistant-panel');
    var closeBtn = document.getElementById('visa-assistant-close');
    var body = document.getElementById('visa-assistant-body');
    var form = document.getElementById('visa-assistant-form');
    var input = document.getElementById('visa-assistant-input');
    var dataEl = document.getElementById('visa-assistant-faqs');

    var faqs = [];
    try {
        faqs = JSON.parse(dataEl.textContent);
    } catch (e) { /* no FAQs available yet — assistant still offers quick links */ }

    function open() {
        panel.hidden = false;
        toggle.setAttribute('aria-expanded', 'true');
        input.focus();
    }

    function close() {
        panel.hidden = true;
        toggle.setAttribute('aria-expanded', 'false');
    }

    toggle.addEventListener('click', function () {
        panel.hidden ? open() : close();
    });
    closeBtn.addEventListener('click', close);

    function addMessage(text, who) {
        var div = document.createElement('div');
        div.className = 'visa-assistant__message visa-assistant__message--' + who;
        div.textContent = text;
        body.appendChild(div);
        body.scrollTop = body.scrollHeight;
    }

    function bestMatch(query) {
        var words = query.toLowerCase().split(/\s+/).filter(function (w) { return w.length > 2; });
        if (!words.length) return null;

        var best = null;
        var bestScore = 0;
        faqs.forEach(function (faq) {
            var haystack = (faq.question + ' ' + faq.answer).toLowerCase();
            var score = 0;
            words.forEach(function (w) {
                if (haystack.indexOf(w) !== -1) score++;
            });
            if (score > bestScore) {
                bestScore = score;
                best = faq;
            }
        });
        return bestScore >= 1 ? best : null;
    }

    form.addEventListener('submit', function (e) {
        e.preventDefault();
        var q = input.value.trim();
        if (q === '') return;
        addMessage(q, 'user');
        input.value = '';

        var match = bestMatch(q);
        if (match) {
            addMessage(match.answer, 'bot');
        } else {
            addMessage("I don't have a published answer for that yet. Try the options below, or reach a human directly.", 'bot');
        }
    });
})();
