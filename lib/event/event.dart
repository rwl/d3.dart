library d3.event;

import 'dart:html';

import '../selection/selection.dart';

part 'dispatch.dart';
part 'drag.dart';
part 'mouse.dart';
part 'timer.dart';
part 'touches.dart';

var event = null;

eventPreventDefault() {
  event.preventDefault();
}

eventSource() {
  var e = event, s = e.sourceEvent;
  while (s != null) {
    e = s;
    s = e.sourceEvent;
  }
  return e;
}

// Like Dispatch, but for custom events abstracting native UI events. These
// events have a target component (such as a brush), a target element (such as
// the svg:g element containing the brush) and the standard arguments `d` (the
// target element's data) and `i` (the selection index of the target element).
eventDispatch(target) {
  var dispatch = new Dispatch();
  int i = 0;
  int n = arguments.length;

  while (++i < n) {
    dispatch[arguments[i]] = dispatch_event(dispatch);
  }

  // Creates a dispatch context for the specified `thiz` (typically, the target
  // DOM element that received the source event) and `argumentz` (typically, the
  // data `d` and index `i` of the target element). The returned function can be
  // used to dispatch an event to any registered listeners; the function takes a
  // single argument as input, being the event to dispatch. The event must have
  // a "type" attribute which corresponds to a type registered in the
  // constructor. This context will automatically populate the "sourceEvent" and
  // "target" attributes of the event, as well as setting the `d3.event` global
  // for the duration of the notification.
  dispatch.of = (thiz, argumentz) {
    return (e1) {
      try {
        var e0 = e1.sourceEvent = event;
        e1.target = target;
        event = e1;
        dispatch[e1.type].apply(thiz, argumentz);
      } finally {
        event = e0;
      }
    };
  };

  return dispatch;
}
