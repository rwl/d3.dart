import 'package:unittest/unittest.dart';

import '../../src/scale/scale.dart' as d4;

void main() {
  group('quantile', () {
    var quantile = load('scale/quantile').expression('d3.scale.quantile');
    test('has the empty domain by default', () {
      expect(quantile().domain(), isEmpty);
    });
    test('has the empty range by default', () {
      expect(quantile().range(), isEmpty);
    });
    test('uses the R-7 algorithm to compute quantiles', () {
      var x = quantile().domain([3, 6, 7, 8, 8, 10, 13, 15, 16, 20]).range([0, 1, 2, 3]);
      expect([3, 6, 6.9, 7, 7.1].map(x), equals([0, 0, 0, 0, 0]));
      expect([8, 8.9].map(x), equals([1, 1]));
      expect([9, 9.1, 10, 13].map(x), equals([2, 2, 2, 2]));
      expect([14.9, 15, 15.1, 16, 20].map(x), equals([3, 3, 3, 3, 3]));
      x = quantile().domain([3, 6, 7, 8, 8, 9, 10, 13, 15, 16, 20]).range([0, 1, 2, 3]);
      expect([3, 6, 6.9, 7, 7.1].map(x), equals([0, 0, 0, 0, 0]));
      expect([8, 8.9].map(x), equals([1, 1]));
      expect([9, 9.1, 10, 13].map(x), equals([2, 2, 2, 2]));
      expect([14.9, 15, 15.1, 16, 20].map(x), equals([3, 3, 3, 3, 3]));
    });
    test('domain values are sorted in ascending order', () {
      var x = quantile().domain([6, 3, 7, 8, 8, 13, 20, 15, 16, 10]);
      expect(x.domain(), equals([3, 6, 7, 8, 8, 10, 13, 15, 16, 20]));
    });
    test('non-numeric domain values are ignored', () {
      var x = quantile().domain([6, 3, NaN, undefined, 7, 8, 8, 13, 20, 15, 16, 10, NaN]);
      expect(x.domain(), equals([3, 6, 7, 8, 8, 10, 13, 15, 16, 20]));
    });
    test('quantiles returns the inner thresholds', () {
      var x = quantile().domain([3, 6, 7, 8, 8, 10, 13, 15, 16, 20]).range([0, 1, 2, 3]);
      expect(x.quantiles(), equals([7.25, 9, 14.5]));
      x = quantile().domain([3, 6, 7, 8, 8, 9, 10, 13, 15, 16, 20]).range([0, 1, 2, 3]);
      expect(x.quantiles(), equals([7.5, 9, 14]));
    });
    test('range cardinality determines the number of quantiles', () {
      var x = quantile().domain([3, 6, 7, 8, 8, 10, 13, 15, 16, 20]);
      expect(x.range([0, 1, 2, 3]).quantiles(), equals([7.25, 9, 14.5]));
      expect(x.range([0, 1]).quantiles(), equals([9]));
      expect(x.range([,,,,,]).quantiles(), equals([6.8, 8, 11.2, 15.2]));
      expect(x.range([,,,,,,]).quantiles(), equals([6.5, 8, 9, 13, 15.5]));
    });
    test('range values are arbitrary', () {
      var a = new Object(), b = new Object(), c = new Object();
      var x = quantile().domain([3, 6, 7, 8, 8, 10, 13, 15, 16, 20]).range([a, b, c, a]);
      expect([3, 6, 6.9, 7, 7.1].map(x), equals([a, a, a, a, a]));
      expect([8, 8.9].map(x), equals([b, b]));
      expect([9, 9.1, 10, 13].map(x), equals([c, c, c, c]));
      expect([14.9, 15, 15.1, 16, 20].map(x), equals([a, a, a, a, a]));
    });
    test('returns undefined if the input value is NaN', () {
      var x = quantile().domain([3, 6, 7, 8, 8, 10, 13, 15, 16, 20]).range([0, 1, 2, 3]);
      expect(x(NaN), isUndefined);
    });
    group('invertExtent', () {
      test('maps a value in the range to a domain extent', () {
        var x = quantile().domain([3, 6, 7, 8, 8, 10, 13, 15, 16, 20]).range([0, 1, 2, 3]);
        expect(x.invertExtent(0), equals([3, 7.25]));
        expect(x.invertExtent(1), equals([7.25, 9]));
        expect(x.invertExtent(2), equals([9, 14.5]));
        expect(x.invertExtent(3), equals([14.5, 20]));
      });
      test('allows arbitrary range values', () {
        var a = {}, b = {}, x = quantile().domain([3, 6, 7, 8, 8, 10, 13, 15, 16, 20]).range([a, b]);
        expect(x.invertExtent(a), equals([3, 9]));
        expect(x.invertExtent(b), equals([9, 20]));
      });
      test('returns [NaN, NaN] when the given value is not in the range', () {
        var x = quantile().domain([3, 6, 7, 8, 8, 10, 13, 15, 16, 20]);
        expect(x.invertExtent(-1).every(isNaN), ok);
        expect(x.invertExtent(.5).every(isNaN), ok);
        expect(x.invertExtent(2).every(isNaN), ok);
        expect(x.invertExtent('a').every(isNaN), ok);
      });
      test('returns the first match if duplicate values exist in the range', () {
        var x = quantile().domain([3, 6, 7, 8, 8, 10, 13, 15, 16, 20]).range([0, 1, 2, 0]);
        expect(x.invertExtent(0), equals([3, 7.25]));
        expect(x.invertExtent(1), equals([7.25, 9]));
        expect(x.invertExtent(2), equals([9, 14.5]));
      });
    });
  });
}
