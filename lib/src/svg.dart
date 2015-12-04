@JS('d3.svg')
library d3.src.svg;

import 'package:js/js.dart';

external Line line();

class Line {
  external line(data);
  external x([x]);
  external y([y]);
  external interpolate([interpolate]);
  external tension([tension]);
  external defined([defined]);
  external radial();
  external radius([radius]);
  external angle([angle]);
}

external Area area();

class Area {
  external area(data);
  external x([x]);
  external x0([x0]);
  external x1([x1]);
  external y([y]);
  external y0([y0]);
  external interpolate([interpolate]);
  external tension([tension]);
  external defined([defined]);
  external radial();
  external radius([radius]);
  external innerRadius([radius]);
  external outerRadius([radius]);
  external angle([angle]);
  external startAngle([angle]);
  external endAngle([angle]);
}

external Arc arc();

class Arc {
  external arc(datum, [index]);
  external innerRadius([radius]);
  external outerRadius([radius]);
  external cornerRadius([radius]);
  external padRadius([radius]);
  external startAngle([angle]);
  external endAngle([angle]);
  external padAngle([angle]);
  external centroid([arguments]);
}

external Symbol symbol();

class Symbol {
  external symbol(datum, [index]);
  external type([type]);
  external size([size]);
}

external List get symbolTypes;

external Chord chord();

class Chord {
  external chord(datum, [index]);
  external source([source]);
  external target([target]);
  external radius([radius]);
  external startAngle([angle]);
  external endAngle([angle]);
}

external Diagonal diagonal();

class Diagonal {
  external diagonal(datum, [index]);
  external source([source]);
  external target([target]);
  external projection([projection]);
  external radial();
}

external Axis axis();

class Axis {
  external axis(selection);
  external Axis scale([scale]);
  external Axis orient([orientation]);
  external Axis ticks([arguments]);
  external tickValues([values]);
  external Axis tickSize([inner, outer]);
  external innerTickSize([size]);
  external outerTickSize([size]);
  external tickPadding([padding]);
  external tickFormat([format]);
}

external Brush brush();

class Brush {
  external brush(selection);
  external x([scale]);
  external y([scale]);
  external extent([values]);
  external clamp([clamp]);
  external clear();
  external empty();
  external on(type, [listener]);
  external event(selection);
}
