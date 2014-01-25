import 'package:unittest/unittest.dart';
import 'package:d3/interpolate/interpolate.dart' as libInterpolate;

void main() {
  group('interpolateArray', () {
    final Function interpolate = libInterpolate.interpolateArray;
    test('interpolates defined elements', () {
      expect(interpolate([2, 12], [4, 24])(.5), equals([3, 18]));
    });
    test('interpolates nested objects and arrays', () {
      expect(interpolate([[2, 12]], [[4, 24]])(.5), equals([[3, 18]]));
      expect(interpolate([{'foo': [2, 12]}], [{'foo': [4, 24]}])(.5), equals([{'foo': [3, 18]}]));
    });
    test('merges non-shared elements', () {
      expect(interpolate([2, 12], [4, 24, 12])(.5), equals([3, 18, 12]));
      expect(interpolate([2, 12, 12], [4, 24])(.5), equals([3, 18, 12]));
    });
  });
}
