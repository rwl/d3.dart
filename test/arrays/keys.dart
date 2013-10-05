import 'package:unittest/unittest.dart';

import '../../src/arrays/arrays.dart' as d4;

void main() {
  group('keys', () {
    var keys = load('arrays/keys').expression('d3.keys');
    test('enumerates every defined key', () {
      expect(keys({a: 1, b: 1}), equals(['a', 'b']));
    });
    test('includes keys defined on prototypes', () {
      abc() {
        this.a = 1;
        this.b = 2;
      }
      abc.prototype.c = 3;
      expect(keys(new abc()), equals(['a', 'b', 'c']));
    });
    test('includes keys with null or undefined values', () {
      expect(keys({a: null/*undefined*/, b: null, c: double.NAN}),
          equals(['a', 'b', 'c']));
    });
  });
}
