import 'package:unittest/unittest.dart';

import '../../src/interpolate/interpolate.dart' as d4;

void main() {
  group('ease', () {
    var ease = load('interpolate/ease').expression('d3.ease');
    test('supports linear easing', () {
      var e = ease('linear');
      expect(e(.5), inDelta(.5, 1e-6));
    });
    test('supports polynomial easing', () {
      var e = ease('poly', 2);
      expect(e(.5), inDelta(.25, 1e-6));
    });
    test('supports quadratic easing', () {
      var e = ease('quad');
      expect(e(.5), inDelta(.25, 1e-6));
    });
    test('supports cubic easing', () {
      var e = ease('cubic');
      expect(e(.5), inDelta(.125, 1e-6));
    });
    test('supports sinusoidal easing', () {
      var e = ease('sin');
      expect(e(.5), inDelta(1 - Math.cos(Math.PI / 4), 1e-6));
    });
    test('supports exponential easing', () {
      var e = ease('exp');
      expect(e(.5), inDelta(0.03125, 1e-6));
    });
    test('supports circular easing', () {
      var e = ease('circle');
      expect(e(.5), inDelta(0.133975, 1e-6));
    });
    test('supports elastic easing', () {
      var e = ease('elastic');
      expect(e(.5), inDelta(0.976061, 1e-6));
    });
    test('supports back easing', () {
      var e = ease('back');
      expect(e(.5), inDelta(-0.0876975, 1e-6));
    });
    test('supports bounce easing', () {
      var e = ease('bounce');
      expect(e(.5), inDelta(0.765625, 1e-6));
    });
    test('invalid eases and modes default to linear-in', () {
      var e = ease('__proto__-__proto__');
      expect(e(0), same(0));
      expect(e(.5), same(.5));
      expect(e(1), same(1));
      var e = ease('hasOwnProperty-constructor');
      expect(e(0), same(0));
      expect(e(.5), same(.5));
      expect(e(1), same(1));
    });
    test('all easing functions return exactly 0 for t = 0', () {
      expect(ease('linear')(0), same(0));
      expect(ease('poly', 2)(0), same(0));
      expect(ease('quad')(0), same(0));
      expect(ease('cubic')(0), same(0));
      expect(ease('sin')(0), same(0));
      expect(ease('exp')(0), same(0));
      expect(ease('circle')(0), same(0));
      expect(ease('elastic')(0), same(0));
      expect(ease('back')(0), same(0));
      expect(ease('bounce')(0), same(0));
    });
    test('all easing functions return exactly 1 for t = 1', () {
      expect(ease('linear')(1), same(1));
      expect(ease('poly', 2)(1), same(1));
      expect(ease('quad')(1), same(1));
      expect(ease('cubic')(1), same(1));
      expect(ease('sin')(1), same(1));
      expect(ease('exp')(1), same(1));
      expect(ease('circle')(1), same(1));
      expect(ease('elastic')(1), same(1));
      expect(ease('back')(1), same(1));
      expect(ease('bounce')(1), same(1));
    });
    test('the -in suffix returns the identity', () {
      expect(ease('linear-in')(.25), inDelta(ease('linear')(.25), 1e-6));
      expect(ease('quad-in')(.75), inDelta(ease('quad')(.75), 1e-6));
    });
    test('the -out suffix returns the reverse', () {
      expect(ease('sin-out')(.25), inDelta(1 - ease('sin-in')(.75), 1e-6));
      expect(ease('bounce-out')(.25), inDelta(1 - ease('bounce-in')(.75), 1e-6));
      expect(ease('elastic-out')(.25), inDelta(1 - ease('elastic-in')(.75), 1e-6));
    });
    test('the -in-out suffix returns the reflection', () {
      expect(ease('sin-in-out')(.25), inDelta(.5 * ease('sin-in')(.5), 1e-6));
      expect(ease('bounce-in-out')(.25), inDelta(.5 * ease('bounce-in')(.5), 1e-6));
      expect(ease('elastic-in-out')(.25), inDelta(.5 * ease('elastic-in')(.5), 1e-6));
    });
    test('the -out-in suffix returns the reverse reflection', () {
      expect(ease('sin-out-in')(.25), inDelta(.5 * ease('sin-out')(.5), 1e-6));
      expect(ease('bounce-out-in')(.25), inDelta(.5 * ease('bounce-out')(.5), 1e-6));
      expect(ease('elastic-out-in')(.25), inDelta(.5 * ease('elastic-out')(.5), 1e-6));
    });
    test('clamps input time', () {
      var e = ease('linear');
      expect(e(-1), inDelta(0, 1e-6));
      expect(e(2), inDelta(1, 1e-6));
    });
    group('poly', () {
      test('supports an optional polynomial', () {
        var e = ease('poly', 1);
        expect(e(.5), inDelta(.5, 1e-6));
        var e = ease('poly', .5);
        expect(e(.5), inDelta(Math.SQRT1_2, 1e-6));
      }
    });
    group('elastic', () {
      test('supports an optional amplifier (>1)', () {
        var e = ease('elastic', 1.5);
        expect(e(.5), inDelta(0.998519, 1e-6));
      });
      test('supports an optional amplifier (>1) and period (>0)', () {
        var e = ease('elastic', 1.5, .5);
        expect(e(.5), inDelta(0.96875, 1e-6));
      }
    });
    group('back', () {
      test('supports an optional speed', () {
        var e = ease('back', 2);
        expect(e(.5), inDelta(-0.125, 1e-6));
      }
    }
  }
});
  