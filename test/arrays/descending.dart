import 'package:unittest/unittest.dart';

import '../../src/arrays/arrays.dart' as d4;

void main() {
  group('descending', () {
    var descending = load('arrays/descending').expression('d3.descending');
    group('numbers', () {
      test('returns a negative number if a > b', () {
        expect(descending(1, 0) < 0, isTrue);
      });
      test('returns a positive number if a < b', () {
        expect(descending(0, 1) > 0, isTrue);
      });
      test('returns zero if a == b', () {
        expect(descending(0, 0), equals(0));
      });
      test('returns double.NAN if a or b is undefined', () {
        expect(descending(0, undefined), equals(double.NAN));
        expect(descending(undefined, 0), equals(double.NAN));
        expect(descending(undefined, undefined), equals(double.NAN));
      });
      test('returns double.NAN if a or b is double.NAN', () {
        expect(descending(0, double.NAN), equals(double.NAN));
        expect(descending(double.NAN, 0), equals(double.NAN));
        expect(descending(double.NAN, double.NAN), equals(double.NAN));
      });
    });
    group('strings', () {
      test('returns a negative number if a > b', () {
        expect(descending('b', 'a') < 0, isTrue);
      });
      test('returns a positive number if a < b', () {
        expect(descending('a', 'b') > 0, isTrue);
      });
      test('returns zero if a == b', () {
        expect(descending('a', 'a'), equals(0));
      });
    });
  });
}