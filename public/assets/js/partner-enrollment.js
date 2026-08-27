/*
 * B2B partner enrollment wizard — progressive-enhancement only, no
 * step depends on JS to function server-side. Split into per-page
 * feature detection so one script can be safely included on every
 * wizard step without erroring where a given element doesn't exist.
 */
(function () {
  'use strict';

  // Step 1: show/hide the IATA number field based on the Yes/No radio.
  var iataRadios = document.querySelectorAll('[data-iata-toggle]');
  var iataGroup = document.getElementById('iata-number-group');
  if (iataRadios.length && iataGroup) {
    iataRadios.forEach(function (radio) {
      radio.addEventListener('change', function () {
        iataGroup.style.display = this.value === '1' ? '' : 'none';
      });
    });
  }

  // Step 5: keep the submit button disabled until every required
  // checkbox (all six policy acknowledgements + the final declaration)
  // is checked, mirroring the server-side "all required" validation
  // rather than replacing it — the POST handler still re-checks
  // every box itself.
  var termsForm = document.getElementById('enrollment-terms-form');
  if (termsForm) {
    var requiredBoxes = termsForm.querySelectorAll('input[type="checkbox"][required]');
    var submitBtn = document.getElementById('enrollment-terms-submit');
    var updateSubmitState = function () {
      var allChecked = Array.prototype.every.call(requiredBoxes, function (box) {
        return box.checked;
      });
      submitBtn.disabled = !allChecked;
    };
    requiredBoxes.forEach(function (box) {
      box.addEventListener('change', updateSubmitState);
    });
    updateSubmitState();
  }
})();
