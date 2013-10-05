import 'package:unittest/unittest.dart';

import '../../src/arrays/arrays.dart' as d4;

void main() {
  group('zip', () {
    var zip = load('arrays/zip').expression('d3.zip');
    test('transposes a square matrix', () {
      expect(zip([1, 2], [3, 4]), equals([[1, 3], [2, 4]]));
    });
    test('transposes a non-square matrix', () {
      expect(zip([1, 2, 3, 4, 5], [2, 4, 6, 8, 10]), equals([[1, 2], [2, 4], [3, 6], [4, 8], [5, 10]]));
    });
    test('transposes a single-row matrix', () {
      expect(zip([1, 2, 3, 4, 5]), equals([[1], [2], [3], [4], [5]]));
    });
    test('transposes an empty matrix', () {
      expect(zip(), equals([]));
    });
    test('ignores extra elements given an irregular matrix', () {
      expect(zip([1, 2], [3, 4], [5, 6, 7]), equals([[1, 3, 5], [2, 4, 6]]));
    });
  });
}
