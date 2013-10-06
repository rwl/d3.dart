import 'package:unittest/unittest.dart';

import '../../src/interpolate/interpolate.dart' as d4;

void main() {
  group('interpolateArray', () {
    var interpolate = load('interpolate/array').expression('d3.interpolateArray');
    test('interpolates defined elements', () {
      expect(interpolate([2, 12], [4, 24])(.5), equals([3, 18]));
    });
    test('interpolates nested objects and arrays', () {
      expect(interpolate([[2, 12]], [[4, 24]])(.5), equals([[3, 18]]));
      expect(interpolate([{foo: [2, 12]}], [{foo: [4, 24]}])(.5), equals([{foo: [3, 18]}]));
    });
    test('merges non-shared elements', () {
      expect(interpolate([2, 12], [4, 24, 12])(.5), equals([3, 18, 12]));
      expect(interpolate([2, 12, 12], [4, 24])(.5), equals([3, 18, 12]));
    });
  });
}
