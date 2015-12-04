@JS('d3')
library d3.src.internal;

import 'package:js/js.dart';

external functor(value);
external rebind(target, source, [names]);

external Dispatch dispatch([types]);

class Dispatch {
  external on(type, [listener]);
  external type([arguments]);
}
