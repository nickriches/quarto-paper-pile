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
