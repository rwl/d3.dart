import 'package:unittest/unittest.dart';

import '../../src/arrays/arrays.dart' as d4;

void main() {
  group('sum', () {
    var sum = load('arrays/sum').expression('d3.sum');
    test('sums numbers', () {
      expect(sum([1]), equals(1));
      expect(sum([5, 1, 2, 3, 4]), equals(15));
      expect(sum([20, 3]), equals(23));
      expect(sum([3, 20]), equals(23));
    });
    test('sums types that can be coerced to numbers', () {
      expect(sum(['20', '3']), equals(23));
      expect(sum(['3', '20']), equals(23));
      expect(sum(['3', 20]), equals(23));
      expect(sum([20, '3']), equals(23));
      expect(sum([3, '20']), equals(23));
      expect(sum(['20', 3]), equals(23));
    });
    test('ignores non-numeric types', () {
      expect(sum(['a', 'b', 'c']), equals(0));
      expect(sum(['a', 1, '2']), equals(3));
    });
    test('ignores null, undefined and double.NAN', () {
      expect(sum([double.NAN, 1, 2, 3, 4, 5]), equals(15));
      expect(sum([1, 2, 3, 4, 5, double.NAN]), equals(15));
      expect(sum([10, null, 3, null/*undefined*/, 5, double.NAN]), equals(18));
    });
    test('applies the optional acccessor function', () {
      expect(sum([[1, 2, 3, 4, 5], [2, 4, 6, 8, 10]], (d) {
        return sum(d);
      }), equals(45));
      expect(sum([1, 2, 3, 4, 5], (d, i) {
        return i;
      }), equals(10));
    });
    test('returns zero for the empty array', () {
      expect(sum([]), equals(0));
    });
  });
}
