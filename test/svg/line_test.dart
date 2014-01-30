import 'package:unittest/unittest.dart';
import 'package:d3/svg/svg.dart';

Matcher pathEquals(expected, [limit=100]) => equals(expected, limit);

void main() {
  group('line', () {
    /*test('x defaults to a function accessor', () {
      var l = new Line();
      expect(l([[1, 2], [4, 3]]), pathEquals('M1,2L4,3'));
      expect(l.x() is Function, isTrue);
    });*/
    test('x can be defined as a constant', () {
      var l = new Line()..x = 0;
      expect(l.line([[1, 2], [4, 3]]), pathEquals('M0,2L0,3'));
      expect(l.x, equals(0));
    });
    /*test('x can be defined as a function', () {
      var l = new Line().x(f), t = {}, dd = [], ii = [], tt = [];
      //function f(d, i) { dd.push(d); ii.push(i); tt.push(this); return 0; }
      expect(l.call(t, [[1, 2], [4, 3]]), pathEquals('M0,2L0,3'));
      expect(dd, equals([[1, 2], [4, 3]], 'expected data, got {actual}'));
      expect(ii, equals([0, 1], 'expected index, got {actual}'));
      expect(tt, equals([t, t], 'expected this, got {actual}'));
    });

    test('y defaults to a function accessor', () {
      var l = new Line();
      expect(l([[1, 2], [4, 3]]), pathEquals('M1,2L4,3'));
      expect(l.y() is Function, isTrue);
    });
    test('y can be defined as a constant', () {
      var l = new Line().y(0);
      expect(l([[1, 2], [4, 3]]), pathEquals('M1,0L4,0'));
      expect(l.y(), equals(0));
    });
    test('y can be defined as a function', () {
      var l = new Line().y(f), t = {}, dd = [], ii = [], tt = [];
      //function f(d, i) { dd.push(d); ii.push(i); tt.push(this); return 0; }
      expect(l.call(t, [[1, 2], [4, 3]]), pathEquals('M1,0L4,0'));
      expect(dd, equals([[1, 2], [4, 3]], 'expected data, got {actual}'));
      expect(ii, equals([0, 1], 'expected index, got {actual}'));
      expect(tt, equals([t, t], 'expected this, got {actual}'));
    });

    test('interpolate defaults to linear', () {
      expect(new Line().interpolate(), equals('linear'));
    });
    test('interpolate can be defined as a constant', () {
      var l = new Line().interpolate('step-before');
      expect(l([[0, 0], [1, 1]]), pathEquals('M0,0V1H1'));
      expect(l.interpolate(), equals('step-before'));
    });
    test('interpolate can be defined as a function', () {
      interpolate(points) {
        return points.join('T');
      }
      var l = new Line().interpolate(interpolate);
      expect(l([[0, 0], [1, 1]]), pathEquals('M0,0T1,1'));
      expect(l.interpolate(), equals(interpolate));
    });
    test('invalid interpolates fallback to linear', () {
      expect(new Line().interpolate('__proto__').interpolate(), equals('linear'));
    });

    test('tension defaults to .7', () {
      expect(new Line().tension(), equals(.7));
    });
    test('tension can be specified as a constant', () {
      var l = new Line().tension(.5);
      expect(l.tension(), equals(.5));
    });

    test('returns null if input points array is empty', () {
      expect(new Line()([]), isNull);
    });

    test('interpolate(linear)', () {
      test('supports linear interpolation', () {
        var l = new Line().interpolate('linear');
        expect(l([[0, 0], [1, 1], [2, 0], [3, 1], [4, 0]]),
            pathEquals('M0,0L1,1L2,0L3,1L4,0'));
      });
    });

    test('interpolate(step)', () {
      test('supports step-before interpolation', () {
        var l = new Line().interpolate('step-before');
        expect(l([[0, 0]]), pathEquals('M0,0'));
        expect(l([[0, 0], [1, 1]]), pathEquals('M0,0V1H1'));
        expect(l([[0, 0], [1, 1], [2, 0]]), pathEquals('M0,0V1H1V0H2'));
      });
      test('supports step interpolation', () {
        var l = new Line().interpolate('step');
        expect(l([[0, 0]]), pathEquals('M0,0'));
        expect(l([[0, 0], [1, 1]]), pathEquals('M0,0H0.5V1H1'));
        expect(l([[0, 0], [1, 1], [2, 0]]), pathEquals('M0,0H0.5V1H1.5V0H2'));
      });
      test('supports step-after interpolation', () {
        var l = new Line().interpolate('step-after');
        expect(l([[0, 0]]), pathEquals('M0,0'));
        expect(l([[0, 0], [1, 1]]), pathEquals('M0,0H1V1'));
        expect(l([[0, 0], [1, 1], [2, 0]]), pathEquals('M0,0H1V1H2V0'));
      });
    });

    test('interpolate(basis)', () {
      test('supports basis interpolation', () {
        var l = new Line().interpolate('basis');
        expect(l([[0, 0], [1, 1], [2, 0], [3, 1], [4, 0]]),
            pathEquals('M0,0L0.16666666666666666,0.16666666666666666C0.3333333333333333,0.3333333333333333,0.6666666666666666,0.6666666666666666,1,0.6666666666666666C1.3333333333333333,0.6666666666666666,1.6666666666666665,0.3333333333333333,2,0.3333333333333333C2.333333333333333,0.3333333333333333,2.6666666666666665,0.6666666666666666,3,0.6666666666666666C3.333333333333333,0.6666666666666666,3.6666666666666665,0.3333333333333333,3.833333333333333,0.16666666666666666L4,0'));
      });
      test('supports basis-open interpolation', () {
        var l = new Line().interpolate('basis-open');
        expect(l([[0, 0], [1, 1], [2, 0], [3, 1], [4, 0]]),
            pathEquals('M1,0.6666666666666666C1.3333333333333333,0.6666666666666666,1.6666666666666665,0.3333333333333333,2,0.3333333333333333C2.333333333333333,0.3333333333333333,2.6666666666666665,0.6666666666666666,3,0.6666666666666666'));
      });
      test('supports basis-closed interpolation', () {
        var l = new Line().interpolate('basis-closed');
        expect(l([[0, 0], [1, 1], [2, 0], [3, 1], [4, 0]]),
            pathEquals('M2,0.3333333333333333C2.333333333333333,0.3333333333333333,2.6666666666666665,0.6666666666666666,3,0.6666666666666666C3.333333333333333,0.6666666666666666,3.6666666666666665,0.3333333333333333,3.1666666666666665,0.16666666666666666C2.6666666666666665,0,1.3333333333333333,0,0.8333333333333333,0.16666666666666666C0.3333333333333333,0.3333333333333333,0.6666666666666666,0.6666666666666666,1,0.6666666666666666C1.3333333333333333,0.6666666666666666,1.6666666666666665,0.3333333333333333,2,0.3333333333333333'));
      });
      test('basis interpolation reverts to linear with fewer than three points', () {
        var l = new Line().interpolate('basis'), d = new Line();
        expect(l([[0, 0]]), pathEquals(d([[0, 0]])));
        expect(l([[0, 0], [1, 1]]), pathEquals(d([[0, 0], [1, 1]])));
      });
      test('basis-open interpolation reverts to linear with fewer than four points', () {
        var l = new Line().interpolate('basis-open'), d = new Line();
        expect(l([[0, 0]]), pathEquals(d([[0, 0]])));
        expect(l([[0, 0], [1, 1]]), pathEquals(d([[0, 0], [1, 1]])));
        expect(l([[0, 0], [1, 1], [2, 0]]), pathEquals(d([[0, 0], [1, 1], [2, 0]])));
      });
      test('basis-closed interpolation reverts to linear with fewer than three points', () {
        var l = new Line().interpolate('basis-open'), d = new Line();
        expect(l([[0, 0]]), pathEquals(d([[0, 0]])));
        expect(l([[0, 0], [1, 1]]), pathEquals(d([[0, 0], [1, 1]])));
      });
    });

    test('interpolate(bundle)', () {
      test('supports bundle interpolation', () {
        var l = new Line().interpolate('bundle');
        expect(l([[0, 0], [1, 1], [2, 0], [3, 1], [4, 0]]),
            pathEquals('M0,0L0.16666666666666666,0.11666666666666665C0.3333333333333333,0.2333333333333333,0.6666666666666666,0.4666666666666666,1,0.4666666666666666C1.3333333333333333,0.4666666666666666,1.6666666666666665,0.2333333333333333,2,0.2333333333333333C2.333333333333333,0.2333333333333333,2.6666666666666665,0.4666666666666666,3,0.4666666666666666C3.333333333333333,0.4666666666666666,3.6666666666666665,0.2333333333333333,3.833333333333333,0.11666666666666665L4,0'));
      });
      test('observes the specified tension', () {
        var l = new Line().interpolate('bundle').tension(1);
        expect(l([[0, 0], [1, 1], [2, 0], [3, 1], [4, 0]]),
            pathEquals(new Line().interpolate('basis')([[0, 0], [1, 1], [2, 0], [3, 1], [4, 0]])));
      });
      test('supports a single-element array', () {
        var l = new Line().interpolate('bundle').tension(1);
        expect(l([[0, 0]]), pathEquals('M0,0'));
      });
    });

    test('interpolate(cardinal)', () {
      test('supports cardinal interpolation', () {
        var l = new Line().interpolate('cardinal');
        expect(l([[0, 0], [1, 1], [2, 0], [3, 1], [4, 0]]),
            pathEquals('M0,0Q0.8,1,1,1C1.3,1,1.7,0,2,0S2.7,1,3,1Q3.2,1,4,0'));
      });
      test('supports cardinal-open interpolation', () {
        var l = new Line().interpolate('cardinal-open');
        expect(l([[0, 0], [1, 1], [2, 0], [3, 1], [4, 0]]),
            pathEquals('M1,1C1.3,1,1.7,0,2,0S2.7,1,3,1'));
      });
      test('supports cardinal-closed interpolation', () {
        var l = new Line().interpolate('cardinal-closed');
        expect(l([[0, 0], [1, 1], [2, 0], [3, 1], [4, 0]]),
            pathEquals('M0,0C-0.45,0.15,0.7,1,1,1S1.7,0,2,0S2.7,1,3,1S4.45,0.15,4,0S0.45,-0.15,0,0'));
      });
      test('cardinal interpolation reverts to linear with fewer than three points', () {
        var l = new Line().interpolate('cardinal'), d = new Line();
        expect(l([[0, 0]]), pathEquals(d([[0, 0]])));
        expect(l([[0, 0], [1, 1]]), pathEquals(d([[0, 0], [1, 1]])));
      });
      test('cardinal-open interpolation reverts to linear with fewer than four points', () {
        var l = new Line().interpolate('cardinal-open'), d = new Line();
        expect(l([[0, 0]]), pathEquals(d([[0, 0]])));
        expect(l([[0, 0], [1, 1]]), pathEquals(d([[0, 0], [1, 1]])));
        expect(l([[0, 0], [1, 1], [2, 0]]), pathEquals(d([[0, 0], [1, 1], [2, 0]])));
      });
      test('cardinal-closed interpolation reverts to linear with fewer than three points', () {
        var l = new Line().interpolate('cardinal-open'), d = new Line();
        expect(l([[0, 0]]), pathEquals(d([[0, 0]])));
        expect(l([[0, 0], [1, 1]]), pathEquals(d([[0, 0], [1, 1]])));
      });
      test('observes the specified tension', () {
        var l = new Line().tension(.5);
        expect(l.interpolate('cardinal')([[0, 0], [1, 1], [2, 0], [3, 1], [4, 0]]),
            pathEquals('M0,0Q0.6666666666666667,1,1,1C1.5,1,1.5,0,2,0S2.5,1,3,1Q3.3333333333333335,1,4,0'));
        expect(l.interpolate('cardinal-open')([[0, 0], [1, 1], [2, 0], [3, 1], [4, 0]]),
            pathEquals('M1,1C1.5,1,1.5,0,2,0S2.5,1,3,1'));
        expect(l.interpolate('cardinal-closed')([[0, 0], [1, 1], [2, 0], [3, 1], [4, 0]]),
            pathEquals('M0,0C-0.75,0.25,0.5,1,1,1S1.5,0,2,0S2.5,1,3,1S4.75,0.25,4,0S0.75,-0.25,0,0'));
      });
    });

    test('interpolate(monotone)', () {
      test('supports monotone interpolation', () {
        var l = new Line().interpolate('monotone');
        expect(l([[0, 0], [1, 1], [2, 1], [3, 0], [4, 0]]),
            pathEquals('M0,0C0.08333333333333333,0.08333333333333333,0.6666666666666667,1,1,1S1.6666666666666667,1,2,1S2.6666666666666665,0,3,0S3.8333333333333335,0,4,0'));
      });
      test('monotone interpolation reverts to linear with fewer than three points', () {
        var l = new Line().interpolate('monotone'), d = new Line();
        expect(l([[0, 0]]), pathEquals(d([[0, 0]])));
        expect(l([[0, 0], [1, 1]]), pathEquals(d([[0, 0], [1, 1]])));
      });
    });*/
  });
}