library d3.src.internal;

import 'dart:js';
import 'd3.dart';

JsObject _d3 = context['d3'];

/// Create a function that returns a constant.
functor(value) => _d3.callMethod('functor', [value]);

/// Rebind an inherited getter/setter method to a subclass.
rebind(target, source, [List<String> names]) {
  var args = [target, source]..addAll(names);
  return _d3.callMethod('rebind', args);
}

/// Create a custom event dispatcher.
Dispatch dispatch([List<String> types]) {
  return new Dispatch._(_d3.callMethod('dispatch', types));
}

class Dispatch {
  final JsObject _proxy;

  Dispatch._(this._proxy);

  /// Register or unregister an event listener.
  on(String type, [Function listener = undefined]) {
    return _proxy.callMethod('on', [type, listener]);
  }

  /// Dispatch an event to registered listeners.
  type(List arguments) => _proxy.callMethod('type', arguments);
}
