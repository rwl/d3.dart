library d3.src.geo;

import 'dart:js';

JsObject _geo = context['d3']['geo'];

/// Create a new geographic path generator.
Path path() {
  return _geo.callMethod('path', []);
}

class Path {
  final JsObject _proxy;

  Path._(this._proxy);

  call(feature, [index]) => path(feature, index);

  /// Project the specified feature and render it to the context.
  path(feature, [index]) {
    return _proxy.callMethod('path', []);
  }

  /// Get or set the geographic projection.
  projection([projection]) {
    return _proxy.callMethod('projection', []);
  }

  /// Get or set the render context.
  context([context]) {
    return _proxy.callMethod('context', []);
  }

  /// Compute the projected area of a given feature.
  area(feature) {
    return _proxy.callMethod('area', []);
  }

  /// Compute the projected centroid of a given feature.
  centroid(feature) {
    return _proxy.callMethod('centroid', []);
  }

  /// Compute the projected bounds of a given feature.
  bounds(feature) {
    return _proxy.callMethod('bounds', []);
  }

  /// Get or set the radius to display point features.
  pointRadius([radius]) {
    return _proxy.callMethod('pointRadius', []);
  }
}

/// Create a graticule generator.
Graticule graticule() {
  return _geo.callMethod('graticule', []);
}

class Graticule {
  final JsObject _proxy;

  Graticule._(this._proxy);

  call() => graticule();

  /// Generate a MultiLineString of meridians and parallels.
  graticule() {
    return _proxy.callMethod('graticule', []);
  }

  /// Generate an array of LineStrings of meridians and parallels.
  lines() {
    return _proxy.callMethod('lines', []);
  }

  /// Generate a Polygon of the graticule's extent.
  outline() {
    return _proxy.callMethod('outline', []);
  }

  /// Get or set the major & minor extents.
  extent(extent) {
    return _proxy.callMethod('extent', []);
  }

  /// Get or set the major extent.
  majorExtent(extent) {
    return _proxy.callMethod('majorExtent', []);
  }

  /// Get or set the minor extent.
  minorExtent(extent) {
    return _proxy.callMethod('minorExtent', []);
  }

  /// Get or set the major & minor step intervals.
  step(step) {
    return _proxy.callMethod('step', []);
  }

  /// Get or set the major step intervals.
  majorStep(step) {
    return _proxy.callMethod('majorStep', []);
  }

  /// Get or set the minor step intervals.
  minorStep(step) {
    return _proxy.callMethod('minorStep', []);
  }

  /// Get or set the latitudinal precision.
  precision(precision) {
    return _proxy.callMethod('precision', []);
  }
}

/// Create a circle generator.
Circle circle() {
  return _geo.callMethod('circle', []);
}

class Circle {
  final JsObject _proxy;

  Circle._(this._proxy);

  call(arguments) => circle(arguments);

  /// Generate a piecewise circle as a Polygon.
  circle(arguments) {
    return _proxy.callMethod('circle', []);
  }

  /// Specify the origin in latitude and longitude.
  origin([origin]) {
    return _proxy.callMethod('origin', []);
  }

  /// Specify the angular radius in degrees.
  angle([angle]) {
    return _proxy.callMethod('angle', []);
  }

  /// Specify the precision of the piecewise circle.
  precision([precision]) {
    return _proxy.callMethod('precision', []);
  }
}

/// Compute the spherical area of a given feature.
area(feature) {
  return _geo.callMethod('area', []);
}

/// Compute the spherical centroid of a given feature.
centroid(feature) {
  return _geo.callMethod('centroid', []);
}

/// Compute the latitude-longitude bounding box for a given feature.
bounds(feature) {
  return _geo.callMethod('bounds', []);
}

/// Compute the great-arc distance between two points.
distance(a, b) {
  return _geo.callMethod('distance', []);
}

/// Compute the length of a line string or the perimeter of a polygon.
length(feature) {
  return _geo.callMethod('length', []);
}

/// Interpolate between two points along a great arc.
interpolate(a, b) {
  return _geo.callMethod('interpolate', []);
}

/// Create a rotation function for the specified angles [λ, φ, γ].
Rotation rotation(rotate) {
  return _geo.callMethod('rotation', []);
}

class Rotation {
  final JsObject _proxy;

  Rotation._(this._proxy);

  call(location) => rotation(location);

  /// Rotate the given location around the sphere.
  rotation(location) {
    return _proxy.callMethod('rotation', []);
  }

  /// Inverse-rotate the given location around the sphere.
  invert(location) {
    return _proxy.callMethod('invert', []);
  }
}

/// Create a standard projection from a raw projection.
Projection projection(raw) {
  return _geo.callMethod('projection', []);
}

class Projection {
  final JsObject _proxy;

  Projection._(this._proxy);

  call(location) => projection(location);

  /// Project the specified location.
  projection(location) {
    return _proxy.callMethod('projection', []);
  }

  /// Invert the projection for the specified point.
  invert(point) {
    return _proxy.callMethod('invert', []);
  }

  /// Get or set the projection's three-axis rotation.
  rotate([rotation]) {
    return _proxy.callMethod('rotate', []);
  }

  /// Get or set the projection's center location.
  center([location]) {
    return _proxy.callMethod('center', []);
  }

  /// Get or set the projection's translation position.
  translate([point]) {
    return _proxy.callMethod('translate', []);
  }

  /// Get or set the projection's scale factor.
  scale([scale]) {
    return _proxy.callMethod('scale', []);
  }

  /// Get or set the radius of the projection's clip circle.
  clipAngle(angle) {
    return _proxy.callMethod('clipAngle', []);
  }

  /// Get or set the projection's viewport clip extent, in pixels.
  clipExtent(extent) {
    return _proxy.callMethod('clipExtent', []);
  }

  /// Get or set the precision threshold for adaptive resampling.
  precision(precision) {
    return _proxy.callMethod('precision', []);
  }

  /// Wrap the specified stream listener, projecting input geometry.
  stream(listener) {
    return _proxy.callMethod('stream', []);
  }
}

/// Create a standard projection from a mutable raw projection.
Function projectionMutator(rawFactory) {
  return _geo.callMethod('projectionMutator', []);
}

/// The Albers equal-area conic projection.
albers() {
  return _geo.callMethod('albers', []);
}

/// A composite Albers projection for the United States.
albersUsa() {
  return _geo.callMethod('albersUsa', []);
}

/// The azimuthal equal-area projection.
azimuthalEqualArea() {
  return _geo.callMethod('azimuthalEqualArea', []);
}

/// The azimuthal equidistant projection.
azimuthalEquidistant() {
  return _geo.callMethod('azimuthalEquidistant', []);
}

/// The conic conformal projection.
ConicConformal conicConformal() {
  return _geo.callMethod('conicConformal', []);
}

class ConicConformal {
  final JsObject _proxy;

  ConicConformal._(this._proxy);

  /// Get or set the projection's two standard parallels.
  parallels([parallels]) {
    return _proxy.callMethod('parallels', []);
  }
}

/// The conic equal-area (a.k.a. Albers) projection.
ConicEqualArea conicEqualArea() {
  return _geo.callMethod('conicEqualArea', []);
}

class ConicEqualArea {
  final JsObject _proxy;

  ConicEqualArea._(this._proxy);

  /// Get or set the projection's two standard parallels.
  parallels([parallels]) {
    return _proxy.callMethod('parallels', []);
  }
}

/// The conic equidistant projection.
ConicEquidistant conicEquidistant() {
  return _geo.callMethod('conicEquidistant', []);
}

class ConicEquidistant {
  final JsObject _proxy;

  ConicEquidistant._(this._proxy);

  /// Get or set the projection's two standard parallels.
  parallels([parallels]) {
    return _proxy.callMethod('parallels', []);
  }
}

/// The equirectangular (plate carreé) projection.
equirectangular() {
  return _geo.callMethod('equirectangular', []);
}

/// The gnomonic projection.
gnomonic() {
  return _geo.callMethod('gnomonic', []);
}

/// The spherical Mercator projection.
mercator() {
  return _geo.callMethod('mercator', []);
}

/// The azimuthal orthographic projection.
orthographic() {
  return _geo.callMethod('orthographic', []);
}

/// The azimuthal stereographic projection.
stereographic() {
  return _geo.callMethod('stereographic', []);
}

/// The transverse Mercator projection.
transverseMercator() {
  return _geo.callMethod('transverseMercator', []);
}

albersRaw(a0, a1) {
  return _geo['albers'].callMethod('raw', []);
}

/// The raw azimuthal equal-area projection.
get azimuthalEqualAreaRaw => _geo['azimuthalEqualArea']['raw'];

/// The azimuthal equidistant projection.
get azimuthalEquidistantRaw => _geo['azimuthalEquidistant']['raw'];

/// The raw conic conformal projection.
conicConformalRaw(a0, a1) {
  return _geo['conicConformal'].callMethod('raw', []);
}

/// The raw conic equal-area (a.k.a. Albers) projection.
conicEqualAreaRaw(a0, a1) {
  return _geo['conicEqualArea'].callMethod('raw', []);
}

/// The raw conic equidistant projection.
conicEquidistantRaw(a0, a1) {
  return _geo['conicEquidistant'].callMethod('raw', []);
}

/// The raw equirectangular (plate carrée) projection.
get equirectangularRaw => _geo['equirectangular']['raw'];

/// The raw gnomonic projection.
get gnomonicRaw => _geo['gnomonic']['raw'];

/// The raw Mercator projection.
get mercatorRaw => _geo['mercator']['raw'];

/// The raw azimuthal orthographic projection.
get orthographicRaw => _geo['orthographic']['raw'];

/// The raw azimuthal stereographic projection.
get stereographicRaw => _geo['stereographic']['raw'];

/// Convert a GeoJSON object to a geometry stream.
StreamListener stream(object, listener) {
  return _geo.callMethod('stream', []);
}

class StreamListener {
  final JsObject _proxy;

  StreamListener._(this._proxy);

  /// Indicate an x, y (and optionally z) coordinate.
  point(x, y, [z]) {
    return _proxy.callMethod('point', []);
  }

  /// Indicate the start of a line or ring.
  lineStart() {
    return _proxy.callMethod('lineStart', []);
  }

  /// Indicate the end of a line or ring.
  lineEnd() {
    return _proxy.callMethod('lineEnd', []);
  }

  /// Indicate the start of a polygon.
  polygonStart() {
    return _proxy.callMethod('polygonStart', []);
  }

  /// Indicate the end of a polygon.
  polygonEnd() {
    return _proxy.callMethod('polygonEnd', []);
  }

  /// Indicate a sphere.
  sphere() {
    return _proxy.callMethod('sphere', []);
  }
}

/// Transform streaming geometries.
StreamTransform transform(methods) {
  return _geo.callMethod('transform', []);
}

class StreamTransform {
  final JsObject _proxy;

  StreamTransform._(this._proxy);

  /// Wraps a given stream.
  stream(listener) {
    return _proxy.callMethod('stream', []);
  }
}

/// A stream transform that clips geometries to a given axis-aligned rectangle.
ClipExtent clipExtent() {
  return _geo.callMethod('clipExtent', []);
}

class ClipExtent {
  final JsObject _proxy;

  ClipExtent._(this._proxy);

  /// Sets the clip extent.
  extent([extent]) {
    return _proxy.callMethod('extent', []);
  }
}
