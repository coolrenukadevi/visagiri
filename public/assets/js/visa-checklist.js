(function () {
  'use strict';

  var page = document.querySelector('.visa-checklist-page');
  if (!page) {
    return;
  }

  var tabs = page.querySelectorAll('[data-vc-tab]');
  var panels = page.querySelectorAll('[data-vc-panel]');

  function activate(name) {
    tabs.forEach(function (t) {
      t.setAttribute('aria-selected', String(t.getAttribute('data-vc-tab') === name));
    });
    panels.forEach(function (p) {
      p.hidden = p.getAttribute('data-vc-panel') !== name;
    });
  }

  tabs.forEach(function (t) {
    t.addEventListener('click', function () {
      activate(t.getAttribute('data-vc-tab'));
    });
  });

  page.querySelectorAll('[data-vc-tab-link]').forEach(function (link) {
    link.addEventListener('click', function (e) {
      e.preventDefault();
      var target = link.getAttribute('data-vc-tab-link');
      activate(target);
      var panel = document.getElementById('vc-panel-' + target);
      if (panel) {
        panel.scrollIntoView({ behavior: 'smooth', block: 'start' });
      }
    });
  });
})();
