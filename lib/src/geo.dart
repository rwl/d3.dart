library d3.src.geo;

import 'dart:js';
import 'd3.dart';

JsObject _geo = context['d3']['geo'];

/// Create a new geographic path generator.
Path path() => new Path._(_geo.callMethod('path'));

class Path {
  final JsObject _proxy;

  Path._(this._proxy);

  /// Project the specified feature and render it to the context.
  String call(Map feature, [num index = undefined]) {
    var args = [_proxy, new JsObject.jsify(feature)];
    if (index != undefined) {
      args.add(index);
    }
    return _proxy.callMethod('call', args);
  }

  /// Get or set the geographic projection.
  projection([projection(coords) = undefined]) {
    var args = [];
    if (projection != undefined) {
      args.add(projection);
    }
    var retval = _proxy.callMethod('projection', args);
    if (projection == undefined) {
      return retval;
    } else {
      return new Path._(retval);
    }
  }

  /// Get or set the render context.
  context([context = undefined]) {
    var args = [];
    if (context != undefined) {
      args.add(context);
    }
    var retval = _proxy.callMethod('context', args);
    if (context == undefined) {
      return retval;
    } else {
      return new Path._(retval);
    }
  }

  /// Compute the projected area of a given feature.
  num area(Map feature) {
    return _proxy.callMethod('area', [new JsObject.jsify(feature)]);
  }

  /// Compute the projected centroid of a given feature.
  List centroid(Map feature) {
    return _proxy.callMethod('centroid', [new JsObject.jsify(feature)]);
  }

  /// Compute the projected bounds of a given feature.
  List bounds(Map feature) {
    return _proxy.callMethod('bounds', [new JsObject.jsify(feature)]);
  }

  /// Get or set the radius to display point features.
  pointRadius([radius = undefined]) {
    var args = [];
    if (radius is Function) {
      args.add(func4VarArgs(radius));
    } else if (radius != undefined) {
      args.add(radius);
    }
    var retval = _proxy.callMethod('pointRadius', args);
    if (radius == undefined) {
      return retval;
    } else {
      return new Path._(retval);
    }
  }
}

/// Create a graticule generator.
Graticule graticule() => new Graticule._(_geo.callMethod('graticule'));

class Graticule {
  final JsObject _proxy;

  Graticule._(this._proxy);

  /// Generate a MultiLineString of meridians and parallels.
  call() => _proxy.callMethod('call', [_proxy]);

  /// Generate an array of LineStrings of meridians and parallels.
  List lines() => _proxy.callMethod('lines');

  /// Generate a Polygon of the graticule's extent.
  outline() => _proxy.callMethod('outline');

  /// Get or set the major & minor extents.
  extent([List extent = undefined]) {
    var args = [];
    if (extent != undefined) {
      args.add(extent);
    }
    var retval = _proxy.callMethod('extent', args);
    if (extent == undefined) {
      return retval;
    } else {
      return new Graticule._(retval);
    }
  }

  /// Get or set the major extent.
  majorExtent([List extent = undefined]) {
    var args = [];
    if (extent != undefined) {
      args.add(extent);
    }
    var retval = _proxy.callMethod('majorExtent', args);
    if (extent == undefined) {
      return retval;
    } else {
      return new Graticule._(retval);
    }
  }

  /// Get or set the minor extent.
  minorExtent([List extent = undefined]) {
    var args = [];
    if (extent != undefined) {
      args.add(extent);
    }
    var retval = _proxy.callMethod('minorExtent', args);
    if (extent == undefined) {
      return retval;
    } else {
      return new Graticule._(retval);
    }
  }

  /// Get or set the major & minor step intervals.
  step([List step = undefined]) {
    var args = [];
    if (step != undefined) {
      args.add(step);
    }
    var retval = _proxy.callMethod('step', args);
    if (step == undefined) {
      return retval;
    } else {
      return new Graticule._(retval);
    }
  }

  /// Get or set the major step intervals.
  majorStep([List step = undefined]) {
    var args = [];
    if (step != undefined) {
      args.add(step);
    }
    var retval = _proxy.callMethod('majorStep', args);
    if (step == undefined) {
      return retval;
    } else {
      return new Graticule._(retval);
    }
  }

  /// Get or set the minor step intervals.
  minorStep([List step = undefined]) {
    var args = [];
    if (step != undefined) {
      args.add(step);
    }
    var retval = _proxy.callMethod('minorStep', args);
    if (step == undefined) {
      return retval;
    } else {
      return new Graticule._(retval);
    }
  }

  /// Get or set the latitudinal precision.
  precision([num precision = undefined]) {
    var args = [];
    if (precision != undefined) {
      args.add(precision);
    }
    var retval = _proxy.callMethod('precision', args);
    if (precision == undefined) {
      return retval;
    } else {
      return new Graticule._(retval);
    }
  }
}

/// Create a circle generator.
Circle circle() => new Circle._(_geo.callMethod('circle'));

class Circle {
  final JsObject _proxy;

  Circle._(this._proxy);

  /// Generate a piecewise circle as a Polygon.
  call(List arguments) {
    var args = [_proxy]..addAll(arguments);
    return _proxy.callMethod('call', args);
  }

  /// Specify the origin in latitude and longitude.
  origin([origin = undefined]) {
    var args = [];
    if (origin != undefined) {
      args.add(origin);
    }
    var retval = _proxy.callMethod('origin', args);
    if (origin == undefined) {
      return retval;
    } else {
      return new Circle._(retval);
    }
  }

  /// Specify the angular radius in degrees.
  angle([num angle = undefined]) {
    var args = [];
    if (angle != undefined) {
      args.add(angle);
    }
    var retval = _proxy.callMethod('angle', args);
    if (angle == undefined) {
      return retval;
    } else {
      return new Circle._(retval);
    }
  }

  /// Specify the precision of the piecewise circle.
  precision([num precision = undefined]) {
    var args = [];
    if (precision != undefined) {
      args.add(precision);
    }
    var retval = _proxy.callMethod('precision', args);
    if (precision == undefined) {
      return retval;
    } else {
      return new Circle._(retval);
    }
  }
}

/// Compute the spherical area of a given feature.
num area(feature) => _geo.callMethod('area', [feature]);

/// Compute the spherical centroid of a given feature.
List centroid(feature) => _geo.callMethod('centroid', [feature]);

/// Compute the latitude-longitude bounding box for a given feature.
List bounds(feature) => _geo.callMethod('bounds', [feature]);

/// Compute the great-arc distance between two points.
num distance(List a, List b) => _geo.callMethod('distance', [a, b]);

/// Compute the length of a line string or the perimeter of a polygon.
num length(feature) => _geo.callMethod('length', [feature]);

/// Interpolate between two points along a great arc.
Function interpolate(List a, List b) => _geo.callMethod('interpolate', [a, b]);

/// Create a rotation function for the specified angles [λ, φ, γ].
Rotation rotation(rotate) {
  return new Rotation._(_geo.callMethod('rotation', [rotate]));
}

class Rotation {
  final JsObject _proxy;

  Rotation._(this._proxy);

  /// Rotate the given location around the sphere.
  List call(List location) {
    return _proxy.callMethod('call', [_proxy, location]);
  }

  /// Inverse-rotate the given location around the sphere.
  List invert(List location) {
    return _proxy.callMethod('invert', [location]);
  }
}

/// Create a standard projection from a raw projection.
Projection projection(Function raw) {
  return new Projection._(_geo.callMethod('projection', [raw]));
}

class Projection {
  final JsObject _proxy;

  Projection._(this._proxy);

  /// Project the specified location.
  List call(List location) {
    return _proxy.callMethod('call', [_proxy, location]);
  }

  /// Invert the projection for the specified point.
  List invert(List point) {
    return _proxy.callMethod('invert', [point]);
  }

  /// Get or set the projection's three-axis rotation.
  rotate([List rotation = undefined]) {
    var args = [];
    if (rotation != undefined) {
      args.add(rotation);
    }
    var retval = _proxy.callMethod('rotate', args);
    if (rotation == undefined) {
      return retval;
    } else {
      return new Projection._(retval);
    }
  }

  /// Get or set the projection's center location.
  center([List location = undefined]) {
    var args = [];
    if (location != undefined) {
      args.add(location);
    }
    var retval = _proxy.callMethod('center', args);
    if (location == undefined) {
      return retval;
    } else {
      return new Projection._(retval);
    }
  }

  /// Get or set the projection's translation position.
  translate([List point = undefined]) {
    var args = [];
    if (point != undefined) {
      args.add(point);
    }
    var retval = _proxy.callMethod('translate', args);
    if (point == undefined) {
      return retval;
    } else {
      return new Projection._(retval);
    }
  }

  /// Get or set the projection's scale factor.
  scale([num scale = undefined]) {
    var args = [];
    if (scale != undefined) {
      args.add(scale);
    }
    var retval = _proxy.callMethod('scale', args);
    if (scale == undefined) {
      return retval;
    } else {
      return new Projection._(retval);
    }
  }

  /// Get or set the radius of the projection's clip circle.
  clipAngle([num angle = undefined]) {
    var args = [];
    if (angle != undefined) {
      args.add(angle);
    }
    var retval = _proxy.callMethod('clipAngle', args);
    if (angle == undefined) {
      return retval;
    } else {
      return new Projection._(retval);
    }
  }

  /// Get or set the projection's viewport clip extent, in pixels.
  clipExtent([List extent = undefined]) {
    var args = [];
    if (extent != undefined) {
      args.add(extent);
    }
    var retval = _proxy.callMethod('clipExtent', args);
    if (extent == undefined) {
      return retval;
    } else {
      return new Projection._(retval);
    }
  }

  /// Get or set the precision threshold for adaptive resampling.
  precision([num precision = undefined]) {
    var args = [];
    if (precision != undefined) {
      args.add(precision);
    }
    var retval = _proxy.callMethod('precision', args);
    if (precision == undefined) {
      return retval;
    } else {
      return new Projection._(retval);
    }
  }

  /// Wrap the specified stream listener, projecting input geometry.
  StreamListener stream(StreamListener listener) {
    return new StreamListener._(_proxy.callMethod('stream', [listener._proxy]));
  }
}

/// Create a standard projection from a mutable raw projection.
Function projectionMutator(Function rawFactory) {
  return _geo.callMethod('projectionMutator', [rawFactory]);
}

/// The Albers equal-area conic projection.
Projection albers() {
  return new Projection._(_geo.callMethod('albers'));
}

/// A composite Albers projection for the United States.
Projection albersUsa() {
  return new Projection._(_geo.callMethod('albersUsa'));
}

/// The azimuthal equal-area projection.
Projection azimuthalEqualArea() {
  return new Projection._(_geo.callMethod('azimuthalEqualArea'));
}

/// The azimuthal equidistant projection.
Projection azimuthalEquidistant() {
  return new Projection._(_geo.callMethod('azimuthalEquidistant'));
}

/// The conic conformal projection.
ConicConformal conicConformal() {
  return new ConicConformal._(_geo.callMethod('conicConformal'));
}

class ConicConformal {
  final JsObject _proxy;

  ConicConformal._(this._proxy);

  /// Get or set the projection's two standard parallels.
  parallels([List parallels = undefined]) {
    var args = [];
    if (parallels != undefined) {
      args.add(parallels);
    }
    var retval = _proxy.callMethod('parallels', args);
    if (parallels == undefined) {
      return retval;
    } else {
      return new ConicConformal._(retval);
    }
  }
}

/// The conic equal-area (a.k.a. Albers) projection.
ConicEqualArea conicEqualArea() {
  return new ConicEqualArea._(_geo.callMethod('conicEqualArea'));
}

class ConicEqualArea {
  final JsObject _proxy;

  ConicEqualArea._(this._proxy);

  /// Get or set the projection's two standard parallels.
  parallels([List parallels = undefined]) {
    var args = [];
    if (parallels != undefined) {
      args.add(parallels);
    }
    var retval = _proxy.callMethod('parallels', args);
    if (parallels == undefined) {
      return retval;
    } else {
      return new ConicEqualArea._(retval);
    }
  }
}

/// The conic equidistant projection.
ConicEquidistant conicEquidistant() {
  return new ConicEquidistant._(_geo.callMethod('conicEquidistant'));
}

class ConicEquidistant {
  final JsObject _proxy;

  ConicEquidistant._(this._proxy);

  /// Get or set the projection's two standard parallels.
  parallels([List parallels = undefined]) {
    var args = [];
    if (parallels != undefined) {
      args.add(parallels);
    }
    var retval = _proxy.callMethod('parallels', args);
    if (parallels == undefined) {
      return retval;
    } else {
      return new ConicEquidistant._(retval);
    }
  }
}

/// The equirectangular (plate carreé) projection.
Projection equirectangular() {
  return new Projection._(_geo.callMethod('equirectangular'));
}

/// The gnomonic projection.
Projection gnomonic() {
  return new Projection._(_geo.callMethod('gnomonic'));
}

/// The spherical Mercator projection.
Projection mercator() {
  return new Projection._(_geo.callMethod('mercator'));
}

/// The azimuthal orthographic projection.
Projection orthographic() {
  return new Projection._(_geo.callMethod('orthographic'));
}

/// The azimuthal stereographic projection.
Projection stereographic() {
  return new Projection._(_geo.callMethod('stereographic'));
}

/// The transverse Mercator projection.
Projection transverseMercator() {
  return new Projection._(_geo.callMethod('transverseMercator'));
}

Projection albersRaw(num a0, num a1) {
  return new Projection._(_geo['albers'].callMethod('raw', [a0, a1]));
}

/// The raw azimuthal equal-area projection.
Projection get azimuthalEqualAreaRaw {
  return new Projection._(_geo['azimuthalEqualArea']['raw']);
}

/// The azimuthal equidistant projection.
Projection get azimuthalEquidistantRaw {
  return new Projection._(_geo['azimuthalEquidistant']['raw']);
}

/// The raw conic conformal projection.
Projection conicConformalRaw(num a0, num a1) {
  return new Projection._(_geo['conicConformal'].callMethod('raw', [a0, a1]));
}

/// The raw conic equal-area (a.k.a. Albers) projection.
Projection conicEqualAreaRaw(num a0, num a1) {
  return new Projection._(_geo['conicEqualArea'].callMethod('raw', [a0, a1]));
}

/// The raw conic equidistant projection.
Projection conicEquidistantRaw(num a0, num a1) {
  return new Projection._(_geo['conicEquidistant'].callMethod('raw', [a0, a1]));
}

/// The raw equirectangular (plate carrée) projection.
Projection get equirectangularRaw {
  return new Projection._(_geo['equirectangular']['raw']);
}

/// The raw gnomonic projection.
Projection get gnomonicRaw {
  return new Projection._(_geo['gnomonic']['raw']);
}

/// The raw Mercator projection.
Projection get mercatorRaw {
  return new Projection._(_geo['mercator']['raw']);
}

/// The raw azimuthal orthographic projection.
Projection get orthographicRaw {
  return new Projection._(_geo['orthographic']['raw']);
}

/// The raw azimuthal stereographic projection.
Projection get stereographicRaw {
  return new Projection._(_geo['stereographic']['raw']);
}

/// Convert a GeoJSON object to a geometry stream.
StreamListener stream(Map object, StreamListener listener) {
  var args = [new JsObject.jsify(object), listener._proxy];
  return new StreamListener._(_geo.callMethod('stream', args));
}

class StreamListener {
  final JsObject _proxy;

  StreamListener._(this._proxy);

  /// Indicate an x, y (and optionally z) coordinate.
  point(num x, num y, [num z = undefined]) {
    var args = [x, y];
    if (z != undefined) {
      args.add(z);
    }
    var retval = _proxy.callMethod('point', args);
    return new StreamListener._(retval);
  }

  /// Indicate the start of a line or ring.
  lineStart() => new StreamListener._(_proxy.callMethod('lineStart'));

  /// Indicate the end of a line or ring.
  lineEnd() => new StreamListener._(_proxy.callMethod('lineEnd'));

  /// Indicate the start of a polygon.
  polygonStart() => new StreamListener._(_proxy.callMethod('polygonStart'));

  /// Indicate the end of a polygon.
  polygonEnd() => new StreamListener._(_proxy.callMethod('polygonEnd'));

  /// Indicate a sphere.
  sphere() => new StreamListener._(_proxy.callMethod('sphere'));
}

/// Transform streaming geometries.
StreamTransform transform(Map methods) {
  var args = [new JsObject.jsify(methods)];
  return new StreamTransform._(_geo.callMethod('transform', args));
}

class StreamTransform {
  final JsObject _proxy;

  StreamTransform._(this._proxy);

  /// Wraps a given stream.
  StreamListener stream(StreamListener listener) {
    return new StreamListener._(_proxy.callMethod('stream', [listener._proxy]));
  }
}

/// A stream transform that clips geometries to a given axis-aligned rectangle.
ClipExtent clipExtent() => new ClipExtent._(_geo.callMethod('clipExtent'));

class ClipExtent {
  final JsObject _proxy;

  ClipExtent._(this._proxy);

  /// Sets the clip extent.
  extent([List extent = undefined]) {
    var args = [];
    if (extent != undefined) {
      args.add(extent);
    }
    var retval = _proxy.callMethod('extent', args);
    if (extent == undefined) {
      return retval;
    } else {
      return new ClipExtent._(retval);
    }
  }
}
