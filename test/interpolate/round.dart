import 'package:unittest/unittest.dart';

import '../../src/interpolate/interpolate.dart' as d4;

void main() {
  group('interpolateRound', () {
    var interpolate = load('interpolate/round').expression('d3.interpolateRound');
    test('interpolates integers', (interpolate) {
      expect(interpolate(2, 12)(.456), same(7));
      expect(interpolate(2, 12)(.678), same(9));
    });
  });
}
