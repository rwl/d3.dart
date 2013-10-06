import 'package:unittest/unittest.dart';

import '../assert.dart';
import '../../src/color/color.dart' as d4;

void main() {
  group('hsl', () {
    var hsl = load('color/hsl').expression('d3.hsl');
    test('does not clamp channel values', () {
      expect(hsl(-100, -1, -2), hslEquals(-100, -1, -2));
      expect(hsl(400, 2, 3), hslEquals(400, 2, 3));
    });
    test('converts string channel values to numbers', () {
      expect(hsl('180', '.5', '.6'), hslEquals(180, .5, .6));
    });
    test('converts null channel values to zero', () {
      expect(hsl(null, null, null), hslEquals(0, 0, 0));
    });
    test('exposes h, s and l properties', () {
      expect(hsl('hsl(180, 50%, 60%)'), hslEquals(180, .5, .6));
    });
    test('changing h, s or l affects the string format', () {
      var color = hsl('hsl(180, 50%, 60%)');
      color.h++;
      color.s += .1;
      color.l += .1;
      assert.equal(color + '', equals('#85dfe0'));
    });
    test('parses hexadecimal shorthand format (e.g., \'#abc\')', () {
      expect(hsl('#abc'), hslEquals(210, .25, .733333));
    });
    test('parses hexadecimal format (e.g., \'#abcdef\')', () {
      expect(hsl('#abcdef'), hslEquals(210, .68, .803922));
    });
    test('parses HSL format (e.g., \'hsl(210, 64%, 13%)\')', () {
      expect(hsl('hsl(210, 64.7058%, 13.33333%)'), hslEquals(210, .647058, .133333));
    });
    test('parses color names (e.g., \'moccasin\')', () {
      expect(hsl('moccasin'), hslEquals(38.108108, 1, .854902));
      expect(hsl('aliceblue'), hslEquals(208, 1, .970588));
      expect(hsl('yellow'), hslEquals(60, 1, .5));
    });
    test('parses and converts RGB format (e.g., \'rgb(102, 102, 0)\')', () {
      expect(hsl('rgb(102, 102, 0)'), hslEquals(60, 1, .2));
    });
    test('can convert from RGB', () {
      expect(hsl(_.rgb(12, 34, 56)), hslEquals(210, .647058, .133333));
    });
    test('can convert from HSL', () {
      expect(hsl(hsl(20, .8, .3)), hslEquals(20, .8, .3));
    });
    test('can convert to RGB', () {
      expect(hsl('steelblue').rgb(), rgbEquals(70, 130, 180));
    });
    test('can derive a brighter color', () {
      expect(hsl('steelblue').brighter(), hslEquals(207.272727, .44, .7002801));
      expect(hsl('steelblue').brighter(.5), hslEquals(207.272727, .44, .5858964));
      expect(hsl('steelblue').brighter(1), hslEquals(207.272727, .44, .7002801));
      expect(hsl('steelblue').brighter(2), hslEquals(207.272727, .44, 1.0004002));
    });
    test('can derive a darker color', () {
      expect(hsl('lightsteelblue').darker(), hslEquals(213.913043, .4107143, .5462745));
      expect(hsl('lightsteelblue').darker(.5), hslEquals(213.913043, .4107143, .6529229));
      expect(hsl('lightsteelblue').darker(1), hslEquals(213.913043, .4107143, .5462745));
      expect(hsl('lightsteelblue').darker(2), hslEquals(213.913043, .4107143, .38239216));
    });
    test('string coercion returns RGB format', () {
      expect(hsl('hsl(60, 100%, 20%)') + '', same('#666600'));
      expect(hsl(hsl(60, 1, .2)) + '', same('#666600'));
    });
    test('h is preserved when explicitly specified, even for grayscale colors', () {
      expect(hsl(0, 0, 0), hslEquals(0, 0, 0));
      expect(hsl(42, 0, .5), hslEquals(42, 0, .5));
      expect(hsl(118, 0, 1), hslEquals(118, 0, 1));
    });
    test('h is undefined when not explicitly specified for grayscale colors', () {
      expect(hsl('#000'), hslEquals(NaN, NaN, 0));
      expect(hsl('black'), hslEquals(NaN, NaN, 0));
      expect(hsl(_.rgb('black')), hslEquals(NaN, NaN, 0));
      expect(hsl('#ccc'), hslEquals(NaN, 0, .8));
      expect(hsl('gray'), hslEquals(NaN, 0, .5));
      expect(hsl(_.rgb('gray')), hslEquals(NaN, 0, .5));
      expect(hsl('#fff'), hslEquals(NaN, NaN, 1));
      expect(hsl('white'), hslEquals(NaN, NaN, 1));
      expect(hsl(_.rgb('white')), hslEquals(NaN, NaN, 1));
    });
    test('s is preserved when explicitly specified, even for white or black', () {
      expect(hsl(0, 0, 0), hslEquals(0, 0, 0));
      expect(hsl(0, .18, 0), hslEquals(0, .18, 0));
      expect(hsl(0, .42, 1), hslEquals(0, .42, 1));
      expect(hsl(0, 1, 1), hslEquals(0, 1, 1));
    });
    test('s is zero for grayscale colors (but not white and black)', () {
      expect(hsl('#ccc'), hslEquals(NaN, 0, .8));
      expect(hsl('#777'), hslEquals(NaN, 0, .47));
    });
    test('s is undefined when not explicitly specified for white or black', () {
      expect(hsl('#000'), hslEquals(NaN, NaN, 0));
      expect(hsl('black'), hslEquals(NaN, NaN, 0));
      expect(hsl(_.rgb('black')), hslEquals(NaN, NaN, 0));
      expect(hsl('#fff'), hslEquals(NaN, NaN, 1));
      expect(hsl('white'), hslEquals(NaN, NaN, 1));
      expect(hsl(_.rgb('white')), hslEquals(NaN, NaN, 1));
    });
    test('can convert grayscale colors (with undefined hue) to RGB', () {
      expect(hsl(NaN, 0, .2) + '', same('#333333'));
      expect(hsl(NaN, 0, .6) + '', same('#999999'));
    });
    test('can convert white and black (with undefined hue and saturation) to RGB', () {
      expect(hsl(NaN, NaN, 0) + '', same('#000000'));
      expect(hsl(NaN, NaN, 1) + '', same('#ffffff'));
    });
  });
}