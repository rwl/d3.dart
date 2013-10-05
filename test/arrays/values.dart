import 'package:unittest/unittest.dart';

import '../../src/arrays/arrays.dart' as d4;

void main() {
  group('values', () {
    var values = load('arrays/values').expression('d3.values');
    test('enumerates every value', () {
      expect(values({a: 1, b: 2}), equals([1, 2]));
    });
    test('includes values defined on prototypes', () {
      abc() {
        this.a = 1;
        this.b = 2;
      }
      abc.prototype.c = 3;
      expect(values(new abc()), equals([1, 2, 3]));
    });
    test('includes null or undefined values', () {
      var v = values({a: undefined, b: null, c: NaN});
      expect(v[0], isUndefined);
      expect(v[1], isNull);
      expect(v[2], isNaN);
      expect(v.length, equals(3));
    });
  });
}
