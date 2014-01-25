import 'package:unittest/unittest.dart';
import 'package:d3/interpolate/interpolate.dart';

void main() {
  group('interpolate', () {
    group('when b is a number', () {
      test('interpolates numbers', () {
        expect(interpolate(2, 12)(.4), same(6.0));
      });
      test('coerces a to a number', () {
        expect(interpolate('', 1)(.5), same(.5));
        expect(interpolate('2', 12)(.4), same(6.0));
//        expect(interpolate([2], 12)(.4), same(6.0));
      });
    });
  });
}
