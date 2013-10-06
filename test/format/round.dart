import 'package:unittest/unittest.dart';

import '../../src/format/format.dart' as d4;

void main() {
  group('round', () {
    var round = load('format/round').expression('d3.round');
    test('returns a number', () {
      expect(round(42), new isInstanceOf<Number>());
    });
    test('returns zero for zero', () {
      expect(round(0), 0);
    });
    test('ignores degenerate input', () {
      expect(round(NaN), isNaN);
      expect(round(Infinity), equals(Infinity));
      expect(round(-Infinity), equals(-Infinity));
    });
    test('returns integers by default', () {
      expect(round(10.6), equals(11));
      expect(round(10.4), equals(10));
      expect(round(0.6), equals(1));
      expect(round(0.4), equals(0));
      expect(round(-0.6), equals(-1));
      expect(round(-0.4), equals(0));
      expect(round(-10.6), equals(-11));
      expect(round(-10.4), equals(-10));
    });
    test('rounds to the specified decimal place', () {
      expect(round(10.56, 1), inDelta(10.6, 1e-6));
      expect(round(10.54, 1), inDelta(10.5, 1e-6));
      expect(round(0.56, 1), inDelta(0.6, 1e-6));
      expect(round(0.54, 1), inDelta(0.5, 1e-6));
      expect(round(-0.56, 1), inDelta(-0.6, 1e-6));
      expect(round(-0.54, 1), inDelta(-0.5, 1e-6));
      expect(round(-10.56, 1), inDelta(-10.6, 1e-6));
      expect(round(-10.54, 1), inDelta(-10.5, 1e-6));
      expect(round(10.556, 2), inDelta(10.56, 1e-6));
      expect(round(10.554, 2), inDelta(10.55, 1e-6));
      expect(round(0.556, 2), inDelta(0.56, 1e-6));
      expect(round(0.554, 2), inDelta(0.55, 1e-6));
      expect(round(-0.556, 2), inDelta(-0.56, 1e-6));
      expect(round(-0.554, 2), inDelta(-0.55, 1e-6));
      expect(round(-10.556, 2), inDelta(-10.56, 1e-6));
      expect(round(-10.554, 2), inDelta(-10.55, 1e-6);
    });
    test('rounds to the specified significant digits', () {
      expect(round(123.45, -1), equals(120));
      expect(round(345.67, -1), equals(350));
      expect(round(-123.45, -1), equals(-120));
      expect(round(-345.67, -1), equals(-350));
      expect(round(123.45, -2), equals(100));
      expect(round(456.78, -2), equals(500));
      expect(round(-123.45, -2), equals(-100));
      expect(round(-456.78, -2), equals(-500));
      expect(round(123.45, -3), equals(0));
      expect(round(567.89, -3), equals(1000));
      expect(round(-123.45, -3), equals(0));
      expect(round(-567.89, -3), equals(-1000));
    });
  });
}
