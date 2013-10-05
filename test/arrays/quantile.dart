import 'package:unittest/unittest.dart';

import '../../src/arrays/arrays.dart' as d4;

void main() {
  group('quantile', () {
    var quantile = load('arrays/quantile').expression('d3.quantile');
    test('requires sorted numeric input', () {
      expect(quantile([1, 2, 3, 4], 0), equals(1));
      expect(quantile([1, 2, 3, 4], 1), equals(4));
      expect(quantile([4, 3, 2, 1], 0), equals(4));
      expect(quantile([4, 3, 2, 1], 1), equals(1));
    });
    test('uses the R-7 algorithm', () {
      var data = [3, 6, 7, 8, 8, 10, 13, 15, 16, 20];
      expect(quantile(data, 0), equals(3));
      expect(quantile(data, .25), equals(7.25));
      expect(quantile(data, .5), equals(9));
      expect(quantile(data, .75), equals(14.5));
      expect(quantile(data, 1), equals(20));
      var data = [3, 6, 7, 8, 8, 9, 10, 13, 15, 16, 20];
      expect(quantile(data, 0), equals(3));
      expect(quantile(data, .25), equals(7.5));
      expect(quantile(data, .5), equals(9));
      expect(quantile(data, .75), equals(14));
      expect(quantile(data, 1), equals(20));
    });
    test('coerces values to numbers', () {
      var strings = ['1', '2', '3', '4'];
      expect(quantile(strings, 1/3), same(2));
      expect(quantile(strings, 1/2), same(2.5));
      expect(quantile(strings, 2/3), same(3));
      var dates = [new Date(2011, 0, 1), new Date(2012, 0, 1)];
      expect(quantile(dates, 0), same(/*+*/new Date(2011, 0, 1)));
      expect(quantile(dates, 1/2), same(/*+*/new Date(2011, 6, 2, 13)));
      expect(quantile(dates, 1), same(/*+*/new Date(2012, 0, 1)));
    });
    test('returns an exact value for integer p-values', () {
      var data = [1, 2, 3, 4];
      expect(quantile(data, 1/3), equals(2));
      expect(quantile(data, 2/3), equals(3));
    });
    test('returns the first value for p = 0', () {
      var data = [1, 2, 3, 4];
      expect(quantile(data, 0), equals(1));
    });
    test('returns the last value for p = 1', () {
      var data = [1, 2, 3, 4];
      expect(quantile(data, 1), equals(4));
    });
  });
}
