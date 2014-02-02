part of d3.geo;

class Conic {
  num phi0, phi1;
  var m, p;

  Conic(projectAt) {
    this.phi0 = 0;
    this.phi1 = pi / 3;
    this.m = new ProjectionMutator(projectAt);
    this.p = m(phi0, phi1);
  }

  parallels([arg=null]) {
    if (arg == null) {
      return [phi0 / pi * 180, phi1 / pi * 180];
    }
    return m(phi0 = arg[0] * pi / 180, phi1 = arg[1] * pi / 180);
  }
}
