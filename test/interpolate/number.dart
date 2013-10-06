import 'package:unittest/unittest.dart';

import '../../src/interpolate/interpolate.dart' as d4;

void main() {
  group('interpolateNumber', () {
    var interpolate = load('interpolate/number').expression('d3.interpolateNumber');
    test('interpolates numbers', () {
      expect(interpolate(2, 12)(.4), same(6));
      expect(interpolate(2, 12)(.6), same(8));
    });
    test('coerces strings to numbers', () {
      expect(interpolate('2', '12')(.4), same(6));
    });
  });
}
