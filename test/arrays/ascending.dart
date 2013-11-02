import 'package:unittest/unittest.dart';

import '../../src/arrays/arrays.dart';

void main() {
  group('ascending', () {
//    var ascending = load('arrays/ascending').expression('d3.ascending');
    group('numbers', () {
      test('returns a negative number if a < b', () {
        expect(ascendingInt(0, 1) < 0, isTrue);
      });
      test('returns a positive number if a > b', () {
        expect(ascendingInt(1, 0) > 0, isTrue);
      });
      test('returns zero if a == b', () {
        expect(ascendingInt(0, 0), equals(0));
      });
      test('returns double.NAN if a or b is undefined', () {
        expect(ascendingDouble(0.0, null).isNaN, isTrue);
        expect(ascendingDouble(null, 0.0).isNaN, isTrue);
        expect(ascendingDouble(null, null).isNaN, isTrue);
      });
      test('returns double.NAN if a or b is double.NAN', () {
        expect(ascendingDouble(0.0, double.NAN).isNaN, isTrue);
        expect(ascendingDouble(double.NAN, 0.0).isNaN, isTrue);
        expect(ascendingDouble(double.NAN, double.NAN).isNaN, isTrue);
      });
    });
    group('strings', () {
      test('returns a negative number if a < b', () {
        expect(ascendingString('a', 'b') < 0, isTrue);
      });
      test('returns a positive number if a > b', () {
        expect(ascendingString('b', 'a') > 0, isTrue);
      });
      test('returns zero if a == b', () {
        expect(ascendingString('a', 'a'), equals(0));
      });
    });
  });
}
