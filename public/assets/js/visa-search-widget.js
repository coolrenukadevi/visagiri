/**
 * Enhanced visa search widget — instant autocomplete across real
 * countries/visa types/continents/status directories (data embedded
 * server-side, see visa-search-data.php), keyboard navigation, a
 * localStorage-only "recent searches" list (per-browser, never sent
 * anywhere), and an optional voice-search button using the browser's
 * native SpeechRecognition API (progressive enhancement — the button
 * only appears if the browser actually supports it).
 *
 * Every suggestion links to a real, already-existing page — this
 * widget never invents a destination or guesses at a URL that might
 * not exist.
 */
(function () {
    'use strict';

    var RECENT_KEY = 'visagiri_recent_searches';
    var MAX_RECENT = 5;
    var MAX_RESULTS = 8;

    function getRecent() {
        try {
            var raw = window.localStorage.getItem(RECENT_KEY);
            return raw ? JSON.parse(raw) : [];
        } catch (e) {
            return [];
        }
    }

    function pushRecent(item) {
        try {
            var list = getRecent().filter(function (r) { return r.href !== item.href; });
            list.unshift(item);
            window.localStorage.setItem(RECENT_KEY, JSON.stringify(list.slice(0, MAX_RECENT)));
        } catch (e) { /* localStorage unavailable — recent searches just won't persist */ }
    }

    function init(root) {
        var input = root.querySelector('[data-search-input]');
        var list = root.querySelector('[data-search-results]');
        var voiceBtn = root.querySelector('[data-search-voice]');
        var dataEl = document.getElementById(root.getAttribute('data-search-source'));
        if (!input || !list || !dataEl) return;

        var items;
        try {
            items = JSON.parse(dataEl.textContent);
        } catch (e) {
            return;
        }

        var activeIndex = -1;

        function render(rows) {
            list.innerHTML = '';
            if (!rows.length) {
                list.hidden = true;
                return;
            }
            rows.forEach(function (row, i) {
                var li = document.createElement('li');
                li.className = 'visa-search-widget__result';
                li.setAttribute('role', 'option');
                li.id = 'visa-search-result-' + i;
                var a = document.createElement('a');
                a.href = row.href;
                a.innerHTML = '<span class="visa-search-widget__result-label">' + escapeHtml(row.label) + '</span>' +
                    '<span class="visa-search-widget__result-type">' + escapeHtml(row.type) + '</span>';
                a.addEventListener('click', function () {
                    pushRecent({ label: row.label, href: row.href });
                });
                li.appendChild(a);
                list.appendChild(li);
            });
            list.hidden = false;
            activeIndex = -1;
        }

        function escapeHtml(s) {
            var div = document.createElement('div');
            div.textContent = s;
            return div.innerHTML;
        }

        function renderRecent() {
            var recent = getRecent();
            if (!recent.length) {
                list.hidden = true;
                return;
            }
            list.innerHTML = '';
            var heading = document.createElement('li');
            heading.className = 'visa-search-widget__heading';
            heading.textContent = 'Recent searches';
            list.appendChild(heading);
            recent.forEach(function (row, i) {
                var li = document.createElement('li');
                li.className = 'visa-search-widget__result';
                li.setAttribute('role', 'option');
                li.id = 'visa-search-result-' + i;
                var a = document.createElement('a');
                a.href = row.href;
                a.innerHTML = '<span class="visa-search-widget__result-label">' + escapeHtml(row.label) + '</span>';
                li.appendChild(a);
                list.appendChild(li);
            });
            list.hidden = false;
            activeIndex = -1;
        }

        function search(q) {
            q = q.trim().toLowerCase();
            if (q === '') {
                renderRecent();
                return;
            }
            var matches = items.filter(function (row) {
                return row.label.toLowerCase().indexOf(q) !== -1;
            }).slice(0, MAX_RESULTS);
            render(matches);
        }

        input.addEventListener('input', function () { search(input.value); });
        input.addEventListener('focus', function () { search(input.value); });

        document.addEventListener('click', function (e) {
            if (!root.contains(e.target)) list.hidden = true;
        });

        input.addEventListener('keydown', function (e) {
            var options = list.querySelectorAll('.visa-search-widget__result');
            if (!options.length) return;
            if (e.key === 'ArrowDown') {
                e.preventDefault();
                activeIndex = Math.min(activeIndex + 1, options.length - 1);
                updateActive(options);
            } else if (e.key === 'ArrowUp') {
                e.preventDefault();
                activeIndex = Math.max(activeIndex - 1, 0);
                updateActive(options);
            } else if (e.key === 'Enter' && activeIndex >= 0) {
                e.preventDefault();
                var link = options[activeIndex].querySelector('a');
                if (link) link.click();
            } else if (e.key === 'Escape') {
                list.hidden = true;
            }
        });

        function updateActive(options) {
            options.forEach(function (opt, i) {
                opt.classList.toggle('is-active', i === activeIndex);
            });
            if (options[activeIndex]) {
                options[activeIndex].scrollIntoView({ block: 'nearest' });
            }
        }

        // Voice search — only shown if the browser actually supports it.
        var SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
        if (voiceBtn) {
            if (!SpeechRecognition) {
                voiceBtn.hidden = true;
            } else {
                voiceBtn.hidden = false;
                voiceBtn.addEventListener('click', function () {
                    var recognition = new SpeechRecognition();
                    recognition.lang = 'en-IN';
                    recognition.interimResults = false;
                    recognition.maxAlternatives = 1;
                    voiceBtn.classList.add('is-listening');
                    recognition.onresult = function (event) {
                        var transcript = event.results[0][0].transcript;
                        input.value = transcript;
                        search(transcript);
                        input.focus();
                    };
                    recognition.onerror = function () {
                        voiceBtn.classList.remove('is-listening');
                    };
                    recognition.onend = function () {
                        voiceBtn.classList.remove('is-listening');
                    };
                    recognition.start();
                });
            }
        }
    }

    document.querySelectorAll('[data-search-widget]').forEach(init);
})();
