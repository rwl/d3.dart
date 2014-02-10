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
    test('ignores null, undefined and double.NAN', () {
      //var o = {'valueOf': () { return double.NAN; }};
      expect(max([double.NAN, 1, 2, 3, 4, 5]), equals(5));
      //expect(max([o, 1, 2, 3, 4, 5]), equals(5));
      expect(max([1, 2, 3, 4, 5, double.NAN]), equals(5));
      //expect(max([1, 2, 3, 4, 5, o]), equals(5));
      expect(max([10, null, 3, 5, double.NAN]), equals(10));
      expect(max([-1, null, -3, -5, double.NAN]), equals(-1));
    });
    /*test('compares heterogenous types as numbers', () {
      expect(max([20, '3']), same(20));
      expect(max(['20', 3]), same('20'));
      expect(max([3, '20']), same('20'));
      expect(max(['3', 20]), same(20));
    });*/
    test('returns undefined for empty array', () {
      expect(max([]), isNull);
      expect(max([null]), isNull);
      expect(max([double.NAN]), isNull);
      expect(max([double.NAN, double.NAN]), isNull);
    });
    test('applies the optional accessor function', () {
      expect(max([[1, 2, 3, 4, 5], [2, 4, 6, 8, 10]], (d, i) {
        return d.fold(d[0], (prev, elem) {
          return elem < prev ? elem : prev;
        });
      }), equals(2));
      expect(max([1, 2, 3, 4, 5], (d, i) {
        return i;
      }), equals(4));
    });
  });
}