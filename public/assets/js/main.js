/**
 * Paynancial — site interactions: mega menu, mobile nav, left-side login
 * panel, scroll reveal, animated counters, developer code tabs.
 */
(function () {
  'use strict';

  var prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

  /* ---------------------------------------------------------------
     Mega menu (desktop)
     --------------------------------------------------------------- */
  var navItems = document.querySelectorAll('.nav-item');
  navItems.forEach(function (item) {
    var trigger = item.querySelector('.nav-link');
    if (!trigger || !item.querySelector('.mega-menu')) return;
    trigger.addEventListener('click', function (e) {
      e.preventDefault();
      var isOpen = item.classList.contains('is-open');
      navItems.forEach(function (i) { i.classList.remove('is-open'); });
      if (!isOpen) item.classList.add('is-open');
    });
  });
  document.addEventListener('click', function (e) {
    if (!e.target.closest('.nav-item')) {
      navItems.forEach(function (i) { i.classList.remove('is-open'); });
    }
  });
  document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape') navItems.forEach(function (i) { i.classList.remove('is-open'); });
  });

  /* ---------------------------------------------------------------
     Mobile nav drawer
     --------------------------------------------------------------- */
  var hamburger = document.querySelector('.hamburger');
  var mobileNav = document.querySelector('.mobile-nav');
  var mobileNavClose = document.querySelector('.mobile-nav-close');
  function toggleMobileNav(open) {
    if (!mobileNav) return;
    mobileNav.classList.toggle('is-open', open);
    document.body.style.overflow = open ? 'hidden' : '';
  }
  if (hamburger) hamburger.addEventListener('click', function () { toggleMobileNav(true); });
  if (mobileNavClose) mobileNavClose.addEventListener('click', function () { toggleMobileNav(false); });

  /* ---------------------------------------------------------------
     Left-side login panel
     --------------------------------------------------------------- */
  var loginOverlay = document.querySelector('[data-login-overlay]');
  var loginPanel = document.querySelector('[data-login-panel]');
  var loginTriggers = document.querySelectorAll('[data-login-open]');
  var loginClose = document.querySelector('[data-login-close]');

  function openLoginPanel(role) {
    if (!loginPanel || !loginOverlay) return;
    loginOverlay.classList.add('is-open');
    loginPanel.classList.add('is-open');
    document.body.style.overflow = 'hidden';
    if (role) setActiveRole(role);
    var firstInput = loginPanel.querySelector('.login-form.is-active input');
    if (firstInput) setTimeout(function () { firstInput.focus(); }, 320);
  }
  function closeLoginPanel() {
    if (!loginPanel || !loginOverlay) return;
    loginOverlay.classList.remove('is-open');
    loginPanel.classList.remove('is-open');
    document.body.style.overflow = '';
  }
  loginTriggers.forEach(function (btn) {
    btn.addEventListener('click', function (e) {
      e.preventDefault();
      openLoginPanel(btn.getAttribute('data-login-open') || null);
    });
  });
  if (loginClose) loginClose.addEventListener('click', closeLoginPanel);
  if (loginOverlay) loginOverlay.addEventListener('click', closeLoginPanel);
  if (loginPanel) loginPanel.addEventListener('click', function (e) { e.stopPropagation(); });
  document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape' && loginPanel && loginPanel.classList.contains('is-open')) closeLoginPanel();
  });

  /* Role tab switching */
  var roleTabs = document.querySelectorAll('.role-tab');
  function setActiveRole(role) {
    roleTabs.forEach(function (t) { t.classList.toggle('is-active', t.getAttribute('data-role') === role); });
    document.querySelectorAll('.login-form').forEach(function (f) {
      f.classList.toggle('is-active', f.getAttribute('data-role-form') === role);
    });
  }
  roleTabs.forEach(function (tab) {
    tab.addEventListener('click', function () { setActiveRole(tab.getAttribute('data-role')); });
  });

  (function () {
    var params = new URLSearchParams(window.location.search);
    var loginParam = params.get('login');
    if (loginParam === 'required') {
      openLoginPanel(null);
    } else if (loginParam && ['customer', 'partner', 'employee', 'hr'].indexOf(loginParam) !== -1) {
      openLoginPanel(loginParam);
    }
  })();

  /* AJAX login submit (the 4 real portal forms; the OTP form is handled separately below) */
  function postJson(url, payload) {
    return fetch(url, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(payload),
      credentials: 'same-origin'
    }).then(function (res) { return res.json().then(function (data) { return { ok: res.ok, data: data }; }); });
  }

  function showFormError(form, message) {
    var errorBox = form.querySelector('.form-error');
    if (errorBox) { errorBox.textContent = message; errorBox.classList.add('is-visible'); }
  }

  document.querySelectorAll('.login-form[data-role-form]:not([data-role-form="otp"])').forEach(function (form) {
    form.addEventListener('submit', function (e) {
      e.preventDefault();
      var errorBox = form.querySelector('.form-error');
      var submitBtn = form.querySelector('button[type="submit"]');
      if (errorBox) { errorBox.classList.remove('is-visible'); errorBox.textContent = ''; }
      if (submitBtn) { submitBtn.disabled = true; submitBtn.dataset.label = submitBtn.textContent; submitBtn.textContent = 'Signing in…'; }

      postJson('/api/auth/login', Object.fromEntries(new FormData(form).entries()))
        .then(function (result) {
          if (result.ok && result.data.ok && result.data.otp_required) {
            var otpForm = document.querySelector('.login-form[data-role-form="otp"]');
            var dest = otpForm.querySelector('[data-otp-destination]');
            if (dest) dest.textContent = result.data.destination_masked || 'your registered email';
            otpForm.dataset.returnRole = form.getAttribute('data-role-form');
            setActiveRole('otp');
            var otpInput = otpForm.querySelector('#otp-code');
            if (otpInput) { otpInput.value = ''; otpInput.focus(); }
          } else if (result.ok && result.data.ok) {
            window.location.href = result.data.redirect || '/';
          } else {
            showFormError(form, (result.data && result.data.error) || 'Unable to sign in. Please try again.');
          }
        })
        .catch(function () { showFormError(form, 'Network error. Please try again.'); })
        .finally(function () {
          if (submitBtn) { submitBtn.disabled = false; submitBtn.textContent = submitBtn.dataset.label; }
        });
    });
  });

  /* OTP step: verify, resend, back-to-login */
  var otpForm = document.querySelector('.login-form[data-role-form="otp"]');
  if (otpForm) {
    otpForm.addEventListener('submit', function (e) {
      e.preventDefault();
      var submitBtn = otpForm.querySelector('button[type="submit"]');
      otpForm.querySelector('.form-error').classList.remove('is-visible');
      if (submitBtn) { submitBtn.disabled = true; submitBtn.dataset.label = submitBtn.textContent; submitBtn.textContent = 'Verifying…'; }

      postJson('/api/auth/verify-otp', Object.fromEntries(new FormData(otpForm).entries()))
        .then(function (result) {
          if (result.ok && result.data.ok) {
            window.location.href = result.data.redirect || '/';
          } else {
            showFormError(otpForm, (result.data && result.data.error) || 'Unable to verify that code.');
          }
        })
        .catch(function () { showFormError(otpForm, 'Network error. Please try again.'); })
        .finally(function () {
          if (submitBtn) { submitBtn.disabled = false; submitBtn.textContent = submitBtn.dataset.label; }
        });
    });

    var resendBtn = otpForm.querySelector('[data-otp-resend]');
    if (resendBtn) {
      resendBtn.addEventListener('click', function () {
        resendBtn.disabled = true;
        var original = resendBtn.textContent;
        resendBtn.textContent = 'Sending…';
        postJson('/api/auth/resend-otp', { csrf_token: otpForm.querySelector('[name="csrf_token"]').value })
          .then(function (result) {
            if (result.ok && result.data.ok) {
              resendBtn.textContent = 'Code sent';
            } else {
              showFormError(otpForm, (result.data && result.data.error) || 'Could not resend code.');
              resendBtn.textContent = original;
            }
          })
          .catch(function () { resendBtn.textContent = original; })
          .finally(function () { setTimeout(function () { resendBtn.disabled = false; resendBtn.textContent = original; }, 3000); });
      });
    }

    var backBtn = otpForm.querySelector('[data-otp-back]');
    if (backBtn) {
      backBtn.addEventListener('click', function () {
        setActiveRole(otpForm.dataset.returnRole || 'customer');
      });
    }
  }

  /* ---------------------------------------------------------------
     Scroll reveal
     --------------------------------------------------------------- */
  var revealEls = document.querySelectorAll('.reveal');
  if ('IntersectionObserver' in window && !prefersReducedMotion) {
    var observer = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          entry.target.classList.add('is-visible');
          observer.unobserve(entry.target);
        }
      });
    }, { threshold: 0.15 });
    revealEls.forEach(function (el) { observer.observe(el); });
  } else {
    revealEls.forEach(function (el) { el.classList.add('is-visible'); });
  }

  /* ---------------------------------------------------------------
     Animated counters
     --------------------------------------------------------------- */
  var counters = document.querySelectorAll('[data-counter]');
  function animateCounter(el) {
    var target = parseFloat(el.getAttribute('data-counter'));
    var suffix = el.getAttribute('data-suffix') || '';
    var decimals = parseInt(el.getAttribute('data-decimals') || '0', 10);
    if (prefersReducedMotion) { el.textContent = target.toFixed(decimals) + suffix; return; }
    var duration = 1200;
    var start = null;
    function step(ts) {
      if (!start) start = ts;
      var progress = Math.min((ts - start) / duration, 1);
      var eased = 1 - Math.pow(1 - progress, 3);
      el.textContent = (target * eased).toFixed(decimals) + suffix;
      if (progress < 1) requestAnimationFrame(step);
    }
    requestAnimationFrame(step);
  }
  if ('IntersectionObserver' in window) {
    var counterObserver = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) { animateCounter(entry.target); counterObserver.unobserve(entry.target); }
      });
    }, { threshold: 0.4 });
    counters.forEach(function (el) { counterObserver.observe(el); });
  } else {
    counters.forEach(animateCounter);
  }

  /* ---------------------------------------------------------------
     Developer code tabs + copy-to-clipboard
     --------------------------------------------------------------- */
  document.querySelectorAll('.code-panel').forEach(function (panel) {
    var tabs = panel.querySelectorAll('.code-tab');
    var blocks = panel.querySelectorAll('[data-code-block]');
    tabs.forEach(function (tab) {
      tab.addEventListener('click', function () {
        tabs.forEach(function (t) { t.classList.remove('is-active'); });
        tab.classList.add('is-active');
        var lang = tab.getAttribute('data-lang');
        blocks.forEach(function (b) { b.style.display = (b.getAttribute('data-code-block') === lang) ? 'block' : 'none'; });
      });
    });
  });
  document.querySelectorAll('.copy-btn').forEach(function (btn) {
    btn.addEventListener('click', function () {
      var block = btn.closest('.code-body').querySelector('[data-code-block]:not([style*="display: none"])') || btn.closest('.code-body').querySelector('[data-code-block]');
      if (!block) return;
      navigator.clipboard.writeText(block.textContent.trim()).then(function () {
        var original = btn.textContent;
        btn.textContent = 'Copied!';
        setTimeout(function () { btn.textContent = original; }, 1600);
      });
    });
  });

  /* ---------------------------------------------------------------
     Dashboard sidebar toggle (mobile)
     --------------------------------------------------------------- */
  var sidebarToggle = document.querySelector('.sidebar-toggle');
  var appSidebar = document.querySelector('.app-sidebar');
  if (sidebarToggle && appSidebar) {
    sidebarToggle.addEventListener('click', function () { appSidebar.classList.toggle('is-open'); });
  }
})();
