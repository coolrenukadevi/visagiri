/*
 * Country directory live search — Phase 7. Vanilla JS, no dependency.
 * Pulled into its own file (rather than inline) so it complies with
 * the site's script-src 'self' Content Security Policy.
 */
(function () {
  'use strict';

  var input = document.getElementById('country-filter');
  if (!input) return;

  var regions = Array.prototype.slice.call(document.querySelectorAll('.country-directory__region'));
  var emptyState = document.getElementById('country-directory__empty');

  input.addEventListener('input', function () {
    var q = input.value.trim().toLowerCase();
    var anyVisible = false;
    regions.forEach(function (region) {
      var regionHasMatch = false;
      region.querySelectorAll('.country-directory__item').forEach(function (item) {
        var match = item.getAttribute('data-name').indexOf(q) !== -1;
        item.hidden = !match;
        if (match) regionHasMatch = true;
      });
      region.hidden = !regionHasMatch;
      if (regionHasMatch) anyVisible = true;
    });
    if (emptyState) emptyState.hidden = anyVisible;
  });
})();
