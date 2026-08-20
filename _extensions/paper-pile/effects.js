(function () {
  function init() {
    function playSpin(el) {
      el.classList.remove('play');
      void el.offsetWidth;
      el.classList.add('play');
    }

    Reveal.on('fragmentshown', event => {
      if (event.fragment.classList.contains('paper-shot')) {
        playSpin(event.fragment);
      }
    });

    Reveal.on('fragmenthidden', event => {
      if (event.fragment.classList.contains('paper-shot')) {
        event.fragment.classList.remove('play');
      }
    });

    Reveal.on('slidechanged', event => {
      if (event.previousSlide) {
        event.previousSlide.querySelectorAll('.paper-shot:not(.fragment)').forEach(el => {
          el.classList.remove('play');
        });
      }
      event.currentSlide.querySelectorAll('.paper-shot:not(.fragment)').forEach(playSpin);
    });
  }

  // The extension's HTML dependency can load before Reveal.js itself does,
  // so wait until the document (and any earlier synchronous scripts,
  // including Reveal's own init call) has finished loading.
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
