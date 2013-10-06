import 'package:unittest/unittest.dart';

import '../../src/interpolate/interpolate.dart' as d4;

void main() {
  group('interpolateTransform', () {
    var d3 = load('interpolate/interpolate').document();
    group('interpolation of a decomposed transform', () {
      // Use a custom d3.transform to parse a decomposed transform, since
      // JSDOM doesn't support consolidating SVG transform strings.
      d3.transform = (s) {
        var m = s.split(','g).map(Number);
        return {
          translate: [m[0], m[1]],
          rotate: m[2],
          skew: m[3],
          scale: [m[4], m[5]]
        };
      };
      test('identity', () {
        expect(d3.interpolateTransform([0, 0, 0, 0, 1, 1] + '', [0, 0, 0, 0, 1, 1] + '')(.4), same(''));
      });
      group('translate', () {
        test('x', () {
          expect(d3.interpolateTransform([0, 0, 0, 0, 1, 1] + '', [10, 0, 0, 0, 1, 1] + '')(.4), same('translate(4,0)'));
        });
        test('y', () {
          expect(d3.interpolateTransform([0, 0, 0, 0, 1, 1] + '', [0, 10, 0, 0, 1, 1] + '')(.4), same('translate(0,4)'));
        });
        test('x and y', () {
          expect(d3.interpolateTransform([0, 0, 0, 0, 1, 1] + '', [1, 10, 0, 0, 1, 1] + '')(.4), same('translate(0.4,4)'));
        });
      });
      group('rotate', () {
        test('simple', () {
          expect(d3.interpolateTransform([0, 0, -10, 0, 1, 1] + '', [0, 0, 30, 0, 1, 1] + '')(.4), same('rotate(6)'));
        });
        test('with constant translate', () {
          expect(d3.interpolateTransform([5, 6, -10, 0, 1, 1] + '', [5, 6, 30, 0, 1, 1] + '')(.4), same('translate(5,6)rotate(6)'));
        });
      });
      test('skew', () {
        expect(d3.interpolateTransform([0, 0, 0, 0, 1, 1] + '', [0, 0, 0, 40, 1, 1] + '')(.4), same('skewX(16)'));
      });
      test('scale', () {
        expect(d3.interpolateTransform([0, 0, 0, 0, 1, 1] + '', [0, 0, 0, 0, 10, 1] + '')(.5), same('scale(5.5,1)'));
      });
      test('translate and rotate', () {
        expect(d3.interpolateTransform([0, 0, 0, 0, 1, 1] + '', [100, 0, 90, 0, 1, 1] + '')(.5), same('translate(50,0)rotate(45)'));
      });
    });
  });
}
