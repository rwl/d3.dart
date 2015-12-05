library d3.src.internal;

import 'dart:js';

JsObject _d3 = context['d3'];

/// Create a function that returns a constant.
functor(value) {
  return _d3.callMethod('functor', []);
}

/// Rebind an inherited getter/setter method to a subclass.
rebind(target, source, [names]) {
  return _d3.callMethod('rebind', []);
}

/// Create a custom event dispatcher.
Dispatch dispatch([types]) {
  return _d3.callMethod('dispatch', []);
}

class Dispatch {
  final JsObject _proxy;

  Dispatch._(this._proxy);

  /// Register or unregister an event listener.
  on(type, [listener]) {
    return _proxy.callMethod('on', []);
  }

  /// Dispatch an event to registered listeners.
  type([arguments]) {
    return _proxy.callMethod('type', []);
  }
}
