import 'dart:math' as math;
import 'package:unittest/unittest.dart';
import 'package:d3/svg/svg.dart' as svg;


Matcher pathEquals(expected, [limit=100]) => equals(expected, limit);

class InnerRadiusArc extends svg.Arc {
  Map n, d;
  int i;
  InnerRadiusArc(this.n, this.d, this.i);
  double get innerRadius {
    n['tested'] = true;
    d['tested'] = true;
    i *= i;
    return 42.0;
  }
}

void main() {
  group('arc', () {
    /*test('innerRadius defaults to a function accessor', () {
      var a = new svg.Arc()
        ..outerRadius = 100.0
        ..startAngle = 0.0
        ..endAngle = math.PI;
      expect(a({innerRadius: 0}), pathEquals('M0,-100A100,100 0 1,1 0,100L0,0Z'));
      expect(a({innerRadius: 50}), pathEquals('M0,-100A100,100 0 1,1 0,100L0,50A50,50 0 1,0 0,-50Z'));
    });*/
    test('innerRadius can be defined as a constant', () {
      var a = new svg.Arc()
        ..outerRadius = 100.0
        ..startAngle = 0.0
        ..endAngle = math.PI;
      expect((a..innerRadius = 0.0).arc(), pathEquals('M0,-100A100,100 0 1,1 0,100L0,0Z'));
      expect((a..innerRadius = 50.0).arc(), pathEquals('M0,-100A100,100 0 1,1 0,100L0,50A50,50 0 1,0 0,-50Z'));
    });
    test('innerRadius can be defined as a function of data or index', () {
      var a = new InnerRadiusArc({}, {}, 2)
        ..outerRadius = 100.0
        ..startAngle = 0.0
        ..endAngle = math.PI;
      expect(a.arc(), pathEquals('M0,-100A100,100 0 1,1 0,100L0,42A42,42 0 1,0 0,-42Z'));
      expect(a.n.containsKey('tested'), isTrue);
      expect(a.d.containsKey('tested'), isTrue);
      expect(a.i, equals(2*2));
    });

    /*test('outerRadius defaults to a function accessor', () {
      var a = new svg.Arc()..innerRadius(0).startAngle(0).endAngle(Math.PI);
      expect(a({outerRadius: 50}), pathEquals('M0,-50A50,50 0 1,1 0,50L0,0Z'));
      expect(a({outerRadius: 100}), pathEquals('M0,-100A100,100 0 1,1 0,100L0,0Z'));
    });
    test('outerRadius can be defined as a constant', () {
      var a = new svg.Arc()..innerRadius(0).startAngle(0).endAngle(Math.PI);
      expect(a.outerRadius(50)(), pathEquals('M0,-50A50,50 0 1,1 0,50L0,0Z'));
      expect(a.outerRadius(100)(), pathEquals('M0,-100A100,100 0 1,1 0,100L0,0Z'));
    });
    test('outerRadius can be defined as a function of data or index', () {
      var a = new svg.Arc()..innerRadius(0).outerRadius(f).startAngle(0).endAngle(Math.PI), o = {}, t = {}, dd, ii, tt;
      f(d, i) { dd = d; ii = i; tt = this; return 42; }
      expect(a.call(t, o, 2), pathEquals('M0,-42A42,42 0 1,1 0,42L0,0Z'));
      expect(dd, equals(o, 'expected data, got {actual}'));
      expect(ii, equals(2, 'expected index, got {actual}'));
      expect(tt, equals(t, 'expected this, got {actual}'));
    });

    test('startAngle defaults to a function accessor', () {
      var a = new svg.Arc()..innerRadius(0).outerRadius(100).endAngle(Math.PI);
      expect(a({startAngle: 0}), pathEquals('M0,-100A100,100 0 1,1 0,100L0,0Z'));
      expect(a({startAngle: Math.PI / 2}), pathEquals('M100,0A100,100 0 0,1 0,100L0,0Z'));
    });
    test('startAngle can be defined as a constant', () {
      var a = new svg.Arc()..innerRadius(0).outerRadius(100).endAngle(Math.PI);
      expect(a.startAngle(0)(), pathEquals('M0,-100A100,100 0 1,1 0,100L0,0Z'));
      expect(a.startAngle(Math.PI / 2)(), pathEquals('M100,0A100,100 0 0,1 0,100L0,0Z'));
    });
    test('startAngle can be defined as a function of data or index', () {
      var a = new svg.Arc()..innerRadius(0).outerRadius(100).startAngle(f).endAngle(Math.PI), o = {}, t = {}, dd, ii, tt;
      function f(d, i) { dd = d; ii = i; tt = this; return Math.PI; }
      expect(a.call(t, o, 2), pathEquals('M0,100A100,100 0 0,1 0,100L0,0Z'));
      expect(dd, equals(o, 'expected data, got {actual}'));
      expect(ii, equals(2, 'expected index, got {actual}'));
      expect(tt, equals(t, 'expected this, got {actual}'));
    });

    test('endAngle defaults to a function accessor', () {
      var a = new svg.Arc()..innerRadius(0).outerRadius(100).startAngle(0);
      expect(a({endAngle: Math.PI / 2}), pathEquals('M0,-100A100,100 0 0,1 100,0L0,0Z'));
      expect(a({endAngle: Math.PI}), pathEquals('M0,-100A100,100 0 1,1 0,100L0,0Z'));
    });
    test('endAngle can be defined as a constant', () {
      var a = new svg.Arc()..innerRadius(0).outerRadius(100).startAngle(0);
      expect(a.endAngle(Math.PI / 2)(), pathEquals('M0,-100A100,100 0 0,1 100,0L0,0Z'));
      expect(a.endAngle(Math.PI)(), pathEquals('M0,-100A100,100 0 1,1 0,100L0,0Z'));
    });
    test('endAngle can be defined as a function of data or index', () {
      var a = new svg.Arc()..innerRadius(0).outerRadius(100).startAngle(0).endAngle(f), o = {}, t = {}, dd, ii, tt;
      function f(d, i) { dd = d; ii = i; tt = this; return Math.PI; }
      expect(a.call(t, o, 2), pathEquals('M0,-100A100,100 0 1,1 0,100L0,0Z'));
      expect(dd, equals(o, 'expected data, got {actual}'));
      expect(ii, equals(2, 'expected index, got {actual}'));
      expect(tt, equals(t, 'expected this, got {actual}'));
    });

    test('startAngle and endAngle are swapped if endAngle is less than startAngle', () {
      var a = new svg.Arc()..innerRadius(50).outerRadius(100);
      expect(a.startAngle(2 * Math.PI).endAngle(Math.PI)(), pathEquals(a.startAngle(Math.PI).endAngle(2 * Math.PI)()));
      expect(a.startAngle(-Math.PI).endAngle(Math.PI)(), pathEquals(a.startAngle(Math.PI).endAngle(-Math.PI)()));
    });

    test('angles are defined in radians, with zero at 12 o\'clock', () {
      var a = new svg.Arc()..innerRadius(0).outerRadius(100);
      expect(a.startAngle(0).endAngle(Math.PI)(), pathEquals('M0,-100A100,100 0 1,1 0,100L0,0Z'));
      expect(a.startAngle(Math.PI).endAngle(2 * Math.PI)(), pathEquals('M0,100A100,100 0 1,1 0,-100L0,0Z'));
    });
    test('radii are defined in local coordinates (typically pixels)', () {
      var a = new svg.Arc()..startAngle(0).endAngle(Math.PI);
      expect(a.innerRadius(0).outerRadius(100)(), pathEquals('M0,-100A100,100 0 1,1 0,100L0,0Z'));
      expect(a.innerRadius(100).outerRadius(200)(), pathEquals('M0,-200A200,200 0 1,1 0,200L0,100A100,100 0 1,0 0,-100Z'));
    });
    test('draws a circle when inner radius is zero and angle is approximately 2π', () {
      var a = new svg.Arc()..innerRadius(0).outerRadius(100);
      expect(a.startAngle(0).endAngle(2 * Math.PI - 1e-9)(), pathEquals('M0,100A100,100 0 1,1 0,-100A100,100 0 1,1 0,100Z'));
      expect(a.startAngle(Math.PI + 1e-9).endAngle(3 * Math.PI - 1e-9)(), pathEquals('M0,100A100,100 0 1,1 0,-100A100,100 0 1,1 0,100Z'));
    });
    test('draws a circle when inner radius is zero and angle is greater than 2π', () {
      var a = new svg.Arc()..innerRadius(0).outerRadius(100);
      expect(a.startAngle(0).endAngle(7)(), pathEquals('M0,100A100,100 0 1,1 0,-100A100,100 0 1,1 0,100Z'));
      expect(a.startAngle(1).endAngle(8)(), pathEquals('M0,100A100,100 0 1,1 0,-100A100,100 0 1,1 0,100Z'));
    });
    test('draws a circular sector when inner radius is zero and angle is less than 2π', () {
      var a = new svg.Arc()..innerRadius(0).outerRadius(100);
      expect(a.startAngle(0).endAngle(Math.PI / 2)(), pathEquals('M0,-100A100,100 0 0,1 100,0L0,0Z'));
    });
    test('draws an annulus when inner radius is non-zero and angle is approximately 2π', () {
      var a = new svg.Arc()..innerRadius(100).outerRadius(200);
      expect(a.startAngle(0).endAngle(2 * Math.PI - 1e-9)(), pathEquals('M0,200A200,200 0 1,1 0,-200A200,200 0 1,1 0,200M0,100A100,100 0 1,0 0,-100A100,100 0 1,0 0,100Z'));
      expect(a.startAngle(Math.PI + 1e-9).endAngle(3 * Math.PI - 1e-9)(), pathEquals('M0,200A200,200 0 1,1 0,-200A200,200 0 1,1 0,200M0,100A100,100 0 1,0 0,-100A100,100 0 1,0 0,100Z'));
    });
    test('draws an annulus when inner radius is non-zero and angle is greater than 2π', () {
      var a = new svg.Arc()..innerRadius(100).outerRadius(200);
      expect(a.startAngle(0).endAngle(7)(), pathEquals('M0,200A200,200 0 1,1 0,-200A200,200 0 1,1 0,200M0,100A100,100 0 1,0 0,-100A100,100 0 1,0 0,100Z'));
      expect(a.startAngle(-1).endAngle(6)(), pathEquals('M0,200A200,200 0 1,1 0,-200A200,200 0 1,1 0,200M0,100A100,100 0 1,0 0,-100A100,100 0 1,0 0,100Z'));
    });
    test('draws an annular sector when both radii are non-zero and angle is less than 2π', () {
      var a = new svg.Arc()..innerRadius(100).outerRadius(200);
      expect(a.startAngle(0).endAngle(Math.PI / 2)(), pathEquals('M0,-200A200,200 0 0,1 200,0L100,0A100,100 0 0,0 0,-100Z'));
    });

    test('computes the centroid as mid-radius and mid-angle', () {
      var c = new svg.Arc()..innerRadius(0).outerRadius(100).startAngle(0).endAngle(2 * Math.PI).centroid();
      expect(c[0], closeTo(0, 1e-6));
      expect(c[1], closeTo(50, 1e-6));
      c = new svg.Arc()..innerRadius(100).outerRadius(200).startAngle(Math.PI).endAngle(2 * Math.PI).centroid();
      expect(c[0], closeTo(-150, 1e-6));
      expect(c[1], closeTo(0, 1e-6));
    }*/
  });
}
