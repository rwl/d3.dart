part of d3.geo;

var geo_azimuthalEqualArea = new Azimuthal(
  (coslambdacosphi) { return math.sqrt(2 / (1 + coslambdacosphi)); },
  (rho) { return 2 * math.asin(rho / 2); }
);

var azimuthalEqualArea = () {
  return projection(geo_azimuthalEqualArea);
};