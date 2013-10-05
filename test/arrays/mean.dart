import 'package:unittest/unittest.dart';

import '../../src/arrays/arrays.dart' as d4;

void main() {
  group('mean', () {
    var mean = load('arrays/mean').expression('d3.mean');
    test('returns the mean value for numbers', () {
      expect(mean([1]), equals(1));
      expect(mean([5, 1, 2, 3, 4]), equals(3));
      expect(mean([20, 3]), equals(11.5));
      expect(mean([3, 20]), equals(11.5));
    });
    test('ignores null, undefined and NaN', () {
      expect(mean([NaN, 1, 2, 3, 4, 5]), equals(3));
      expect(mean([1, 2, 3, 4, 5, NaN]), equals(3));
      expect(mean([10, null, 3, undefined, 5, NaN]), equals(6));
    });
    test('can handle large numbers without overflowing', () {
      expect(mean([Number.MAX_VALUE, Number.MAX_VALUE]), equals(Number.MAX_VALUE));
      expect(mean([-Number.MAX_VALUE, -Number.MAX_VALUE]), equals(-Number.MAX_VALUE));
    });
    test('returns undefined for empty array', () {
      expect(mean([]), isUndefined);
      expect(mean([null]), isUndefined);
      expect(mean([null/*undefined*/]), isUndefined);
      expect(mean([double.NAN]), isUndefined);
      expect(mean([double.NAN, double.NAN]), isUndefined);
    });
    test('applies the optional accessor function', () {
      expect(mean([[1, 2, 3, 4, 5], [2, 4, 6, 8, 10]], (d) {
        return mean(d);
      }), equals(4.5));
      expect(mean([1, 2, 3, 4, 5], (d, i) {
        return i;
      }), equals(2));
    });
  });
}