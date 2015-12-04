@JS('d3')
library d3.src.internal;

import 'package:js/js.dart';

/// create a function that returns a constant.
external functor(value);

/// rebind an inherited getter/setter method to a subclass.
external rebind(target, source, [names]);

/// create a custom event dispatcher.
external Dispatch dispatch([types]);

@JS()
class Dispatch {
  /// register or unregister an event listener.
  external on(type, [listener]);

  /// dispatch an event to registered listeners.
  external type([arguments]);
}
