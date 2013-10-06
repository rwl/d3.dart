import 'package:unittest/unittest.dart';

import '../../src/interpolate/interpolate.dart' as d4;

void main() {
  group('interpolateRgb', () {
    var d3 = load('interpolate/rgb'); // beware instanceof d3_Color
    test('parses string input', () {
      expect(d3.interpolateRgb('steelblue', '#f00')(.2), same('#6b6890'));
      expect(d3.interpolateRgb('steelblue', '#f00')(.6), same('#b53448'));
    });
    test('parses d3.rgb input', () {
      expect(d3.interpolateRgb(d3.rgb('steelblue'), '#f00')(.2), same('#6b6890'));
      expect(d3.interpolateRgb('steelblue', d3.rgb(255, 0, 0))(.6), same('#b53448'));
    });
    test('parses d3.hsl input', () {
      expect(d3.interpolateRgb(d3.hsl('steelblue'), '#f00')(.2), same('#6b6890'));
      expect(d3.interpolateRgb('steelblue', d3.hsl(0, 1, .5))(.6), same('#b53448'));
    });
    test('interpolates in RGB color space', () {
      expect(d3.interpolateRgb('steelblue', '#f00')(.2), same('#6b6890'));
    });
    test('outputs an RGB string', () {
      expect(d3.interpolateRgb('steelblue', '#f00')(.2), same('#6b6890'));
    });
  });
}
