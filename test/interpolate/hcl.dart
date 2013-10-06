import 'package:unittest/unittest.dart';

import '../../src/interpolate/interpolate.dart' as d4;

void main() {
  group('interpolateHcl', () {
    var d3 = load('interpolate/hcl'); // beware instanceof d3_Color
    test('parses string input', () {
      expect(d3.interpolateHcl('steelblue', '#f00')(.2), same('#6978c9'));
      expect(d3.interpolateHcl('steelblue', '#f00')(.6), same('#e034a2'));
    });
    test('parses d3.hsl input', () {
      expect(d3.interpolateHcl(d3.hsl('steelblue'), '#f00')(.2), same('#6978c9'));
      expect(d3.interpolateHcl('steelblue', d3.hsl(0, 1, .5))(.6), same('#e034a2'));
    });
    test('parses d3.rgb input', () {
      expect(d3.interpolateHcl(d3.rgb('steelblue'), '#f00')(.2), same('#6978c9'));
      expect(d3.interpolateHcl('steelblue', d3.rgb(255, 0, 0))(.6), same('#e034a2'));
    });
    test('interpolates in HSL color space', () {
      expect(d3.interpolateHcl('steelblue', '#f00')(.2), same('#6978c9'));
    });
    test('uses source hue when destination hue is undefined', () {
      expect(d3.interpolateHcl('#f60', '#000')(.5), equals('#9b0000'));
      expect(d3.interpolateHcl('#6f0', '#000')(.5), equals('#008100'));
    });
    test('uses destination hue when source hue is undefined', () {
      expect(d3.interpolateHcl('#000', '#f60')(.5), equals('#9b0000'));
      expect(d3.interpolateHcl('#000', '#6f0')(.5), equals('#008100'));
    });
    test('uses source chroma when destination chroma is undefined', () {
      expect(d3.interpolateHcl('#ccc', '#000')(.5), equals('#616161'));
      expect(d3.interpolateHcl('#f00', '#000')(.5), equals('#a60000'));
    });
    test('uses destination chroma when source chroma is undefined', () {
      expect(d3.interpolateHcl('#000', '#ccc')(.5), equals('#616161'));
      expect(d3.interpolateHcl('#000', '#f00')(.5), equals('#a60000'));
    });
    test('outputs a hexadecimal string', () {
      expect(d3.interpolateHcl('steelblue', '#f00')(.2), same('#6978c9'));
    });
  });
}
