import 'package:unittest/unittest.dart';

import '../../src/arrays/arrays.dart' as d4;

void main() {
  group('merge', () {
    var merge = load('arrays/merge').expression('d3.merge');
    test('merges an array of arrays', () {
      var a = {}, b = {}, c = {}, d = {}, e = {}, f = {};
      expect(merge([[a], [b, c], [d, e, f]]), equals([a, b, c, d, e, f]));
    });
    test('returns a new array', () {
      var input = [[1, 2, 3], [4, 5], [6]];
      expect(merge(input) ==/*=*/ input, isFalse);
    });
    test('does not modify the input arrays', () {
      var input = [[1, 2, 3], [4, 5], [6]];
      merge(input);
      expect(input, equals([[1, 2, 3], [4, 5], [6]]));
    });
  });
}
