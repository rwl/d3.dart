import 'package:unittest/unittest.dart';
import 'package:d3/arrays/arrays.dart';

void main() {
  group('max', () {
    test('returns the greatest numeric value for numbers', () {
      expect(max([1]), equals(1));
      expect(max([5, 1, 2, 3, 4]), equals(5));
      expect(max([20, 3]), equals(20));
      expect(max([3, 20]), equals(20));
    });
    test('returns the greatest lexicographic value for strings', () {
      expect(max(['c', 'a', 'b']), equals('c'));
      expect(max(['20', '3']), equals('3'));
      expect(max(['3', '20']), equals('3'));
    });
  });
}