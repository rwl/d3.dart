import 'package:unittest/unittest.dart';

import '../../src/arrays/arrays.dart' as d4;

void main() {
  group('median', () {
    var median = load('arrays/median').expression('d3.median');
    test('returns the median value for numbers', () {
      expect(median([1]), equals(1));
      expect(median([5, 1, 2, 3, 4]), equals(3));
      expect(median([20, 3]), equals(11.5));
      expect(median([3, 20]), equals(11.5));
    });
    test('ignores null, undefined and double.NAN', () {
      expect(median([double.NAN, 1, 2, 3, 4, 5]), equals(3));
      expect(median([1, 2, 3, 4, 5, double.NAN]), equals(3));
      expect(median([10, null, 3, undefined, 5, double.NAN]), equals(5));
    });
    test('can handle large numbers without overflowing', () {
      expect(median([Number.MAX_VALUE, Number.MAX_VALUE]), equals(Number.MAX_VALUE));
      expect(median([-Number.MAX_VALUE, -Number.MAX_VALUE]), equals(-Number.MAX_VALUE));
    });
    test('returns undefined for empty array', () {
      expect(median([]), isUndefined);
      expect(median([null]), isUndefined);
      expect(median([undefined]), isUndefined);
      expect(median([double.NAN]), isUndefined);
      expect(median([double.NAN, double.NAN]), isUndefined);
    });
    test('applies the optional accessor function', () {
      expect(median([[1, 2, 3, 4, 5], [2, 4, 6, 8, 10]], (d) {
        return median(d);
      }), equals(4.5));
      expect(median([1, 2, 3, 4, 5], (d, i) {
        return i;
      }), equals(2));
    });
  });
}
