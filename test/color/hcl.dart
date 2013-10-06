import 'package:unittest/unittest.dart';

import '../assert.dart';
import '../../src/color/color.dart' as d4;

void main() {
  group('hcl', () {
    var hcl = load('color/hcl').expression('d3.hcl');
    test('converts string channel values to numbers', () {
      expect(hcl('50', '-4', '32'), hclEquals(50, -4, 32));
    });
    test('converts null channel values to zero', () {
      expect(hcl(null, null, null), hclEquals(0, 0, 0));
    });
    test('exposes h, c and l properties', () {
      var color = hcl(50, -4, 32);
      expect(color.h, equals(50));
      expect(color.c, equals(-4));
      expect(color.l, equals(32));
    });
    test('changing h, c or l affects the string format', () {
      var color = hcl(50, -4, 32);
      expect(color + '', equals('#444d50'));
      color.h++;
      expect(color + '', equals('#444d50'));
      color.c++;
      expect(color + '', equals('#464c4f'));
      color.l++;
      expect(color + '', equals('#494f51'));
    });
    test('parses hexadecimal shorthand format (e.g., \'#abc\')', () {
      expect(hcl('#abc'), hclEquals(-102.28223831811077, 10.774886733325554, 75.10497524893663));
    });
    test('parses hexadecimal format (e.g., \'#abcdef\')', () {
      expect(hcl('#abcdef'), hclEquals(-100.15785184209284, 20.768234621934273, 81.04386565274363));
    });
    test('parses HSL format (e.g., \'hsl(210, 64%, 13%)\')', () {
      expect(hcl('hsl(210, 64.7058%, 13.33333%)'), hclEquals(-89.58282792342067, 16.833655998102003, 12.65624852526134));
    });
    test('parses color names (e.g., \'moccasin\')', () {
      expect(hcl('moccasin'), hclEquals(84.71288921124494, 26.472460854104156, 91.72317744746022));
    });
    test('parses and converts RGB format (e.g., \'rgb(102, 102, 0)\')', () {
      expect(hcl('rgb(102, 102, 0)'), hclEquals(102.85124420310271, 49.44871600399321, 41.73251953866431));
    });
    test('can convert from RGB', () {
      expect(hcl(_.rgb(12, 34, 56)), hclEquals(-89.58282792342067, 16.833655998102003, 12.65624852526134));
    });
    test('can convert from HSL', () {
      expect(hcl(hcl(20, .8, .3)), hclEquals(20, 0.8, 0.3));
    });
    test('can convert to RGB', () {
      expect(hcl('steelblue').rgb(), rgbEquals(70, 130, 180));
    });
    test('can derive a brighter color', () {
      expect(hcl('steelblue').brighter(), hclEquals(-97.21873224090723, 32.44906314974561, 70.46551718768575));
      expect(hcl('steelblue').brighter(.5), hclEquals(-97.21873224090723, 32.44906314974561, 61.46551718768575));
    });
    test('can derive a darker color', () {
      expect(hcl('lightsteelblue').darker(), hclEquals(-94.8160116310511, 15.26488988314746, 60.45157936968134));
      expect(hcl('lightsteelblue').darker(.5), hclEquals(-94.8160116310511, 15.26488988314746, 69.45157936968134));
    });
    test('string coercion returns RGB format', () {
      expect(hcl('hsl(60, 100%, 20%)') + '', same('#666600'));
      expect(hcl(hcl(60, -4, 32)) + '', same('#454c51'));
    });
    test('roundtrip to HSL is idempotent', () {
      expect(_.hsl(hcl('steelblue')), equals(_.hsl('steelblue')));
    });
    test('roundtrip to RGB is idempotent', () {
      expect(_.rgb(hcl('steelblue')), equals(_.rgb('steelblue')));
    });
    test('roundtrip to Lab is idempotent', () {
      expect(_.lab(hcl('steelblue')), equals(_.lab('steelblue')));
    });
    test('h is defined for non-black grayscale colors (because of the color profile)', () {
      expect(hcl('#ccc').h, inDelta(158.1986, 1e-3));
      expect(hcl('gray').h, inDelta(158.1986, 1e-3));
      expect(hcl(_.rgb('gray')).h, inDelta(158.1986, 1e-3));
      expect(hcl('#fff').h, inDelta(158.1986, 1e-3));
      expect(hcl('white').h, inDelta(158.1986, 1e-3));
      expect(hcl(_.rgb('white')).h, inDelta(158.1986, 1e-3));
    });
    test('h is preserved when explicitly specified, even for black', () {
      expect(hcl(0, 0, 0).h, same(0));
      expect(hcl(42, 0, 0).h, same(42));
      expect(hcl(118, 0, 0).h, same(118));
    });
    test('h is undefined when not explicitly specified for black', () {
      expect(hcl('#000').h, isNaN);
      expect(hcl('black').h, isNaN);
      expect(hcl(_.rgb('black')).h, isNaN);
    });
    test('c is preserved when explicitly specified, even for black', () {
      expect(hcl(0, 0, 0).c, same(0));
      expect(hcl(0, .42, 0).c, same(.42));
      expect(hcl(0, 1, 0).c, same(1));
    });
    test('c is undefined when not explicitly specified for black', () {
      expect(hcl('#000').c, isNaN);
      expect(hcl('black').c, isNaN);
      expect(hcl(_.rgb('black')).c, isNaN);
    });
    test('can convert black (with undefined hue and chroma) to RGB', () {
      expect(hcl(NaN, NaN, 0) + '', same('#000000'));
    });
  });
}
