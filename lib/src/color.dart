@JS('d3')
library d3.src.color;

import 'package:js/js.dart';

external Rgb rgb(r, [g, b]);

class Rgb {
  external Rgb brighter([k]);
  external Rgb darker([k]);
  external Hsl hsl();
  external String toString();
}

external Hsl hsl(h, [s, l]);

class Hsl {
  external Hsl brighter([k]);
  external Hsl darker([k]);
  external Rgb rgb();
  external String toString();
}

external Hcl hcl(h, [c, l]);

class Hcl {
  external Hcl brighter([k]);
  external Hcl darker([k]);
  external Rgb rgb();
  external String toString();
}

external Lab lab(l, [a, b]);

class Lab {
  external Lab brighter([k]);
  external Lab darker([k]);
  external Rgb rgb();
  external String toString();
}
