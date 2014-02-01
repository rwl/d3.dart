part of d3.transition;

transitionNode(node, i, id, inherit) {
  if (nodeTransition(node) == null) {
    nodeTransition(node, {'active': 0, 'count': 0});
  }
  var lock = nodeTransition(node);
  var transition = lock[id];

  if (!transition) {
    var time = inherit.time;

    transition = lock[id] = {
      'tween': new Map(),
      'time': time,
      'ease': inherit.ease,
      'delay': inherit.delay,
      'duration': inherit.duration
    };

    ++lock.count;

    time.timer((elapsed) {
      var d = nodeData(node),
          ease = transition.ease,
          delay = transition.delay,
          duration = transition.duration,
          timer = time.timer_active,
          tweened = [];

      stop() {
        if (--lock.count) {
          lock.remove(id);
        } else {
          nodeTransition(node, null);
        }
        return 1;
      }

      tick(elapsed) {
        if (lock.active != id) return stop();

        var t = elapsed / duration,
            e = ease(t),
            n = tweened.length;

        while (n > 0) {
          tweened[--n].call(node, e);
        }

        if (t >= 1) {
          transition.event && transition.event.end.call(node, d, i);
          return stop();
        }
      }

      start(elapsed) {
        if (lock.active > id) return stop();
        lock.active = id;
        transition.event && transition.event.start.call(node, d, i);

        transition.tween.forEach((key, value) {
          if (value = value.call(node, d, i)) {
            tweened.add(value);
          }
        });

        time.timer(() { // defer to end of current frame
          timer.c = tick(elapsed || 1) ? () {return true;} : tick;
          return 1;
        }, 0, time);
      }

      timer.t = delay + time;
      if (delay <= elapsed) return start(elapsed - delay);
      timer.c = start;
    }, 0, time);
  }
}
