(function () {
  'use strict';
  document.querySelectorAll('[data-role-permission-group-toggle]').forEach(function (toggle) {
    var groupKey = toggle.getAttribute('data-role-permission-group-toggle');
    var checkboxes = document.querySelectorAll('[data-role-permission-group="' + groupKey + '"]');

    var syncToggleState = function () {
      toggle.checked = Array.prototype.every.call(checkboxes, function (cb) { return cb.checked; });
    };
    syncToggleState();

    toggle.addEventListener('change', function () {
      checkboxes.forEach(function (cb) { cb.checked = toggle.checked; });
    });
    checkboxes.forEach(function (cb) {
      cb.addEventListener('change', syncToggleState);
    });
  });
})();
