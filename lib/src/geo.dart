@JS('d3.geo')
library d3.src.geo;

import 'package:js/js.dart';

external Path path();

class Path {
  external path(feature, [index]);
  external projection([projection]);
  external context([context]);
  external area(feature);
  external centroid(feature);
  external bounds(feature);
  external pointRadius([radius]);
}

external Graticule graticule();

class Graticule {
  external graticule();
  external lines();
  external outline();
  external extent(extent);
  external majorExtent(extent);
  external minorExtent(extent);
  external step(step);
  external majorStep(step);
  external minorStep(step);
  external precision(precision);
}

external Circle circle();

class Circle {
  external circle(arguments);
  external origin([origin]);
  external angle([angle]);
  external precision([precision]);
}

external area(feature);
external centroid(feature);
external bounds(feature);
external distance(a, b);
external length(feature);
external interpolate(a, b);

external Rotation rotation(rotate);

class Rotation {
  external rotation(location);
  external invert(location);
}

external Projection projection(raw);

class Projection {
  external projection(location);
  external invert(point);
  external rotate([rotation]);
  external center([location]);
  external translate([point]);
  external scale([scale]);
  external clipAngle(angle);
  external clipExtent(extent);
  external precision(precision);
  external stream(listener);
}

external Function projectionMutator(rawFactory);

external albers();
external albersUsa();
external azimuthalEqualArea();
external azimuthalEquidistant();

external ConicConformal conicConformal();

class ConicConformal {
  external parallels([parallels]);
}

external ConicEqualArea conicEqualArea();

class ConicEqualArea {
  external parallels([parallels]);
}

external ConicEquidistant conicEquidistant();

class ConicEquidistant {
  external parallels([parallels]);
}

external equirectangular();

external gnomonic();

external mercator();

external orthographic();

external stereographic();

external transverseMercator();

@JS('albers.raw')
external albersRaw(a0, a1);

@JS('azimuthalEqualArea.raw')
external get azimuthalEqualAreaRaw;

@JS('azimuthalEquidistant.raw')
external get azimuthalEquidistantRaw;

@JS('conicConformal.raw')
external conicConformalRaw(a0, a1);

@JS('conicEqualArea.raw')
external conicEqualAreaRaw(a0, a1);

@JS('conicEquidistant.raw')
external conicEquidistantRaw(a0, a1);

@JS('equirectangular.raw')
external get equirectangularRaw;

@JS('gnomonic.raw')
external get gnomonicRaw;

@JS('mercator.raw')
external get mercatorRaw;

@JS('orthographic.raw')
external get orthographicRaw;

@JS('stereographic.raw')
external get stereographicRaw;

external StreamListener stream(object, listener);

class StreamListener {
  external point(x, y, [z]);
  external lineStart();
  external lineEnd();
  external polygonStart();
  external polygonEnd();
  external sphere();
}

external StreamTransform transform(methods);

class StreamTransform {
  external stream(listener);
}

external ClipExtent clipExtent();

class ClipExtent {
  external extent([extent]);
}
