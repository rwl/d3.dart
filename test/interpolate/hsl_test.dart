import 'package:unittest/unittest.dart';
import 'package:d3/interpolate/interpolate.dart';
import 'package:d3/color/color.dart';

void main() {
  group('interpolateHsl', () {
    test('parses string input', () {
      expect(interpolateHsl('steelblue', '#f00')(.2), equals('#383dc3'));
      expect(interpolateHsl('steelblue', '#f00')(.6), equals('#dd1ce1'));
    });
    test('parses hsl input', () {
      expect(interpolateHsl(hsl('steelblue'), '#f00')(.2), equals('#383dc3'));
      expect(interpolateHsl('steelblue', hsl(0, 1, .5))(.6), equals('#dd1ce1'));
    });
    test('parses d3.rgb input', () {
      expect(interpolateHsl(rgb('steelblue'), '#f00')(.2), equals('#383dc3'));
      expect(interpolateHsl('steelblue', rgb(255, 0, 0))(.6), equals('#dd1ce1'));
    });
    test('interpolates in HSL color space', () {
      expect(interpolateHsl('steelblue', '#f00')(.2), equals('#383dc3'));
    });
    test('uses source hue when destination hue is undefined', () {
      expect(interpolateHsl('#f60', '#000')(.5), equals('#803300'));
      expect(interpolateHsl('#6f0', '#fff')(.5), equals('#b3ff80'));
    });
    test('uses destination hue when source hue is undefined', () {
      expect(interpolateHsl('#000', '#f60')(.5), equals('#803300'));
      expect(interpolateHsl('#fff', '#6f0')(.5), equals('#b3ff80'));
    });
    test('uses source saturation when destination saturation is undefined', () {
      expect(interpolateHsl('#ccc', '#000')(.5), equals('#666666'));
      expect(interpolateHsl('#f00', '#000')(.5), equals('#800000'));
    });
    test('uses destination saturation when source saturation is undefined', () {
      expect(interpolateHsl('#000', '#ccc')(.5), equals('#666666'));
      expect(interpolateHsl('#000', '#f00')(.5), equals('#800000'));
    });
    test('outputs a hexadecimal string', () {
      expect(interpolateHsl('steelblue', '#f00')(.2), equals('#383dc3'));
    });
  });
}
