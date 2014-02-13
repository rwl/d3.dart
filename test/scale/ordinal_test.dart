import 'package:unittest/unittest.dart';

import 'package:d3/scale/scale.dart';

void main() {
  group('ordinal', () {
    group('domain', () {
      test('defaults to the empty array', () {
        expect(new Ordinal().domain, isEmpty);
      });
      test('setting the domain forgets previous values', () {
        var x = new Ordinal()
          ..range = ['foo', 'bar'];
        expect(x(1), equals('foo'));
        expect(x(0), equals('bar'));
        expect(x.domain, equals([1, 0]));
        x.domain = ['0', '1'];
        expect(x(0), equals('foo')); // it changed!
        expect(x(1), equals('bar'));
        expect(x.domain, equals(['0', '1']));
      });
      test('uniqueness is based on string coercion', () {
        var x = new Ordinal()
          ..domain = ['foo']
          ..range = [42, 43, 44];
        expect(x("foo"), equals(42));
        expect(x(new Str('foo')), equals(42));
        expect(x(new Str('bar')), equals(43));
      });
      test('does not coerce domain values to strings', () {
        var x = new Ordinal()
          ..domain = [0, 1];
        expect(x.domain, equals([0, 1]));
        expect(x.domain[0] is num, isTrue);
        expect(x.domain[1] is num, isTrue);
      });
      test('does not barf on object built-ins', () {
        var x = new Ordinal()
          ..domain = ['__proto__', 'hasOwnProperty']
          ..range = [42, 43];
        expect(x('__proto__'), equals(42));
        expect(x('hasOwnProperty'), equals(43));
        expect(x.domain, equals(['__proto__', 'hasOwnProperty']));
      });
    });

    group('range', () {
      test('defaults to the empty array', () {
        var x = new Ordinal();
        expect(x.range, isEmpty);
        expect(x(0), isNull/*isUndefined*/);
      });
      test('new input values are added to the domain', () {
        var x = new Ordinal()
          ..range = ['foo', 'bar'];
        expect(x(0), equals('foo'));
        expect(x.domain, equals([0]));
        expect(x(1), equals('bar'));
        expect(x.domain, equals([0, 1]));
        expect(x(0), equals('foo'));
        expect(x.domain, equals([0, 1]));
      });
      test('orders domain values by the order in which they are seen', () {
        var x = new Ordinal();
        x('foo');
        x('bar');
        x('baz');
        expect(x.domain, equals(['foo', 'bar', 'baz']));
        x.domain = ['baz', 'bar'];
        x('foo');
        expect(x.domain, equals(['baz', 'bar', 'foo']));
        x.domain = ['baz', 'foo'];
        expect(x.domain, equals(['baz', 'foo']));
        x.domain = [];
        x('foo');
        x('bar');
        expect(x.domain, equals(['foo', 'bar']));
      });
      test('setting the range remembers previous values', () {
        var x = new Ordinal();
        expect(x(0), isNull/*isUndefined*/);
        expect(x(1), isNull/*isUndefined*/);
        x.range = ['foo', 'bar'];
        expect(x(0), equals('foo'));
        expect(x(1), equals('bar'));
      });
      test('recycles values when exhausted', () {
        var x = new Ordinal()
          ..range = ['a', 'b', 'c'];
        expect(x(0), equals('a'));
        expect(x(1), equals('b'));
        expect(x(2), equals('c'));
        expect(x(3), equals('a'));
        expect(x(4), equals('b'));
        expect(x(5), equals('c'));
        expect(x(2), equals('c'));
        expect(x(1), equals('b'));
        expect(x(0), equals('a'));
      });
    });

    test('maps distinct values to discrete values', () {
      var x = new Ordinal()
        ..range = ['a', 'b', 'c'];
      expect(x(0), equals('a'));
      expect(x('0'), equals('a'));
//      expect(x([0]), equals('a'));
      expect(x(1), equals('b'));
//      expect(x(2.0), equals('c'));
      expect(x(/*new Number(*/2/*)*/), equals('c'));
    });

    group('rangePoints', () {
      test('computes discrete points in a continuous range', () {
        var x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangePoints([0, 120]);
        expect(x.range, equals([0, 60, 120]));
        x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangePoints([0, 120], 1);
        expect(x.range, equals([20, 60, 100]));
        x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangePoints([0, 120], 2);
        expect(x.range, equals([30, 60, 90]));
      });
      test('correctly handles singleton domains', () {
        var x = new Ordinal()
          ..domain = ['a']
          ..rangePoints([0, 120]);
        expect(x.range, equals([60]));
      });
      test('can be set to a descending range', () {
        var x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangePoints([120, 0]);
        expect(x.range, equals([120, 60,0]));
        x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangePoints([120, 0], 1);
        expect(x.range, equals([100, 60, 20]));
        x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangePoints([120, 0], 2);
        expect(x.range, equals([90, 60, 30]));
      });
      test('has a rangeBand of zero', () {
        var x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangePoints([0, 120]);
        expect(x.rangeBand, equals(0));
        x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangePoints([0, 120], 1);
        expect(x.rangeBand, equals(0));
        x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangePoints([0, 120], 2);
        expect(x.rangeBand, equals(0));
        x = new Ordinal()
          ..domain = ['a']
          ..rangePoints([0, 120]);
        expect(x.rangeBand, equals(0));
        x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangePoints([120, 0]);
        expect(x.rangeBand, equals(0));
        x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangePoints([120, 0], 1);
        expect(x.rangeBand, equals(0));
        x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangePoints([120, 0], 2);
        expect(x.rangeBand, equals(0));
      });
      test('returns undefined for values outside the domain', () {
        var x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangePoints([0, 1]);
        expect(x('d'), isNull/*isUndefined*/);
        expect(x('e'), isNull/*isUndefined*/);
        expect(x('f'), isNull/*isUndefined*/);
      });
      test('does not implicitly add values to the domain', () {
        var x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangePoints([0, 1]);
        x('d');
        x('e');
        expect(x.domain, equals(['a', 'b', 'c']));
      });
    });

    group('rangeBands', () {
      test('computes discrete bands in a continuous range', () {
        var x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangeBands([0, 120]);
        expect(x.range, equals([0, 40, 80]));
        expect(x.rangeBand, equals(40));
        x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangeBands([0, 120], .2);
        expect(x.range, equals([7.5, 45, 82.5]));
        expect(x.rangeBand, equals(30));
      });
      test('setting domain recomputes range bands', () {
        var x = new Ordinal()
          ..rangeRoundBands([0, 100])
          ..domain = ['a', 'b', 'c'];
        expect(x.range, equals([1, 34, 67]));
        expect(x.rangeBand, equals(33));
        x.domain = ['a', 'b', 'c', 'd'];
        expect(x.range, equals([0, 25, 50, 75]));
        expect(x.rangeBand, equals(25));
      });
      test('can be set to a descending range', () {
        var x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangeBands([120, 0]);
        expect(x.range, equals([80, 40, 0]));
        expect(x.rangeBand, equals(40));
        x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangeBands([120, 0], .2);
        expect(x.range, equals([82.5, 45, 7.5]));
        expect(x.rangeBand, equals(30));
      });
      test('can specify a different outer padding', () {
        var x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangeBands([120, 0], .2, .1);
        expect(x.range, equals([84, 44, 4]));
        expect(x.rangeBand, equals(32));
        x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangeBands([120, 0], .2, 1);
        expect(x.range, equals([75, 50, 25]));
        expect(x.rangeBand, equals(20));
      });
      test('returns undefined for values outside the domain', () {
        var x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangeBands([0, 1]);
        expect(x('d'), isNull/*isUndefined*/);
        expect(x('e'), isNull/*isUndefined*/);
        expect(x('f'), isNull/*isUndefined*/);
      });
      test('does not implicitly add values to the domain', () {
        var x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangeBands([0, 1]);
        x('d');
        x('e');
        expect(x.domain, equals(['a', 'b', 'c']));
      });
    });

    group('rangeRoundBands', () {
      test('computes discrete rounded bands in a continuous range', () {
        var x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangeRoundBands([0, 100]);
        expect(x.range, equals([1, 34, 67]));
        expect(x.rangeBand, equals(33));
        x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangeRoundBands([0, 100], .2);
        expect(x.range, equals([7, 38, 69]));
        expect(x.rangeBand, equals(25));
      });
      test('can be set to a descending range', () {
        var x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangeRoundBands([100, 0]);
        expect(x.range, equals([67, 34, 1]));
        expect(x.rangeBand, equals(33));
        x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangeRoundBands([100, 0], .2);
        expect(x.range, equals([69, 38, 7]));
        expect(x.rangeBand, equals(25));
      });
      test('can specify a different outer padding', () {
        var x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangeRoundBands([120, 0], .2, .1);
        expect(x.range, equals([84, 44, 4]));
        expect(x.rangeBand, equals(32));
        x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangeRoundBands([120, 0], .2, 1);
        expect(x.range, equals([75, 50, 25]));
        expect(x.rangeBand, equals(20));
      });
      test('returns undefined for values outside the domain', () {
        var x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangeRoundBands([0, 1]);
        expect(x('d'), isNull/*isUndefined*/);
        expect(x('e'), isNull/*isUndefined*/);
        expect(x('f'), isNull/*isUndefined*/);
      });
      test('does not implicitly add values to the domain', () {
        var x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangeRoundBands([0, 1]);
        x('d');
        x('e');
        expect(x.domain, equals(['a', 'b', 'c']));
      });
    });

    group('rangeExtent', () {
      test('returns the continuous range', () {
        var x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangePoints([20, 120]);
        expect(x.rangeExtent, equals([20, 120]));
        x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangeBands([10, 110]);
        expect(x.rangeExtent, equals([10, 110]));
        x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangeRoundBands([0, 100]);
        expect(x.rangeExtent, equals([0, 100]));
        x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..range = [0, 20, 100];
        expect(x.rangeExtent, equals([0, 100]));
      });
      test('can handle descending ranges', () {
        var x = new Ordinal()
          ..domain = ['a', 'b', 'c']
          ..rangeBands([100, 0]);
        expect(x.rangeExtent, equals([0, 100]));
      });
    });

    group('copy', () {
      test('changes to the domain are isolated', () {
        var x = new Ordinal()
          ..range = ['foo', 'bar'];
        var y = x.copy();
        x.domain = [1, 2];
        expect(y.domain, equals([]));
        expect(x(1), equals('foo'));
        expect(y(1), equals('foo'));
        y.domain = [2, 3];
        expect(x(2), equals('bar'));
        expect(y(2), equals('foo'));
        expect(x.domain, equals([1, 2]));
        expect(y.domain, equals([2, 3]));
      });
      test('changes to the range are isolated', () {
        var x = new Ordinal()
          ..range = ['foo', 'bar'];
        var y = x.copy();
        x.range = ['bar', 'foo'];
        expect(x(1), equals('bar'));
        expect(y(1), equals('foo'));
        expect(y.range, ['foo', 'bar']);
        y.range = ['foo', 'baz'];
        expect(x(2), equals('foo'));
        expect(y(2), equals('baz'));
        expect(x.range, equals(['bar', 'foo']));
        expect(y.range, equals(['foo', 'baz']));
      });
      test('changes to the range type are isolated', () {
        var x = new Ordinal()
          ..domain = [0, 1]
          ..rangeBands([0, 1], .2);
        var y = x.copy();
        x.rangePoints([1, 2]);
        expect(x(0), closeTo(1, 1e-6));
        expect(x(1), closeTo(2, 1e-6));
        expect(x.rangeBand, closeTo(0, 1e-6));
        expect(y(0), closeTo(1/11, 1e-6));
        expect(y(1), closeTo(6/11, 1e-6));
        expect(y.rangeBand, closeTo(4/11, 1e-6));
        y.rangeBands([0, 1]);
        expect(x(0), closeTo(1, 1e-6));
        expect(x(1), closeTo(2, 1e-6));
        expect(x.rangeBand, closeTo(0, 1e-6));
        expect(y(0), closeTo(0, 1e-6));
        expect(y(1), closeTo(1/2, 1e-6));
        expect(y.rangeBand, closeTo(1/2, 1e-6));
      });
    });
  });
}

class Str {
  String s;
  Str(this.s);
  String toString() => s;
}