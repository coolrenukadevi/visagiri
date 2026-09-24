(function () {
  var root = document.getElementById('hero-slider');
  if (!root) return;

  var track = root.querySelector('.hero-slider__track');
  var slides = Array.prototype.slice.call(root.querySelectorAll('.hero-slide'));
  var dots = Array.prototype.slice.call(root.querySelectorAll('.hero-slider__dot'));
  var prevBtn = root.querySelector('.hero-slider__arrow--prev');
  var nextBtn = root.querySelector('.hero-slider__arrow--next');
  if (!track || slides.length < 2) return;

  var reduceMotion = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;
  var current = 0;
  var timer = null;
  var AUTOPLAY_MS = 6000;

  function supportsInert() {
    return 'inert' in HTMLElement.prototype;
  }

  function render() {
    track.style.transform = 'translateX(-' + current * 100 + '%)';
    root.classList.toggle('is-light-slide', slides[current].classList.contains('hero-slide--light'));

    slides.forEach(function (slide, i) {
      var active = i === current;
      slide.setAttribute('aria-hidden', active ? 'false' : 'true');
      if (supportsInert()) {
        slide.inert = !active;
      }
    });

    dots.forEach(function (dot, i) {
      var active = i === current;
      dot.classList.toggle('is-active', active);
      dot.setAttribute('aria-selected', active ? 'true' : 'false');
    });
  }

  function goTo(index) {
    current = (index + slides.length) % slides.length;
    render();
  }

  function next() {
    goTo(current + 1);
  }

  function prev() {
    goTo(current - 1);
  }

  function stopAutoplay() {
    if (timer) {
      clearInterval(timer);
      timer = null;
    }
  }

  function startAutoplay() {
    if (reduceMotion || document.visibilityState !== 'visible') return;
    stopAutoplay();
    timer = setInterval(next, AUTOPLAY_MS);
  }

  if (nextBtn) nextBtn.addEventListener('click', function () { next(); startAutoplay(); });
  if (prevBtn) prevBtn.addEventListener('click', function () { prev(); startAutoplay(); });

  dots.forEach(function (dot, i) {
    dot.addEventListener('click', function () {
      goTo(i);
      startAutoplay();
    });
  });

  root.addEventListener('keydown', function (e) {
    if (e.key === 'ArrowLeft') {
      prev();
      startAutoplay();
    } else if (e.key === 'ArrowRight') {
      next();
      startAutoplay();
    }
  });

  root.addEventListener('mouseenter', stopAutoplay);
  root.addEventListener('mouseleave', startAutoplay);
  root.addEventListener('focusin', stopAutoplay);
  root.addEventListener('focusout', startAutoplay);
  document.addEventListener('visibilitychange', function () {
    if (document.visibilityState === 'visible') {
      startAutoplay();
    } else {
      stopAutoplay();
    }
  });

  // Basic touch/pointer swipe support.
  var pointerStartX = null;
  var pointerActive = false;
  track.addEventListener('pointerdown', function (e) {
    pointerStartX = e.clientX;
    pointerActive = true;
    stopAutoplay();
  });
  track.addEventListener('pointerup', function (e) {
    if (!pointerActive || pointerStartX === null) return;
    var delta = e.clientX - pointerStartX;
    if (Math.abs(delta) > 40) {
      delta < 0 ? next() : prev();
    }
    pointerActive = false;
    pointerStartX = null;
    startAutoplay();
  });
  track.addEventListener('pointercancel', function () {
    pointerActive = false;
    pointerStartX = null;
    startAutoplay();
  });

  render();
  startAutoplay();
})();
