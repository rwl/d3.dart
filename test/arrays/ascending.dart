import 'package:unittest/unittest.dart';

import '../../src/arrays/arrays.dart' as d4;

void main() {
  group('ascending', () {
    var ascending = load('arrays/ascending').expression('d3.ascending');
    group('numbers', () {
      test('returns a negative number if a < b', () {
        expect(ascending(0, 1) < 0, isTrue);
      });
      test('returns a positive number if a > b', () {
        expect(ascending(1, 0) > 0, isTrue);
      });
      test('returns zero if a == b', () {
        expect(ascending(0, 0), equals(0));
      });
      test('returns double.NAN if a or b is undefined', () {
        expect(ascending(0, undefined), equals(double.NAN));
        expect(ascending(undefined, 0), equals(double.NAN));
        expect(ascending(undefined, undefined), equals(double.NAN));
      });
      test('returns double.NAN if a or b is double.NAN', () {
        expect(ascending(0, double.NAN), equals(double.NAN));
        expect(ascending(double.NAN, 0), equals(double.NAN));
        expect(ascending(double.NAN, double.NAN), equals(double.NAN));
      });
    });
    group('strings', () {
      test('returns a negative number if a < b', () {
        expect(ascending('a', 'b') < 0, isTrue);
      });
      test('returns a positive number if a > b', () {
        expect(ascending('b', 'a') > 0, isTrue);
      });
      test('returns zero if a == b', () {
        expect(ascending('a', 'a'), equals(0));
      });
    });
  });
}
