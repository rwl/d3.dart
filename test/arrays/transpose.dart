import 'package:unittest/unittest.dart';

import '../../src/arrays/arrays.dart' as d4;

void main() {
  group('transpose', () {
    var transpose = load('arrays/transpose').expression('d3.transpose');
    test('transposes a square matrix', () {
      expect(transpose([[1, 2], [3, 4]]), equals([[1, 3], [2, 4]]));
    });
    test('transposes a non-square matrix', () {
      expect(transpose([[1, 2, 3, 4, 5], [2, 4, 6, 8, 10]]), equals([[1, 2], [2, 4], [3, 6], [4, 8], [5, 10]]));
    });
    test('transposes a single-row matrix', () {
      expect(transpose([[1, 2, 3, 4, 5]]), equals([[1], [2], [3], [4], [5]]));
    });
    test('transposes an empty matrix', () {
      expect(transpose([]), equals([]));
    });
    test('ignores extra elements given an irregular matrix', () {
      expect(transpose([[1, 2], [3, 4], [5, 6, 7]]), equals([[1, 3, 5], [2, 4, 6]]));
    });
  });
}
