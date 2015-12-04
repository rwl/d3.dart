@JS('d3')
library d3.src.selection;

import 'dart:html';
import 'package:js/js.dart';

external Selection select(selector);

external Selection selectAll(selector);

external Event get event;

external List mouse(container);

external List touch(container, [touches, identifier]);

external List touches(container, [touches]);

@JS()
class Selection {
  external Selection attr(name, [value]);
  external Selection classed(name, [value]);
  external Selection style(name, [value, priority]);
  external Selection property(name, [value]);
  external Selection text([value]);
  external Selection html([value]);
  external Selection append(String name);
  external Selection insert(name, [before]);
  external Selection remove();
  external Selection data([values, key]);
  external Selection enter();
  external Selection exit();
  external Selection filter(selector);
  external Selection datum([value]);
  external Selection sort([comparator]);
  external Selection order();
  external Selection on(type, [listener, capture]);
  external Selection transition([name]);
  external Selection interrupt([name]);
  external Selection select(selector);
  external Selection selectAll(selector);
  external Selection each(function);
  external Selection call(function, [arguments]);
  external bool empty();
  external Node node();
  external int size();
}
