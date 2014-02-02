part of d3.geo;

class ConicEqualArea {
  double phi0, phi1, sinphi0, n, C, rho0;

  ConicEqualArea(this.phi0, this.phi1) {
    this.sinphi0 = math.sin(phi0);
    this.n = (sinphi0 + math.sin(phi1)) / 2;
    this.C = 1 + sinphi0 * (2 * n - sinphi0);
    this.rho0 = math.sqrt(C) / n;
  }

  forward(lambda, phi) {
    double rho = math.sqrt(C - 2 * n * math.sin(phi)) / n;
    return [
      rho * math.sin(lambda *= n),
      rho0 - rho * math.cos(lambda)
    ];
  }

  invert(x, y) {
    double rho0_y = rho0 - y;
    return [
      math.atan2(x, rho0_y) / n,
      asin((C - (x * x + rho0_y * rho0_y) * n * n) / (2 * n))
    ];
  }
}

conicEqualArea() {
  return new Conic(ConicEqualArea);
}