@JS('d3.geo')
library d3.src.geo;

import 'package:js/js.dart';

/// create a new geographic path generator.
external Path path();

@JS()
class Path {
  /// project the specified feature and render it to the context.
  external path(feature, [index]);

  /// get or set the geographic projection.
  external projection([projection]);

  /// get or set the render context.
  external context([context]);

  /// compute the projected area of a given feature.
  external area(feature);

  /// compute the projected centroid of a given feature.
  external centroid(feature);

  /// compute the projected bounds of a given feature.
  external bounds(feature);

  /// get or set the radius to display point features.
  external pointRadius([radius]);
}

/// create a graticule generator.
external Graticule graticule();

@JS()
class Graticule {
  /// generate a MultiLineString of meridians and parallels.
  external graticule();

  /// generate an array of LineStrings of meridians and parallels.
  external lines();

  /// generate a Polygon of the graticule’s extent.
  external outline();

  /// get or set the major & minor extents.
  external extent(extent);

  /// get or set the major extent.
  external majorExtent(extent);

  /// get or set the minor extent.
  external minorExtent(extent);

  /// get or set the major & minor step intervals.
  external step(step);

  /// get or set the major step intervals.
  external majorStep(step);

  /// get or set the minor step intervals.
  external minorStep(step);

  /// get or set the latitudinal precision.
  external precision(precision);
}

/// create a circle generator.
external Circle circle();

@JS()
class Circle {
  /// generate a piecewise circle as a Polygon.
  external circle(arguments);

  /// specify the origin in latitude and longitude.
  external origin([origin]);

  /// specify the angular radius in degrees.
  external angle([angle]);

  /// specify the precision of the piecewise circle.
  external precision([precision]);
}

/// compute the spherical area of a given feature.
external area(feature);

/// compute the spherical centroid of a given feature.
external centroid(feature);

/// compute the latitude-longitude bounding box for a given feature.
external bounds(feature);

/// compute the great-arc distance between two points.
external distance(a, b);

/// compute the length of a line string or the perimeter of a polygon.
external length(feature);

/// interpolate between two points along a great arc.
external interpolate(a, b);

/// create a rotation function for the specified angles [λ, φ, γ].
external Rotation rotation(rotate);

@JS()
class Rotation {
  /// rotate the given location around the sphere.
  external rotation(location);

  /// inverse-rotate the given location around the sphere.
  external invert(location);
}

/// create a standard projection from a raw projection.
external Projection projection(raw);

@JS()
class Projection {
  /// project the specified location.
  external projection(location);

  /// invert the projection for the specified point.
  external invert(point);

  /// get or set the projection’s three-axis rotation.
  external rotate([rotation]);

  /// get or set the projection’s center location.
  external center([location]);

  /// get or set the projection’s translation position.
  external translate([point]);

  /// get or set the projection’s scale factor.
  external scale([scale]);

  /// get or set the radius of the projection’s clip circle.
  external clipAngle(angle);

  /// get or set the projection’s viewport clip extent, in pixels.
  external clipExtent(extent);

  /// get or set the precision threshold for adaptive resampling.
  external precision(precision);

  /// wrap the specified stream listener, projecting input geometry.
  external stream(listener);
}

/// create a standard projection from a mutable raw projection.
external Function projectionMutator(rawFactory);

/// the Albers equal-area conic projection.
external albers();

/// a composite Albers projection for the United States.
external albersUsa();

/// the azimuthal equal-area projection.
external azimuthalEqualArea();

/// the azimuthal equidistant projection.
external azimuthalEquidistant();

/// the conic conformal projection.
external ConicConformal conicConformal();

@JS()
class ConicConformal {
  /// get or set the projection's two standard parallels.
  external parallels([parallels]);
}

/// the conic equal-area (a.k.a. Albers) projection.
external ConicEqualArea conicEqualArea();

@JS()
class ConicEqualArea {
  /// get or set the projection's two standard parallels.
  external parallels([parallels]);
}

/// the conic equidistant projection.
external ConicEquidistant conicEquidistant();

@JS()
class ConicEquidistant {
  /// get or set the projection's two standard parallels.
  external parallels([parallels]);
}

/// the equirectangular (plate carreé) projection.
external equirectangular();

/// the gnomonic projection.
external gnomonic();

/// the spherical Mercator projection.
external mercator();

/// the azimuthal orthographic projection.
external orthographic();

/// the azimuthal stereographic projection.
external stereographic();

/// the transverse Mercator projection.
external transverseMercator();

@JS('albers.raw')
external albersRaw(a0, a1);

/// the raw azimuthal equal-area projection.
@JS('azimuthalEqualArea.raw')
external get azimuthalEqualAreaRaw;

/// the azimuthal equidistant projection.
@JS('azimuthalEquidistant.raw')
external get azimuthalEquidistantRaw;

/// the raw conic conformal projection.
@JS('conicConformal.raw')
external conicConformalRaw(a0, a1);

/// the raw conic equal-area (a.k.a. Albers) projection.
@JS('conicEqualArea.raw')
external conicEqualAreaRaw(a0, a1);

/// the raw conic equidistant projection.
@JS('conicEquidistant.raw')
external conicEquidistantRaw(a0, a1);

/// the raw equirectangular (plate carrée) projection.
@JS('equirectangular.raw')
external get equirectangularRaw;

/// the raw gnomonic projection.
@JS('gnomonic.raw')
external get gnomonicRaw;

/// the raw Mercator projection.
@JS('mercator.raw')
external get mercatorRaw;

/// the raw azimuthal orthographic projection.
@JS('orthographic.raw')
external get orthographicRaw;

/// the raw azimuthal stereographic projection.
@JS('stereographic.raw')
external get stereographicRaw;

/// convert a GeoJSON object to a geometry stream.
external StreamListener stream(object, listener);

@JS()
class StreamListener {
  /// indicate an x, y (and optionally z) coordinate.
  external point(x, y, [z]);

  /// indicate the start of a line or ring.
  external lineStart();

  /// indicate the end of a line or ring.
  external lineEnd();

  /// indicate the start of a polygon.
  external polygonStart();

  /// indicate the end of a polygon.
  external polygonEnd();

  /// indicate a sphere.
  external sphere();
}

/// transform streaming geometries.
external StreamTransform transform(methods);

@JS()
class StreamTransform {
  /// wraps a given stream.
  external stream(listener);
}

/// a stream transform that clips geometries to a given axis-aligned rectangle.
external ClipExtent clipExtent();

@JS()
class ClipExtent {
  /// sets the clip extent.
  external extent([extent]);
}
