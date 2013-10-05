import 'package:unittest/unittest.dart';

import '../../src/arrays/arrays.dart' as d4;

void main() {
  group('pairs', () {
    var pairs = load('arrays/pairs').expression('d3.pairs');
    test('returns the empty array if input array has length less than two', () {
      expect(pairs([]), equals([]));
      expect(pairs([1]), equals([]));
    });
    test('returns pairs of adjacent elements in the given array', () {
      expect(pairs([1, 2]), equals([[1, 2]]));
      expect(pairs([1, 2, 3]), equals([[1, 2], [2, 3]]));
      var a = {}, b = {}, c = {}, d = {};
      expect(pairs([a, b, c, d]), equals([[a, b], [b, c], [c, d]]));
    });
    test('includes null or undefined elements in pairs', () {
      expect(pairs([1, null, 2]), equals([[1, null], [null, 2]]));
      expect(pairs([1, 2, null/*undefined*/]), equals([[1, 2], [2, null/*undefined*/]]));
    });
  });
}
