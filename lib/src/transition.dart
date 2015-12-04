@JS('d3')
library d3.src.transition;

import 'dart:html';
import 'package:js/js.dart';

external Transition transition([selection, name]);

@JS()
class Transition {
  external Transition delay([delay]);
  external Transition duration([duration]);
  external Transition ease([value, arguments]);
  external Transition attr(name, value);
  external Transition attrTween(name, tween);
  external Transition style(name, value, [priority]);
  external Transition styleTween(name, tween, [priority]);
  external Transition text(value);
  external Transition tween(name, factory);
  external Transition remove();
  external Transition select(selector);
  external Transition selectAll(selector);
  external Transition filter(selector);
  external Transition transition();
  external Transition each([type, listener]);
  external Transition call(function, [arguments]);
  external bool empty();
  external Node node();
  external int size();
}

external timer(function, [delay, time]);

@JS('timer.flush')
external flushTimer();

external interpolate(a, b);
external interpolateNumber(a, b);
external interpolateRound(a, b);
external interpolateString(a, b);
external interpolateRgb(a, b);
external interpolateHsl(a, b);
external interpolateLab(a, b);
external interpolateHcl(a, b);
external interpolateArray(a, b);
external interpolateObject(a, b);
external interpolateTransform(a, b);
external interpolateZoom(a, b);

@JS('geo.interpolate')
external geo_interpolate(a, b);

external List get interpolators;
