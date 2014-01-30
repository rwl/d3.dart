import 'dart:math' as math;
import 'package:unittest/unittest.dart';
import 'package:d3/svg/svg.dart' as svg;

Matcher pathEquals(expected, [limit=100]) => equals(expected, limit);

void main() {
  group('arc', () {
    test('innerRadius can be defined as an argument', () {
      var a = new svg.Arc()
        ..outerRadius = 100
        ..startAngle = 0
        ..endAngle = math.PI;
      expect(a.arc(innerRadius:0), pathEquals('M0,-100A100,100 0 1,1 0,100L0,0Z'));
      expect(a.arc(innerRadius:50), pathEquals('M0,-100A100,100 0 1,1 0,100L0,50A50,50 0 1,0 0,-50Z'));
    });
    test('innerRadius can be overridden with a getter', () {
      var a = new InnerRadiusArc()
        ..outerRadius = 100
        ..startAngle = 0
        ..endAngle = math.PI;
      expect(a.arc(), pathEquals('M0,-100A100,100 0 1,1 0,100L0,42A42,42 0 1,0 0,-42Z'));
      expect(a.tested, isTrue);
    });

    test('outerRadius can be defined as an argument', () {
      var a = new svg.Arc()
        ..innerRadius = 0
        ..startAngle = 0
        ..endAngle = math.PI;
      expect(a.arc(outerRadius:50), pathEquals('M0,-50A50,50 0 1,1 0,50L0,0Z'));
      expect(a.arc(outerRadius:100), pathEquals('M0,-100A100,100 0 1,1 0,100L0,0Z'));
    });
    test('outerRadius can be overridden with a getter', () {
      var a = new OuterRadiusArc()
        ..innerRadius = 0
        ..startAngle = 0
        ..endAngle = math.PI;
      expect(a.arc(), pathEquals('M0,-42A42,42 0 1,1 0,42L0,0Z'));
      expect(a.tested, isTrue);
    });

    test('startAngle can be defined as an argument', () {
      var a = new svg.Arc()
        ..innerRadius = 0
        ..outerRadius = 100
        ..endAngle = math.PI;
      expect(a.arc(startAngle:0), pathEquals('M0,-100A100,100 0 1,1 0,100L0,0Z'));
      expect(a.arc(startAngle:math.PI/2), pathEquals('M100,0A100,100 0 0,1 0,100L0,0Z'));
    });
    test('startAngle can be overridden with a getter', () {
      var a = new StartAngleArc()
        ..innerRadius = 0
        ..outerRadius = 100
        ..endAngle = math.PI;
      expect(a.arc(), pathEquals('M0,100A100,100 0 0,1 0,100L0,0Z'));
      expect(a.tested, isTrue);
    });

    test('endAngle can be defined as an argument', () {
      var a = new svg.Arc()
        ..innerRadius = 0
        ..outerRadius = 100
        ..startAngle = 0;
      expect(a.arc(endAngle:math.PI/2), pathEquals('M0,-100A100,100 0 0,1 100,0L0,0Z'));
      expect(a.arc(endAngle:math.PI), pathEquals('M0,-100A100,100 0 1,1 0,100L0,0Z'));
    });
    test('endAngle can be overridden with a getter', () {
      var a = new EndAngleArc()
        ..innerRadius = 0
        ..outerRadius = 100
        ..startAngle = 0;
      expect(a.arc(), pathEquals('M0,-100A100,100 0 1,1 0,100L0,0Z'));
      expect(a.tested, isTrue);
    });

    test('startAngle and endAngle are swapped if endAngle is less than startAngle', () {
      var a = new svg.Arc()
        ..innerRadius = 50
        ..outerRadius = 100;
      expect(a.arc(startAngle:2*math.PI, endAngle:math.PI),
          pathEquals(a.arc(startAngle:math.PI, endAngle:2 * math.PI)));
      expect(a.arc(startAngle:-math.PI, endAngle:math.PI),
          pathEquals(a.arc(startAngle:math.PI, endAngle:-math.PI)));
    });

    test('angles are defined in radians, with zero at 12 o\'clock', () {
      var a = new svg.Arc()
        ..innerRadius = 0
        ..outerRadius = 100;
      expect(a.arc(startAngle:0, endAngle:math.PI), pathEquals('M0,-100A100,100 0 1,1 0,100L0,0Z'));
      expect(a.arc(startAngle:math.PI, endAngle:2*math.PI), pathEquals('M0,100A100,100 0 1,1 -0,-100L0,0Z'));
    });
    test('radii are defined in local coordinates (typically pixels)', () {
      var a = new svg.Arc()
        ..startAngle = 0
        ..endAngle = math.PI;
      expect(a.arc(innerRadius:0, outerRadius:100), pathEquals('M0,-100A100,100 0 1,1 0,100L0,0Z'));
      expect(a.arc(innerRadius:100, outerRadius:200), pathEquals('M0,-200A200,200 0 1,1 0,200L0,100A100,100 0 1,0 0,-100Z'));
    });
    test('draws a circle when inner radius is zero and angle is approximately 2π', () {
      var a = new svg.Arc()
        ..innerRadius = 0
        ..outerRadius = 100;
      expect(a.arc(startAngle:0, endAngle:2*math.PI-1e-9), pathEquals('M0,100A100,100 0 1,1 0,-100A100,100 0 1,1 0,100Z'));
      expect(a.arc(startAngle:math.PI+1e-9, endAngle:3*math.PI-1e-9), pathEquals('M0,100A100,100 0 1,1 0,-100A100,100 0 1,1 0,100Z'));
    });
    test('draws a circle when inner radius is zero and angle is greater than 2π', () {
      var a = new svg.Arc()
        ..innerRadius = 0
        ..outerRadius = 100;
      expect(a.arc(startAngle:0, endAngle:7), pathEquals('M0,100A100,100 0 1,1 0,-100A100,100 0 1,1 0,100Z'));
      expect(a.arc(startAngle:1, endAngle:8), pathEquals('M0,100A100,100 0 1,1 0,-100A100,100 0 1,1 0,100Z'));
    });
    test('draws a circular sector when inner radius is zero and angle is less than 2π', () {
      var a = new svg.Arc()
        ..innerRadius = 0
        ..outerRadius = 100;
      expect(a.arc(startAngle:0, endAngle:math.PI / 2), pathEquals('M0,-100A100,100 0 0,1 100,0L0,0Z'));
    });
    test('draws an annulus when inner radius is non-zero and angle is approximately 2π', () {
      var a = new svg.Arc()
        ..innerRadius = 100
        ..outerRadius = 200;
      expect(a.arc(startAngle:0, endAngle:2*math.PI-1e-9), pathEquals('M0,200A200,200 0 1,1 0,-200A200,200 0 1,1 0,200M0,100A100,100 0 1,0 0,-100A100,100 0 1,0 0,100Z'));
      expect(a.arc(startAngle:math.PI+1e-9, endAngle:3*math.PI-1e-9), pathEquals('M0,200A200,200 0 1,1 0,-200A200,200 0 1,1 0,200M0,100A100,100 0 1,0 0,-100A100,100 0 1,0 0,100Z'));
    });
    test('draws an annulus when inner radius is non-zero and angle is greater than 2π', () {
      var a = new svg.Arc()
        ..innerRadius = 100
        ..outerRadius = 200;
      expect(a.arc(startAngle:0, endAngle:7), pathEquals('M0,200A200,200 0 1,1 0,-200A200,200 0 1,1 0,200M0,100A100,100 0 1,0 0,-100A100,100 0 1,0 0,100Z'));
      expect(a.arc(startAngle:-1, endAngle:6), pathEquals('M0,200A200,200 0 1,1 0,-200A200,200 0 1,1 0,200M0,100A100,100 0 1,0 0,-100A100,100 0 1,0 0,100Z'));
    });
    test('draws an annular sector when both radii are non-zero and angle is less than 2π', () {
      var a = new svg.Arc()
        ..innerRadius = 100
        ..outerRadius = 200;
      expect(a.arc(startAngle:0, endAngle:math.PI / 2), pathEquals('M0,-200A200,200 0 0,1 200,0L100,0A100,100 0 0,0 0,-100Z'));
    });

    test('computes the centroid as mid-radius and mid-angle', () {
      var c = (new svg.Arc()
        ..innerRadius = 0
        ..outerRadius = 100
        ..startAngle = 0
        ..endAngle = 2 * math.PI).centroid();
      expect(c[0], closeTo(0, 1e-6));
      expect(c[1], closeTo(50, 1e-6));
      c = (new svg.Arc()
        ..innerRadius = 100
        ..outerRadius = 200
        ..startAngle = math.PI
        ..endAngle = 2 * math.PI).centroid();
      expect(c[0], closeTo(-150, 1e-6));
      expect(c[1], closeTo(0, 1e-6));
    });
  });
}

class InnerRadiusArc extends svg.Arc {
  bool tested = false;
  double get innerRadius {
    tested = true;;
    return 42.0;
  }
}

class OuterRadiusArc extends svg.Arc {
  bool tested = false;
  double get outerRadius {
    tested = true;;
    return 42.0;
  }
}

class StartAngleArc extends svg.Arc {
  bool tested = false;
  double get startAngle {
    tested = true;;
    return math.PI;
  }
}

class EndAngleArc extends svg.Arc {
  bool tested = false;
  double get endAngle {
    tested = true;;
    return math.PI;
  }
}
