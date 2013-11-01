import 'package:unittest/unittest.dart';

import '../../src/scale/scale.dart' as d4;

void main() {
  group('threshold', () {
    var threshold = load('scale/threshold').expression('d3.scale.threshold');
    test('has the default domain [.5]', () {
      var x = threshold();
      expect(x.domain(), equals([.5]));
      expect(x(.49), equals(0));
    });
    test('has the default range [0, 1]', () {
      var x = threshold();
      expect(x.range(), equals([0, 1]));
      expect(x(.50), equals(1));
    });
    test('maps a number to a discrete value in the range', () {
      var x = threshold().domain([1/3, 2/3]).range(['a', 'b', 'c']);
      expect(x(0), equals('a'));
      expect(x(.2), equals('a'));
      expect(x(.4), equals('b'));
      expect(x(.6), equals('b'));
      expect(x(.8), equals('c'));
      expect(x(1), equals('c'));
    });
    test('returns undefined if the specified value is not orderable', () {
      var x = threshold().domain([1/3, 2/3]).range(['a', 'b', 'c']);
      expect(x(), isUndefined);
      expect(x(undefined), isUndefined);
      expect(x(NaN), isUndefined);
      expect(x(null), equals('a')); // null < 1/3
    });
    test('domain values are arbitrary', () {
      var x = threshold().domain(['10', '2']).range([0, 1, 2]);
      expect(x.domain()[0], same('10'));
      expect(x.domain()[1], same('2'));
      expect(x('0'), equals(0));
      expect(x('12'), equals(1));
      expect(x('3'), equals(2));
    });
    test('range values are arbitrary', () {
      var a = {}, b = {}, c = {}, x = threshold().domain([1/3, 2/3]).range([a, b, c]);
      expect(x(0), equals(a));
      expect(x(.2), equals(a));
      expect(x(.4), equals(b));
      expect(x(.6), equals(b));
      expect(x(.8), equals(c));
      expect(x(1), equals(c));
    });
    group('invertExtent', () {
      test('returns the domain extent for the specified range value', () {
        var a = {}, b = {}, c = {}, x = threshold().domain([1/3, 2/3]).range([a, b, c]);
        expect(x.invertExtent(a), equals([undefined, 1/3]));
        expect(x.invertExtent(b), equals([1/3, 2/3]));
        expect(x.invertExtent(c), equals([2/3, undefined]));
      });
    });
  });
}
