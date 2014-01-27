import 'package:unittest/unittest.dart';
import 'package:d3/interpolate/interpolate.dart';
import 'package:d3/color/color.dart';

void main() {
  group('interpolateRgb', () {
    test('parses string input', () {
      expect(interpolateRgb('steelblue', '#f00')(.2), equals('#6b6890'));
      expect(interpolateRgb('steelblue', '#f00')(.6), equals('#b53448'));
    });
    test('parses rgb input', () {
      expect(interpolateRgb(rgb('steelblue'), '#f00')(.2), equals('#6b6890'));
      expect(interpolateRgb('steelblue', rgb(255, 0, 0))(.6), equals('#b53448'));
    });
    test('parses d3.hsl input', () {
      expect(interpolateRgb(hsl('steelblue'), '#f00')(.2), equals('#6b6890'));
      expect(interpolateRgb('steelblue', hsl(0, 1, .5))(.6), equals('#b53448'));
    });
    test('interpolates in RGB color space', () {
      expect(interpolateRgb('steelblue', '#f00')(.2), equals('#6b6890'));
    });
    test('outputs an RGB string', () {
      expect(interpolateRgb('steelblue', '#f00')(.2), equals('#6b6890'));
    });
  });
}
