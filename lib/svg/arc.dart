part of d3.svg;

double arcOffset = -halfpi;
double arcMax = tau - epsilon;

class Arc {
  num innerRadius = 0;
  num outerRadius = 100;
  num startAngle = math.PI;
  num endAngle = math.PI;

  String arc({num innerRadius:null, num outerRadius:null, num startAngle:null, num endAngle:null}) {
    final num r0 = innerRadius == null ? this.innerRadius : innerRadius;
    final num r1 = outerRadius == null ? this.outerRadius : outerRadius;

    num a0 = (startAngle == null ? this.startAngle : startAngle) + arcOffset;
    num a1 = (endAngle == null ? this.endAngle : endAngle) + arcOffset;
    num da;

    if (a1 < a0) {
      da = a0;
      a0 = a1;
      a1 = da;
    }
    da = a1 - a0;

    final String df = da < pi ? "0" : "1";

    final double c0 = math.cos(a0),
        s0 = math.sin(a0),
        c1 = math.cos(a1),
        s1 = math.sin(a1);
    if (da >= arcMax) {
      if (r0 != 0) {
        return "M0,${fmt(r1)}A${fmt(r1)},${fmt(r1)} 0 1,1 0,${fmt(-r1)}"
          + "A${fmt(r1)},${fmt(r1)} 0 1,1 0,${fmt(r1)}"
          + "M0,${fmt(r0)}A${fmt(r0)},${fmt(r0)} 0 1,0 0,${fmt(-r0)}"
          + "A${fmt(r0)},${fmt(r0)} 0 1,0 0,${fmt(r0)}Z";
      } else {
        return "M0,${fmt(r1)}"
          + "A${fmt(r1)},${fmt(r1)} 0 1,1 0,${fmt(-r1)}"
          + "A${fmt(r1)},${fmt(r1)} 0 1,1 0,${fmt(r1)}"
          + "Z";
      }
    } else {
      if (r0 != 0) {
        return "M${fmt(r1 * c0)},${fmt(r1 * s0)}"
          + "A${fmt(r1)},${fmt(r1)} 0 ${df},1 ${fmt(r1 * c1)},${fmt(r1 * s1)}"
          + "L${fmt(r0 * c1)},${fmt(r0 * s1)}"
          + "A${fmt(r0)},${fmt(r0)} 0 ${df},0 ${fmt(r0 * c0)},${fmt(r0 * s0)}"
          + "Z";
      } else {
        return "M${fmt(r1 * c0)},${fmt(r1 * s0)}"
          + "A${fmt(r1)},${fmt(r1)} 0 ${df},1 ${fmt(r1 * c1)},${fmt(r1 * s1)}"
          + "L0,0"
          + "Z";
      }
    }
  }

  List<double> centroid() {
    var r = (innerRadius + outerRadius) / 2,
        a = (startAngle + endAngle) / 2 + arcOffset;
    return [math.cos(a) * r, math.sin(a) * r];
  }
}
