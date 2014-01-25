import 'package:unittest/unittest.dart';
import 'package:d3/interpolate/interpolate.dart' as libInterpolate;

void main() {
  final Function interpolate = libInterpolate.interpolateNumber;
  group('interpolateNumber', () {
    test('interpolates numbers', () {
      expect(interpolate(2, 12)(.4), same(6.0));
      expect(interpolate(2, 12)(.6), same(8.0));
    });
    test('coerces strings to numbers', () {
      expect(interpolate('2', '12')(.4), same(6.0));
    });
  });
}
