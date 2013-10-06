import 'package:unittest/unittest.dart';

import '../../src/interpolate/interpolate.dart' as d4;

void main() {
  group('interpolateLab', () {
    var d3 = load('interpolate/lab'); // beware instanceof d3_Color
    test('parses string input', () {
      expect(d3.interpolateLab('steelblue', '#f00')(.2), same('#8a7793'));
      expect(d3.interpolateLab('steelblue', '#f00')(.6), same('#cf5952'));
    });
    test('parses d3.hsl input', () {
      expect(d3.interpolateLab(d3.hsl('steelblue'), '#f00')(.2), same('#8a7793'));
      expect(d3.interpolateLab('steelblue', d3.hsl(0, 1, .5))(.6), same('#cf5952'));
    });
    test('parses d3.rgb input', () {
      expect(d3.interpolateLab(d3.rgb('steelblue'), '#f00')(.2), same('#8a7793'));
      expect(d3.interpolateLab('steelblue', d3.rgb(255, 0, 0))(.6), same('#cf5952'));
    });
    test('interpolates in HSL color space', () {
      expect(d3.interpolateLab('steelblue', '#f00')(.2), same('#8a7793'));
    });
    test('returns an instanceof d3.lab', () {
      expect(d3.interpolateLab('steelblue', '#f00')(.2), same('#8a7793'));
    });
  });
}
