@JS('d3')
library d3.src.internal;

import 'package:js/js.dart';

/// Create a function that returns a constant.
external functor(value);

/// Rebind an inherited getter/setter method to a subclass.
external rebind(target, source, [names]);

/// Create a custom event dispatcher.
external Dispatch dispatch([types]);

@JS()
class Dispatch {
  /// Register or unregister an event listener.
  external on(type, [listener]);

  /// Dispatch an event to registered listeners.
  external type([arguments]);
}
