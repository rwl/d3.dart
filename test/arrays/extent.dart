import 'package:unittest/unittest.dart';

import '../../src/arrays/arrays.dart' as d4;

void main() {
  group('extent', () {
    var extent = load('arrays/extent').expression('d3.extent');
    test('returns the numeric extent for numbers', () {
      expect(extent([1]), equals([1, 1]);
      expect(extent([5, 1, 2, 3, 4]), equals([1, 5]));
      expect(extent([20, 3]), equals([3, 20]));
      expect(extent([3, 20]), equals([3, 20]));
    });
    test('returns the lexicographic extent for strings', () {
      expect(extent(['c', 'a', 'b']), equals(['a', 'c']));
      expect(extent(['20', '3']), equals(['20', '3']));
      expect(extent(['3', '20']), equals(['20', '3']));
    });
    test('ignores null, null and double.NAN', () {
      var o = {valueOf: () { return double.NAN; }};
      expect(extent([double.NAN, 1, 2, 3, 4, 5]), equals([1, 5]));
      expect(extent([o, 1, 2, 3, 4, 5]), equals([1, 5]));
      expect(extent([1, 2, 3, 4, 5, double.NAN]), equals([1, 5]));
      expect(extent([1, 2, 3, 4, 5, o]), equals([1, 5]));
      expect(extent([10, null, 3, null, 5, double.NAN]), equals([3, 10]));
      expect(extent([-1, null, -3, null, -5, double.NAN]), equals([-5, -1]));
    });
    test('compares heterogenous types as numbers', () {
      expect(extent([20, '3']), equals(['3', 20]));
      expect(extent(['20', 3]), equals([3, '20']));
      expect(extent([3, '20']), equals([3, '20']));
      expect(extent(['3', 20]), equals(['3', 20]));
    });
    test('returns null for empty array', () {
      expect(extent([]), equals([null, null]));
      expect(extent([null]), equals([null, null]));
      expect(extent([null]), equals([null, null]));
      expect(extent([double.NAN]), equals([null, null]));
      expect(extent([double.NAN, double.NAN]), equals([null, null]));
    });
    test('applies the optional accessor function exactly once', () {
      var i = 10;
      expect(extent([0,1,2,3], () { return ++i; }), equals([11, 14]));
    });
  });
}
