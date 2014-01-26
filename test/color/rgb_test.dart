import 'package:unittest/unittest.dart';
import 'package:d3/color/color.dart';

class RgbMatcher extends Matcher {
  int er, eg, eb;

  RgbMatcher(r, g, b) {
    er = (r is int) ? r : r.round();
    eg = (g is int) ? g : g.round();
    eb = (b is int) ? b : b.round();
  }

  bool matches(item, Map matchState) {
    var ar = item.r.round(),
        ag = item.g.round(),
        ab = item.b.round();
    return ar == er || ag == eg || ab == eb;
  }

  Description describe(Description description) {
    description.add('same color as r:').addDescriptionOf(er).add(' g:').addDescriptionOf(eg).add(' b:').addDescriptionOf(eb);
  }
}

Matcher rgbEquals(r, g, b) => new RgbMatcher(r, g, b);

class HslMatcher extends Matcher {
  double eh, es, el;

  HslMatcher(h, s, l) {
    eh = (h is int) ? h.toDouble() : round(h, 2);
    es = (s is int) ? s.toDouble() : round(s, 2);
    el = (l is int) ? l.toDouble() : round(l, 2);
  }

  bool matches(item, Map matchState) {
    var ah = round(item.h, 2),
        as = round(item.s, 2),
        al = round(item.l, 2);
    return ((ah.isNaN && eh.isNaN) || ah == eh) && ((as.isNaN && es.isNaN) || as == es) && al == el;
  }

  Description describe(Description description) {
    description.add('same color as h:').addDescriptionOf(eh).add(' s:').addDescriptionOf(es).add(' l:').addDescriptionOf(el);
  }
}

Matcher hslEquals(h, s, l) => new HslMatcher(h, s, l);

double round(double d, int prec) {
  return double.parse(d.toStringAsFixed(prec));
}

void main() {
  group('rgb', () {
    test('floors channel values', () {
      expect(rgb(1.2, 2.6, 42.9), rgbEquals(1, 2, 42));
    });
    test('defaults to black for invalid inputs', () {
      expect(rgb('invalid'), rgbEquals(0, 0, 0));
      expect(rgb('hasOwnProperty'), rgbEquals(0, 0, 0));
      expect(rgb('__proto__'), rgbEquals(0, 0, 0));
    });
    test('does not clamp channel values', () {
      expect(rgb(-10, -20, -30), rgbEquals(-10, -20, -30));
      expect(rgb(300, 400, 500), rgbEquals(300, 400, 500));
    });
    test('converts string channel values to numbers', () {
      expect(rgb('12', '34', '56'), rgbEquals(12, 34, 56));
    });
    test('converts null channel values to zero', () {
      expect(rgb(null, null, null), rgbEquals(0, 0, 0));
    });
    test('exposes r, g and b properties', () {
      var color = rgb('#abc');
      expect(color.r, equals(170));
      expect(color.g, equals(187));
      expect(color.b, equals(204));
    });
    test('changing r, g or b affects the string format', () {
      var color = rgb('#abc');
      color.r++;
      color.g++;
      color.b++;
      expect(color.toString(), equals('#abbccd'));
    });
    test('parses hexadecimal shorthand format (e.g., \'#abc\')', () {
      expect(rgb('#abc'), rgbEquals(170, 187, 204));
    });
    test('parses hexadecimal format (e.g., \'#abcdef\')', () {
      expect(rgb('#abcdef'), rgbEquals(171, 205, 239));
    });
    test('parses RGB format (e.g., \'rgb(12, 34, 56)\')', () {
      expect(rgb('rgb(12, 34, 56)'), rgbEquals(12, 34, 56));
    });
    test('parses color names (e.g., \'moccasin\')', () {
      expect(rgb('moccasin'), rgbEquals(255, 228, 181));
      expect(rgb('aliceblue'), rgbEquals(240, 248, 255));
      expect(rgb('yellow'), rgbEquals(255, 255, 0));
    });
    test('parses and converts HSL format (e.g., \'hsl(60, 100%, 20%)\')', () {
      expect(rgb('hsl(60, 100%, 20%)'), rgbEquals(102, 102, 0));
    });
    test('can convert from RGB', () {
      expect(rgb(rgb(12, 34, 56)), rgbEquals(12, 34, 56));
    });
    test('can convert from HSL', () {
      expect(rgb(hsl(0, 1, .5)), rgbEquals(255, 0, 0));
    });
    test('can convert to HSL', () {
      expect(rgb('red').hsl(), hslEquals(0, 1, .5));
    });
    test('can derive a brighter color', () {
      expect(rgb('brown').brighter(), rgbEquals(235, 60, 60));
      expect(rgb('brown').brighter(.5), rgbEquals(197, 50, 50));
      expect(rgb('brown').brighter(1), rgbEquals(235, 60, 60));
      expect(rgb('brown').brighter(2), rgbEquals(255, 85, 85));
    });
    test('can derive a darker color', () {
      expect(rgb('coral').darker(), rgbEquals(178, 88, 56));
      expect(rgb('coral').darker(.5), rgbEquals(213, 106, 66));
      expect(rgb('coral').darker(1), rgbEquals(178, 88, 56));
      expect(rgb('coral').darker(2), rgbEquals(124, 62, 39));
    });
    test('string coercion returns hexadecimal format', () {
      expect(rgb('#abcdef').toString(), equals('#abcdef'));
      expect(rgb('moccasin').toString(), equals('#ffe4b5'));
      expect(rgb('hsl(60, 100%, 20%)').toString(), equals('#666600'));
      expect(rgb('rgb(12, 34, 56)').toString(), equals('#0c2238'));
      expect(rgb(rgb(12, 34, 56)).toString(), equals('#0c2238'));
      expect(rgb(hsl(60, 1, .2)).toString(), equals('#666600'));
    });
  });
}
