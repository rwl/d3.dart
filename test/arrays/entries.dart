import 'package:unittest/unittest.dart';

import '../../src/arrays/arrays.dart' as d4;

void main() {
  group('entries', () {
    var entries = load('arrays/entries').expression('d3.entries');
    test('enumerates every entry', () {
      expect(entries({a: 1, b: 2}), equals([
        {key: 'a', value: 1},
        {key: 'b', value: 2}
      ]));
    });
    test('includes entries defined on prototypes', () {
      abc() {
        this.a = 1;
        this.b = 2;
      }
      abc.prototype.c = 3;
      expect(entries(new abc()), equals([
        {key: 'a', value: 1},
        {key: 'b', value: 2},
        {key: 'c', value: 3}
      ]));
    });
    test('includes null or undefined values', () {
      var v = entries({a: null/*undefined*/, b: null, c: double.NAN});
      expect(v.length, equals(3));
      expect(v[0], equals({key: 'a', value: null/*undefined*/}));
      expect(v[1], equals({key: 'b', value: null}));
      expect(v[2].key, equals('c'));
      expect(v[2].value, equals(double.NAN));
    });
  });
}
