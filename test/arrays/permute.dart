import 'package:unittest/unittest.dart';

import '../../src/arrays/arrays.dart' as d4;

void main() {
  group('permute', () {
    var permute = load('arrays/permute').expression('d3.permute');
    test('permutes according to the specified index', () {
      expect(permute([3, 4, 5], [2, 1, 0]), equals([5, 4, 3]));
      expect(permute([3, 4, 5], [2, 0, 1]), equals([5, 3, 4]));
      expect(permute([3, 4, 5], [0, 1, 2]), equals([3, 4, 5]));
    });
    test('does not modify the input array', () {
      var input = [3, 4, 5];
      permute(input, [2, 1, 0]);
      expect(input, equals([3, 4, 5]));
    });
    test('can duplicate input values', () {
      expect(permute([3, 4, 5], [0, 1, 0]), equals([3, 4, 3]));
      expect(permute([3, 4, 5], [2, 2, 2]), equals([5, 5, 5]));
      expect(permute([3, 4, 5], [0, 1, 1]), equals([3, 4, 4]));
    });
    test('can return more elements', () {
      expect(permute([3, 4, 5], [0, 0, 1, 2]), equals([3, 3, 4, 5]));
      expect(permute([3, 4, 5], [0, 1, 1, 1]), equals([3, 4, 4, 4]));
    });
    test('can return fewer elements', () {
      expect(permute([3, 4, 5], [0]), equals([3]));
      expect(permute([3, 4, 5], [1, 2]), equals([4, 5]));
      expect(permute([3, 4, 5], []), equals([]));
    });
    test('can return undefined elements', () {
      var v1 = permute([3, 4, 5], [10]);
      expect(v1.length, equals(1));
      expect(v1[0], isUndefined);
      var v2 = permute([3, 4, 5], [-1]);
      expect(v2.length, equals(1));
      expect(v2[0], isUndefined);
      var v3 = permute([3, 4, 5], [0, -1]);
      expect(v3.length, equals(2));
      expect(v3[0], equals(3));
      expect(v3[1], isUndefined);
    });
  });
}
