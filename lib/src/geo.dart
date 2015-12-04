@JS('d3.geo')
library d3.src.geo;

import 'package:js/js.dart';

/// Create a new geographic path generator.
external Path path();

@JS()
class Path {
  /// Project the specified feature and render it to the context.
  external path(feature, [index]);

  /// Get or set the geographic projection.
  external projection([projection]);

  /// Get or set the render context.
  external context([context]);

  /// Compute the projected area of a given feature.
  external area(feature);

  /// Compute the projected centroid of a given feature.
  external centroid(feature);

  /// Compute the projected bounds of a given feature.
  external bounds(feature);

  /// Get or set the radius to display point features.
  external pointRadius([radius]);
}

/// Create a graticule generator.
external Graticule graticule();

@JS()
class Graticule {
  /// Generate a MultiLineString of meridians and parallels.
  external graticule();

  /// Generate an array of LineStrings of meridians and parallels.
  external lines();

  /// Generate a Polygon of the graticule’s extent.
  external outline();

  /// Get or set the major & minor extents.
  external extent(extent);

  /// Get or set the major extent.
  external majorExtent(extent);

  /// Get or set the minor extent.
  external minorExtent(extent);

  /// Get or set the major & minor step intervals.
  external step(step);

  /// Get or set the major step intervals.
  external majorStep(step);

  /// Get or set the minor step intervals.
  external minorStep(step);

  /// Get or set the latitudinal precision.
  external precision(precision);
}

/// Create a circle generator.
external Circle circle();

@JS()
class Circle {
  /// Generate a piecewise circle as a Polygon.
  external circle(arguments);

  /// Specify the origin in latitude and longitude.
  external origin([origin]);

  /// Specify the angular radius in degrees.
  external angle([angle]);

  /// Specify the precision of the piecewise circle.
  external precision([precision]);
}

/// Compute the spherical area of a given feature.
external area(feature);

/// Compute the spherical centroid of a given feature.
external centroid(feature);

/// Compute the latitude-longitude bounding box for a given feature.
external bounds(feature);

/// Compute the great-arc distance between two points.
external distance(a, b);

/// Compute the length of a line string or the perimeter of a polygon.
external length(feature);

/// Interpolate between two points along a great arc.
external interpolate(a, b);

/// Create a rotation function for the specified angles [λ, φ, γ].
external Rotation rotation(rotate);

@JS()
class Rotation {
  /// Rotate the given location around the sphere.
  external rotation(location);

  /// Inverse-rotate the given location around the sphere.
  external invert(location);
}

/// Create a standard projection from a raw projection.
external Projection projection(raw);

@JS()
class Projection {
  /// Project the specified location.
  external projection(location);

  /// Invert the projection for the specified point.
  external invert(point);

  /// Get or set the projection’s three-axis rotation.
  external rotate([rotation]);

  /// Get or set the projection’s center location.
  external center([location]);

  /// Get or set the projection’s translation position.
  external translate([point]);

  /// Get or set the projection’s scale factor.
  external scale([scale]);

  /// Get or set the radius of the projection’s clip circle.
  external clipAngle(angle);

  /// Get or set the projection’s viewport clip extent, in pixels.
  external clipExtent(extent);

  /// Get or set the precision threshold for adaptive resampling.
  external precision(precision);

  /// Wrap the specified stream listener, projecting input geometry.
  external stream(listener);
}

/// Create a standard projection from a mutable raw projection.
external Function projectionMutator(rawFactory);

/// The Albers equal-area conic projection.
external albers();

/// A composite Albers projection for the United States.
external albersUsa();

/// The azimuthal equal-area projection.
external azimuthalEqualArea();

/// The azimuthal equidistant projection.
external azimuthalEquidistant();

/// The conic conformal projection.
external ConicConformal conicConformal();

@JS()
class ConicConformal {
  /// Get or set the projection's two standard parallels.
  external parallels([parallels]);
}

/// The conic equal-area (a.k.a. Albers) projection.
external ConicEqualArea conicEqualArea();

@JS()
class ConicEqualArea {
  /// Get or set the projection's two standard parallels.
  external parallels([parallels]);
}

/// The conic equidistant projection.
external ConicEquidistant conicEquidistant();

@JS()
class ConicEquidistant {
  /// Get or set the projection's two standard parallels.
  external parallels([parallels]);
}

/// The equirectangular (plate carreé) projection.
external equirectangular();

/// The gnomonic projection.
external gnomonic();

/// The spherical Mercator projection.
external mercator();

/// The azimuthal orthographic projection.
external orthographic();

/// The azimuthal stereographic projection.
external stereographic();

/// The transverse Mercator projection.
external transverseMercator();

@JS('albers.raw')
external albersRaw(a0, a1);

/// The raw azimuthal equal-area projection.
@JS('azimuthalEqualArea.raw')
external get azimuthalEqualAreaRaw;

/// The azimuthal equidistant projection.
@JS('azimuthalEquidistant.raw')
external get azimuthalEquidistantRaw;

/// The raw conic conformal projection.
@JS('conicConformal.raw')
external conicConformalRaw(a0, a1);

/// The raw conic equal-area (a.k.a. Albers) projection.
@JS('conicEqualArea.raw')
external conicEqualAreaRaw(a0, a1);

/// The raw conic equidistant projection.
@JS('conicEquidistant.raw')
external conicEquidistantRaw(a0, a1);

/// The raw equirectangular (plate carrée) projection.
@JS('equirectangular.raw')
external get equirectangularRaw;

/// The raw gnomonic projection.
@JS('gnomonic.raw')
external get gnomonicRaw;

/// The raw Mercator projection.
@JS('mercator.raw')
external get mercatorRaw;

/// The raw azimuthal orthographic projection.
@JS('orthographic.raw')
external get orthographicRaw;

/// The raw azimuthal stereographic projection.
@JS('stereographic.raw')
external get stereographicRaw;

/// Convert a GeoJSON object to a geometry stream.
external StreamListener stream(object, listener);

@JS()
class StreamListener {
  /// Indicate an x, y (and optionally z) coordinate.
  external point(x, y, [z]);

  /// Indicate the start of a line or ring.
  external lineStart();

  /// Indicate the end of a line or ring.
  external lineEnd();

  /// Indicate the start of a polygon.
  external polygonStart();

  /// Indicate the end of a polygon.
  external polygonEnd();

  /// Indicate a sphere.
  external sphere();
}

/// Transform streaming geometries.
external StreamTransform transform(methods);

@JS()
class StreamTransform {
  /// Wraps a given stream.
  external stream(listener);
}

/// A stream transform that clips geometries to a given axis-aligned rectangle.
external ClipExtent clipExtent();

@JS()
class ClipExtent {
  /// Sets the clip extent.
  external extent([extent]);
}
