import 'package:unittest/unittest.dart';
import 'package:d3/arrays/arrays.dart';

void main() {
  group('range', () {
    test('start is an inclusive lower bound', () {
      expect(range(5)[0], equals(0));
      expect(range(1, 5)[0], equals(1));
      expect(range(5, 1, -1)[0], equals(5));
    });
    test('stop is an exclusive upper bound', () {
      expect(range(5)[4], equals(4));
      expect(range(1, 5)[3], equals(4));
      expect(range(5, 1, -1)[3], equals(2));
    });
    test('with one argument, returns integers [0 … stop)', () {
      expect(range(0), equals([]));
      expect(range(1), equals([0]));
      expect(range(5), equals([0, 1, 2, 3, 4]));
    });
    test('with two arguments, returns integers [start … stop)', () {
      expect(range(0, 5), equals([0, 1, 2, 3, 4]));
      expect(range(5, 9), equals([5, 6, 7, 8]));
    });
    test('with three arguments, returns start + k * step', () {
      expect(range(0, 5, 1), equals([0, 1, 2, 3, 4]));
      expect(range(5, 9, .5), equals([5, 5.5, 6, 6.5, 7, 7.5, 8, 8.5]));
      expect(range(5, 8.5, .5), equals([5, 5.5, 6, 6.5, 7, 7.5, 8]));
      expect(range(2, 0, -.5), equals([2, 1.5, 1, .5]));
    });
    test('handles fractional steps without rounding errors', () {
      expect(range(0, 0.5, 0.1), equals([0, 0.1, 0.2, 0.3, 0.4]));
      expect(range(-2, -1.2, 0.1), equals([-2, -1.9, -1.8, -1.7, -1.6, -1.5, -1.4, -1.3]));
    });
    test('handles extremely small steps without rounding errors', () {
      expect(range(2.1e-31, 5e-31, 1.1e-31), equals([2.1e-31, 3.2e-31, 4.3e-31]));
    });
    test('handles extremely large steps without rounding errors', () {
      expect(range(1e300, 2e300, 0.3e300), equals([1e300, 1.3e300, 1.6e300, 1.9e300]));
    });
    test('returns an ascending range if step is positive', () {
      expect(range(0, 5, 1), equals([0, 1, 2, 3, 4]));
    });
    test('returns a descending range if step is negative', () {
      expect(range(5, 0, -1), equals([5, 4, 3, 2, 1]));
    });
    /*test('returns an empty range if start, stop or step are NaN', () {
      expect(range(0, double.NAN), isEmpty);
      expect(range(1, double.NAN), isEmpty);
      expect(range(-1, double.NAN), isEmpty);
      expect(range(0, null), isEmpty);
      expect(range(1, null), isEmpty);
      expect(range(-1, null), isEmpty);
      expect(range(double.NAN, 0), isEmpty);
      expect(range(double.NAN, 1), isEmpty);
      expect(range(double.NAN, -1), isEmpty);
      expect(range(null, 0), isEmpty);
      expect(range(null, 1), isEmpty);
      expect(range(null, -1), isEmpty);
      expect(range(double.NAN, double.NAN), isEmpty);
      expect(range(null, null), isEmpty);
      expect(range(double.NAN, double.NAN, double.NAN), isEmpty);
      expect(range(null, null, null), isEmpty);
      expect(range(0, 10, double.NAN), isEmpty);
      expect(range(10, 0, double.NAN), isEmpty);
      expect(range(0, 10, null), isEmpty);
      expect(range(10, 0, null), isEmpty);
    });
    test('returns an empty range if start equals stop', () {
      expect(range(10, 10), isEmpty);
      expect(range(10, 10, 1), isEmpty);
      expect(range(10, 10, -1), isEmpty);
      expect(range(10, 10, -.5), isEmpty);
      expect(range(10, 10, .5), isEmpty);
      expect(range(0, 0), isEmpty);
      expect(range(0, 0, 1), isEmpty);
      expect(range(0, 0, -1), isEmpty);
      expect(range(0, 0, -.5), isEmpty);
      expect(range(0, 0, .5), isEmpty);
    });
    test('returns an empty range if stop is less than start and step is positive', () {
      expect(range(20, 10), isEmpty);
      expect(range(20, 10, 2), isEmpty);
      expect(range(20, 10, 1), isEmpty);
      expect(range(20, 10, .5), isEmpty);
    });
    test('returns an empty range if stop is greater than start and step is negative', () {
      expect(range(10, 20, -2), isEmpty);
      expect(range(10, 20, -1), isEmpty);
      expect(range(10, 20, -.5), isEmpty);
    });*/
  });
}