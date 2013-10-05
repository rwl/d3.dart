import 'package:unittest/unittest.dart';

import '../../src/arrays/arrays.dart' as d4;

void main() {
  group('min', () {
    var min = load('arrays/min').expression('d3.min');
    test('returns the least numeric value for numbers', () {
      expect(min([1]), equals(1));
      expect(min([5, 1, 2, 3, 4]), equals(1));
      expect(min([20, 3]), equals(3));
      expect(min([3, 20]), equals(3));
    });
    test('returns the least lexicographic value for strings', () {
      expect(min(['c', 'a', 'b']), equals('a'));
      expect(min(['20', '3']), equals('20'));
      expect(min(['3', '20']), equals('20'));
    });
    test('ignores null, undefined and double.NAN', () {
      var o = {valueOf: () { return double.NAN; }};
      expect(min([double.NAN, 1, 2, 3, 4, 5]), equals(1));
      expect(min([o, 1, 2, 3, 4, 5]), equals(1));
      expect(min([1, 2, 3, 4, 5, double.NAN]), equals(1));
      expect(min([1, 2, 3, 4, 5, o]), equals(1));
      expect(min([10, null, 3, null/*undefined*/, 5, double.NAN]), equals(3));
      expect(min([-1, null, -3, null/*undefined*/, -5, double.NAN]), equals(-5));
    });
    test('compares heterogenous types as numbers', () {
      expect(min([20, '3']), same('3'));
      expect(min(['20', 3]), same(3));
      expect(min([3, '20']), same(3));
      expect(min(['3', 20]), same('3'));
    });
    test('returns undefined for empty array', () {
      expect(min([]), isUndefined);
      expect(min([null]), isUndefined);
      expect(min([undefined]), isUndefined);
      expect(min([double.NAN]), isUndefined);
      expect(min([double.NAN, double.NAN]), isUndefined);
    });
    test('applies the optional accessor function', () {
      expect(min([[1, 2, 3, 4, 5], [2, 4, 6, 8, 10]], (d) {
        return _.max(d);
      }), equals(5));
      expect(min([1, 2, 3, 4, 5], (d, i) {
        return i;  
      }), equals(0));
    });
  });
}