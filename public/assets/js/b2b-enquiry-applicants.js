(function () {
  'use strict';
  var list = document.getElementById('applicant-rows');
  var template = document.getElementById('applicant-row-template');
  var addBtn = document.getElementById('add-applicant-btn');
  if (!list || !template || !addBtn) return;

  function renumber() {
    Array.prototype.forEach.call(list.children, function (row, index) {
      row.querySelectorAll('[data-field]').forEach(function (el) {
        el.name = 'applicants[' + index + '][' + el.getAttribute('data-field') + ']';
      });
      var label = row.querySelector('[data-row-label]');
      if (label) label.textContent = 'Applicant ' + (index + 1);
      var removeBtn = row.querySelector('[data-remove-applicant]');
      if (removeBtn) removeBtn.hidden = list.children.length <= 1;
    });
  }

  addBtn.addEventListener('click', function () {
    var clone = template.content.cloneNode(true);
    list.appendChild(clone);
    renumber();
  });

  list.addEventListener('click', function (e) {
    var btn = e.target.closest('[data-remove-applicant]');
    if (!btn) return;
    var row = btn.closest('[data-applicant-row]');
    if (row && list.children.length > 1) {
      row.remove();
      renumber();
    }
  });

  renumber();
})();
