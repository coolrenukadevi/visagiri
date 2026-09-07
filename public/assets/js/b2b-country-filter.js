/*
 * B2B Travel Partner Portal — Step 4 country search filter.
 * Progressive enhancement only: every country checkbox is present
 * and submittable without JS, this just hides non-matching rows.
 */
(function () {
    'use strict';
    var filterInput = document.getElementById('country-filter');
    if (!filterInput) return;
    filterInput.addEventListener('input', function () {
        var term = this.value.trim().toLowerCase();
        document.querySelectorAll('[data-country-label]').forEach(function (label) {
            label.style.display = label.textContent.toLowerCase().indexOf(term) === -1 ? 'none' : '';
        });
        document.querySelectorAll('[data-region-group]').forEach(function (group) {
            var anyVisible = Array.prototype.some.call(group.querySelectorAll('[data-country-label]'), function (l) { return l.style.display !== 'none'; });
            group.style.display = anyVisible ? '' : 'none';
        });
    });
})();
