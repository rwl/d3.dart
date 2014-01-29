part of d3.svg;

double arcOffset = -halfpi,
  arcMax = tau - epsilon;

const fracDigits = 0;

class Arc {

  double innerRadius, outerRadius, startAngle, endAngle;

  String arc() {
    final double r0 = innerRadius,
        r1 = outerRadius;
    double a0 = startAngle + arcOffset,
        a1 = endAngle + arcOffset,
        da;
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
        return "M0,${r1.toStringAsFixed(fracDigits)}A${r1.toStringAsFixed(fracDigits)},${r1.toStringAsFixed(fracDigits)} 0 1,1 0,${(-r1).toStringAsFixed(fracDigits)}"
          + "A${r1.toStringAsFixed(fracDigits)},${r1.toStringAsFixed(fracDigits)} 0 1,1 0,${r1.toStringAsFixed(fracDigits)}"
          + "M0,${r0.toStringAsFixed(fracDigits)}A${r0.toStringAsFixed(fracDigits)},${r0.toStringAsFixed(fracDigits)} 0 1,0 0,${(-r0).toStringAsFixed(fracDigits)}"
          + "A${r0.toStringAsFixed(fracDigits)},${r0.toStringAsFixed(fracDigits)} 0 1,0 0,${r0.toStringAsFixed(fracDigits)}Z";
      } else {
        return "M0,${r1.toStringAsFixed(fracDigits)}"
          + "A${r1.toStringAsFixed(fracDigits)},${r1.toStringAsFixed(fracDigits)} 0 1,1 0,${(-r1).toStringAsFixed(fracDigits)}"
          + "A${r1.toStringAsFixed(fracDigits)},${r1.toStringAsFixed(fracDigits)} 0 1,1 0,${r1.toStringAsFixed(fracDigits)}"
          + "Z";
      }
    } else {
      if (r0 != 0) {
        return "M${(r1 * c0).toStringAsFixed(fracDigits)},${(r1 * s0).toStringAsFixed(fracDigits)}"
          + "A${r1.toStringAsFixed(fracDigits)},${r1.toStringAsFixed(fracDigits)} 0 ${df},1 ${(r1 * c1).toStringAsFixed(fracDigits)},${(r1 * s1).toStringAsFixed(fracDigits)}"
          + "L${(r0 * c1).toStringAsFixed(fracDigits)},${(r0 * s1).toStringAsFixed(fracDigits)}"
          + "A${r0.toStringAsFixed(fracDigits)},${r0.toStringAsFixed(fracDigits)} 0 ${df},0 ${(r0 * c0).toStringAsFixed(fracDigits)},${(r0 * s0).toStringAsFixed(fracDigits)}"
          + "Z";
      } else {
        return "M${(r1 * c0).toStringAsFixed(fracDigits)},${(r1 * s0).toStringAsFixed(fracDigits)}"
          + "A${r1.toStringAsFixed(fracDigits)},${r1.toStringAsFixed(fracDigits)} 0 ${df},1 ${(r1 * c1).toStringAsFixed(fracDigits)},${(r1 * s1).toStringAsFixed(fracDigits)}"
          + "L0,0"
          + "Z";
      }
    }
  }

  List<double> centroid() {
    var r = (innerRadius + outerRadius) / 2,
        a = (startAngle
        + endAngle) / 2 + arcOffset;
    return [math.cos(a) * r, math.sin(a) * r];
  }

}