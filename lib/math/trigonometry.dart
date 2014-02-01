part of d3.math;

const double pi = math.PI,
  tau = 2 * pi,
  halfpi = pi / 2,
  epsilon = 1e-6,
  epsilon2 = epsilon * epsilon,
  radians = pi / 180,
  degrees = 180 / pi;

int sgn(num x) {
  return x > 0 ? 1 : x < 0 ? -1 : 0;
}

// Returns the 2D cross product of AB and AC vectors, i.e., the z-component of
// the 3D cross product in a quadrant I Cartesian coordinate system (+x is
// right, +y is up). Returns a positive value if ABC is counter-clockwise,
// negative if clockwise, and zero if the points are collinear.
num cross2d(List<num> a, List<num> b, List<num> c) {
  return (b[0] - a[0]) * (c[1] - a[1]) - (b[1] - a[1]) * (c[0] - a[0]);
}

double acos(num x) {
  return x > 1 ? 0 : x < -1 ? pi : math.acos(x);
}

double asin(num x) {
  return x > 1 ? halfpi : x < -1 ? -halfpi : math.asin(x);
}

double sinh(num x) {
  return ((x = math.exp(x)) - 1 / x) / 2;
}

double cosh(num x) {
  return ((x = math.exp(x)) + 1 / x) / 2;
}

double tanh(num x) {
  return ((x = math.exp(2 * x)) - 1) / (x + 1);
}

double haversin(num x) {
  return (x = math.sin(x / 2)) * x;
}
