document.addEventListener('DOMContentLoaded', function () {
  // Mobile nav toggle
  var navToggle = document.getElementById('navToggle');
  var mobileNav = document.getElementById('mobileNav');
  if (navToggle && mobileNav) {
    navToggle.addEventListener('click', function () {
      var open = mobileNav.classList.toggle('is-open');
      navToggle.setAttribute('aria-expanded', open ? 'true' : 'false');
    });
  }

  // Password show/hide toggles
  document.querySelectorAll('[data-toggle-password]').forEach(function (btn) {
    var input = document.getElementById(btn.getAttribute('data-toggle-password'));
    if (!input) return;
    btn.addEventListener('click', function () {
      var isHidden = input.type === 'password';
      input.type = isHidden ? 'text' : 'password';
      btn.setAttribute('aria-label', isHidden ? 'Hide password' : 'Show password');
      btn.classList.toggle('is-visible', isHidden);
    });
  });

  // Smooth-scroll for same-page anchor links
  document.querySelectorAll('a[href^="#"]').forEach(function (link) {
    var id = link.getAttribute('href');
    if (id.length < 2) return;
    var target = document.querySelector(id);
    if (!target) return;
    link.addEventListener('click', function (e) {
      e.preventDefault();
      target.scrollIntoView({ behavior: 'smooth', block: 'start' });
    });
  });

  // Basic client-side required-field affordance (server still validates)
  document.querySelectorAll('form[data-validate]').forEach(function (form) {
    form.addEventListener('submit', function (e) {
      var invalid = form.querySelector(':invalid');
      if (invalid) {
        e.preventDefault();
        invalid.focus();
        invalid.classList.add('field-invalid');
      }
    });
  });
});
