part of d3.geo;

var geo_azimuthalEquidistant = new Azimuthal(
  (coslambdacosphi) { var c = math.acos(coslambdacosphi); return c && c / math.sin(c); },
  core.identity
);

var azimuthalEquidistant = () {
  return projection(geo_azimuthalEquidistant);
};
