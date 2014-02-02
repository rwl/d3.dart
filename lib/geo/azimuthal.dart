part of d3.geo;

// Abstract azimuthal projection.
class Azimuthal {
  Function scale, angle;

  Azimuthal(this.scale, this.angle);

  azimuthal(lambda, phi) {
    var coslambda = math.cos(lambda),
        cosphi = math.cos(phi),
        k = scale(coslambda * cosphi);
    return [
      k * cosphi * math.sin(lambda),
      k * math.sin(phi)
    ];
  }

  invert(x, y) {
    var rho = math.sqrt(x * x + y * y),
        c = angle(rho),
        sinc = math.sin(c),
        cosc = math.cos(c);
    return [
      math.atan2(x * sinc, rho * cosc),
      math.asin(rho > 0 ? y * sinc / rho : 0)
    ];
  }
}
