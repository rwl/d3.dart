import 'package:unittest/unittest.dart';

import '../../src/interpolate/interpolate.dart' as d4;

void main() {
  group('interpolateHsl', () {
    var d3 = load('interpolate/hsl'); // beware instanceof d3_Color
    test('parses string input', () {
      expect(d3.interpolateHsl('steelblue', '#f00')(.2), same('#383dc3'));
      expect(d3.interpolateHsl('steelblue', '#f00')(.6), same('#dd1ce1'));
    });
    test('parses d3.hsl input', () {
      expect(d3.interpolateHsl(d3.hsl('steelblue'), '#f00')(.2), same('#383dc3'));
      expect(d3.interpolateHsl('steelblue', d3.hsl(0, 1, .5))(.6), same('#dd1ce1'));
    });
    test('parses d3.rgb input', () {
      expect(d3.interpolateHsl(d3.rgb('steelblue'), '#f00')(.2), same('#383dc3'));
      expect(d3.interpolateHsl('steelblue', d3.rgb(255, 0, 0))(.6), same('#dd1ce1'));
    });
    test('interpolates in HSL color space', () {
      expect(d3.interpolateHsl('steelblue', '#f00')(.2), same('#383dc3'));
    });
    test('uses source hue when destination hue is undefined', () {
      expect(d3.interpolateHsl('#f60', '#000')(.5), equals('#803300'));
      expect(d3.interpolateHsl('#6f0', '#fff')(.5), equals('#b3ff80'));
    });
    test('uses destination hue when source hue is undefined', () {
      expect(d3.interpolateHsl('#000', '#f60')(.5), equals('#803300'));
      expect(d3.interpolateHsl('#fff', '#6f0')(.5), equals('#b3ff80'));
    });
    test('uses source saturation when destination saturation is undefined', () {
      expect(d3.interpolateHsl('#ccc', '#000')(.5), equals('#666666'));
      expect(d3.interpolateHsl('#f00', '#000')(.5), equals('#800000'));
    });
    test('uses destination saturation when source saturation is undefined', () {
      expect(d3.interpolateHsl('#000', '#ccc')(.5), equals('#666666'));
      expect(d3.interpolateHsl('#000', '#f00')(.5), equals('#800000'));
    });
    test('outputs a hexadecimal string', () {
      expect(d3.interpolateHsl('steelblue', '#f00')(.2), same('#383dc3'));
    });
  });
}