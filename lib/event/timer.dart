part of d3.event;

var timer_queueHead,
    timer_queueTail,
    timer_interval, // is an interval (or frame) active?
    timer_timeout, // is a timeout active?
    timer_active, // active timer object
    timer_frame = window[vendorSymbol(window, "requestAnimationFrame")] || (callback) { setTimeout(callback, 17); };

// The timer will continue to fire until callback returns true.
var timer = (callback, [delay=0, then=null]) {
  if (then == null) {
    then = new DateTime.now();
  }

  // Add the callback to the tail of the queue.
  var time = then + delay, timer = {'c': callback, 't': time, 'f': false, 'n': null};
  if (timer_queueTail) {
    timer_queueTail.n = timer;
  } else {
    timer_queueHead = timer;
  }
  timer_queueTail = timer;

  // Start animatin'!
  if (!timer_interval) {
    timer_timeout = clearTimeout(d3_timer_timeout);
    timer_interval = 1;
    timer_frame(d3_timer_step);
  }
};

timer_step() {
  var now = timer_mark();
  var delay = timer_sweep() - now;
  if (delay > 24) {
    if (isFinite(delay)) {
      clearTimeout(timer_timeout);
      timer_timeout = setTimeout(timer_step, delay);
    }
    timer_interval = 0;
  } else {
    timer_interval = 1;
    timer_frame(timer_step);
  }
}

timer.flush = function() {
  timer_mark();
  timer_sweep();
};

timer_mark() {
  var now = new DateTime.now();
  timer_active = timer_queueHead;
  while (timer_active) {
    if (now >= timer_active.t) {
      timer_active.f = timer_active.c(now - timer_active.t);
    }
    timer_active = timer_active.n;
  }
  return now;
}

// Flush after callbacks to avoid concurrent queue modification.
// Returns the time of the earliest active timer, post-sweep.
timer_sweep() {
  var t0,
      t1 = timer_queueHead,
      time = double.INFINITY;
  while (t1) {
    if (t1.f) {
      t1 = t0 ? t0.n = t1.n : timer_queueHead = t1.n;
    } else {
      if (t1.t < time) time = t1.t;
      t1 = (t0 = t1).n;
    }
  }
  timer_queueTail = t0;
  return time;
}
