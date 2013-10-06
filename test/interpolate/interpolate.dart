import 'package:unittest/unittest.dart';

import '../../src/interpolate/interpolate.dart' as d4;

void main() {
  group('interpolate', () {
    var d3 = load('interpolate/interpolate');
    group('when b is a number', () {
      test('interpolates numbers', () {
        expect(d3.interpolate(2, 12)(.4), same(6));
      });
      test('coerces a to a number', () {
        expect(d3.interpolate('', 1)(.5), same(.5));
        expect(d3.interpolate('2', 12)(.4), same(6));
        expect(d3.interpolate([2], 12)(.4), same(6));
      });
    });

    group('when b is a color string', () {
      test('interpolates RGB values and returns a hexadecimal string', () {
        expect(d3.interpolate('#ff0000', '#008000')(.4), same('#993300'));
      });
      test('interpolates named colors in RGB', () {
        expect(d3.interpolate('red', 'green')(.4), same('#993300'));
      });
      test('interpolates decimal RGB colors in RGB', () {
        expect(d3.interpolate('rgb(255,0,0)', 'rgb(0,128,0)')(.4), same('#993300'));
      });
      test('interpolates decimal HSL colors in RGB', () {
        expect(d3.interpolate('hsl(0,100%,50%)', 'hsl(120,100%,25%)')(.4), same('#993300'));
      });
      test('coerces a to a color', () {
        expect(d3.interpolate({toString: () { return 'red'; }}, 'green')(.4), same('#993300'));
      });
    });

    group('when b is a color object', () {
      test('interpolates RGB values and returns a hexadecimal string', () {
        expect(d3.interpolate(d3.rgb(255, 0, 0), d3.rgb(0, 128, 0))(.4), same('#993300'));
      });
      test('interpolates d3.hsl in RGB', () {
        expect(d3.interpolate(d3.hsl('red'), d3.hsl('green'))(.4), same('#993300'));
      });
      test('interpolates d3.lab in RGB', () {
        expect(d3.interpolate(d3.lab('red'), d3.lab('green'))(.4), same('#993300'));
      });
      test('interpolates d3.hcl in RGB', () {
        expect(d3.interpolate(d3.hcl('red'), d3.hcl('green'))(.4), same('#993300'));
      });
      test('coerces a to a color', () {
        expect(d3.interpolate({toString: () { return 'red'; }}, 'green')(.4), same('#993300'));
      });
    });

    group('when b is a string', () {
      test('interpolates matching numbers in both strings', () {
        expect(d3.interpolate(' 10/20 30', '50/10 100 ')(.4), same('26/16 58 '));
      });
      test('if b is coercible to a number, still returns a string', () {
        expect(d3.interpolate('1.', '2.')(.5), same('1.5'));
        expect(d3.interpolate('1e+3', '1e+4')(.5), same('5500'));
      });
      test('preserves non-numbers in string b', () {
        expect(d3.interpolate(' 10/20 30', '50/10 foo ')(.4), same('26/16 foo '));
      });
      test('preserves non-matching numbers in string b', () {
        expect(d3.interpolate(' 10/20 bar', '50/10 100 ')(.4), same('26/16 100 '));
      });
      test('preserves equal-value numbers in both strings', () {
        expect(d3.interpolate(' 10/20 100 20', '50/10 100, 20 ')(.4), same('26/16 100, 20 '));
      });
      test('coerces a to a string', () {
        expect(d3.interpolate({toString: () { return '1.'; }}, '2.')(.5), same('1.5'));
      });
    });

    group('when b is an array', () {
      test('interpolates each element in b', () {
        expect(JSON.stringify(d3.interpolate([2, 4], [12, 24])(.4)), same('[6,12]'));
      });
      test('interpolates arrays, even when both a and b are coercible to numbers', () {
        expect(JSON.stringify(d3.interpolate([2], [12])(.4)), same('[6]'));
        expect(JSON.stringify(d3.interpolate([[2]], [[12]])(.4)), same('[[6]]'));
      });
      test('reuses the returned array during interpolation', () {
        var i = d3.interpolate([2], [12]);
        expect(i(.2), same(i(.4)));
      });
    });

    group('when b is an object', () {
      test('interpolates each property in b', () {
        expect(d3.interpolate({foo: 2, bar: 4}, {foo: 12, bar: 24})(.4), equals({foo: 6, bar: 12}));
      });
      test('interpolates arrays, even when both a and b are coercible to numbers', () {
        var two = new Number(2), twelve = new Number(12);
        two.foo = '2px';
        twelve.foo = '12px';
        expect(d3.interpolate(two, twelve)(.4), equals({foo: '6px'}));
      });
      test('reuses the returned object during interpolation', () {
        var i = d3.interpolate({foo: 2, bar: 4}, {foo: 12, bar: 24});
        expect(i(.2), same(i(.4)));
      });
    });

    test('may or may not interpolate between enumerable and non-enumerable properties', () {
      var a = Object.create({}, {foo: {value: 1, enumerable: true}}),
          b = Object.create({}, {foo: {value: 2, enumerable: false}});
      try {
        expect(d3.interpolate(a, b)(1), equals({}));
      } catch (e) {
        expect(d3.interpolate(a, b)(1), equals({foo: 2}));
      }
      try {
        expect(d3.interpolate(b, a)(1), equals({}));
      } catch (e) {
        expect(d3.interpolate(b, a)(1), equals({foo: 1}));
      }
    });
    test('interpolates inherited properties of objects', () {
      var a = Object.create({foo: 0}),
          b = Object.create({foo: 2});
      expect(d3.interpolate(a, b)(.5), equals({foo: 1}));
    });
    test('doesn\'t interpret properties in the default object\'s prototype chain as RGB', () {
      expect(d3.interpolate('hasOwnProperty', 'hasOwnProperty')(0), equals('hasOwnProperty'));
    });
  });

  group('interpolators', () {
    var d3 = load('interpolate/interpolate').document();
    test('can register a custom interpolator', () {
      d3.interpolators.push((a, b) {
        return a == 'one' && b == 'two' && d3.interpolateNumber(1, 2);
      });
      try {
        expect(d3.interpolate('one', 'two')(-.5), equals(.5));
        expect(d3.interpolate('one', 'two')(0), equals(1));
        expect(d3.interpolate('one', 'two')(.5), equals(1.5));
        expect(d3.interpolate('one', 'two')(1), equals(2));
        expect(d3.interpolate('one', 'two')(1.5), equals(2.5));
      } finally {
        d3.interpolators.pop();
      }
    });
  });
}
