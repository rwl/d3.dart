import 'package:unittest/unittest.dart';

import '../../src/scale/scale.dart' as d4;

void main() {
  group('linear', () {
    var d3 = load('scale/linear').expression('interpolate/hsl'); // beware instanceof d3_Color
    group('domain', () {
      test('defaults to [0, 1]', () {
        var x = d3.scale.linear();
        expect(x.domain(), equals([0, 1]));
        expect(x(.5), inDelta(.5, 1e-6));
      });
      test('coerces domain values to numbers', () {
        var x = d3.scale.linear().domain([new Date(1990, 0, 1), new Date(1991, 0, 1)]);
        expect(x.domain()[0], typeof('number'));
        expect(x.domain()[1], typeof('number'));
        expect(x(new Date(1989, 09, 20)), inDelta(-.2, 1e-2));
        expect(x(new Date(1990, 00, 01)), inDelta(0, 1e-2));
        expect(x(new Date(1990, 02, 15)), inDelta(.2, 1e-2));
        expect(x(new Date(1990, 04, 27)), inDelta(.4, 1e-2));
        expect(x(new Date(1991, 00, 01)), inDelta(1, 1e-2));
        expect(x(new Date(1991, 02, 15)), inDelta(1.2, 1e-2));
        x = d3.scale.linear().domain(['0', '1']);
        expect(x.domain()[0], typeof('number'));
        expect(x.domain()[1], typeof('number'));
        expect(x(.5), inDelta(.5, 1e-6));
        x = d3.scale.linear().domain([new Number(0), new Number(1)]);
        expect(x.domain()[0], typeof('number'));
        expect(x.domain()[1], typeof('number'));
        expect(x(.5), inDelta(.5, 1e-6));
      });
      test('can specify a polylinear domain and range', () {
        var x = d3.scale.linear().domain([-10, 0, 100]).range(['red', 'white', 'green']);
        expect(x(-5), equals('#ff8080'));
        expect(x(50), equals('#80c080'));
        expect(x(75), equals('#40a040'));
      });
      test('the smaller of the domain or range is observed', () {
        var x = d3.scale.linear().domain([-10, 0]).range(['red', 'white', 'green']).clamp(true);
        expect(x(-5), equals('#ff8080'));
        expect(x(50), equals('#ffffff'));
        x = d3.scale.linear().domain([-10, 0, 100]).range(['red', 'white']).clamp(true);
        expect(x(-5), equals('#ff8080'));
        expect(x(50), equals('#ffffff'));
      });
      test('an empty domain maps to the range start', () {
        var x = d3.scale.linear().domain([0, 0]).range(['red', 'green']);
        expect(x(0), equals('#ff0000'));
        expect(x(-1), equals('#ff0000'));
        expect(x(1), equals('#ff0000'));
      });
    });

    group('range', () {
      test('defaults to [0, 1]', () {
        var x = d3.scale.linear();
        expect(x.range(), equals([0, 1]));
        expect(x.invert(.5), inDelta(.5, 1e-6));
      });
      test('does not coerce range to numbers', () {
        var x = d3.scale.linear().range(['0', '2']);
        expect(x.range()[0], typeof('string'));
        expect(x.range()[1], typeof('string'));
      });
      test('can specify range values as colors', () {
        var x = d3.scale.linear().range(['red', 'blue']);
        expect(x(.5), equals('#800080'));
        x = d3.scale.linear().range(['#ff0000', '#0000ff']);
        expect(x(.5), equals('#800080'));
        x = d3.scale.linear().range(['#f00', '#00f']);
        expect(x(.5), equals('#800080'));
        x = d3.scale.linear().range([d3.rgb(255,0,0), d3.hsl(240,1,.5)]);
        expect(x(.5), equals('#800080'));
        x = d3.scale.linear().range(['hsl(0,100%,50%)', 'hsl(240,100%,50%)']);
        expect(x(.5), equals('#800080'));
      });
      test('can specify range values as arrays or objects', () {
        var x = d3.scale.linear().range([{color: 'red'}, {color: 'blue'}]);
        expect(x(.5), equals({color: '#800080'}));
        x = d3.scale.linear().range([['red'], ['blue']]);
        expect(x(.5), equals(['#800080']));
      });
    });

    group('interpolate', () {
      test('defaults to d3.interpolate', () {
        var x = d3.scale.linear().range(['red', 'blue']);
        expect(x.interpolate(), equals(d3.interpolate));
        expect(x(.5), equals('#800080'));
      });
      test('can specify a custom interpolator', () {
        var x = d3.scale.linear().range(['red', 'blue']).interpolate(d3.interpolateHsl);
        expect(x(.5), equals('#ff00ff'));
      });
    });

    group('clamp', () {
      test('defaults to false', () {
        var x = d3.scale.linear();
        expect(x.clamp(), isFalse);
        expect(x(-.5), inDelta(-.5, 1e-6));
        expect(x(1.5), inDelta(1.5, 1e-6));
      });
      test('can clamp to the domain', () {
        var x = d3.scale.linear().clamp(true);
        expect(x(-.5), inDelta(0, 1e-6));
        expect(x(.5), inDelta(.5, 1e-6));
        expect(x(1.5), inDelta(1, 1e-6));
        x = d3.scale.linear().domain([1, 0]).clamp(true);
        expect(x(-.5), inDelta(1, 1e-6));
        expect(x(.5), inDelta(.5, 1e-6));
        expect(x(1.5), inDelta(0, 1e-6));
      });
      test('can clamp to the range', () {
        var x = d3.scale.linear().clamp(true);
        expect(x.invert(-.5), inDelta(0, 1e-6));
        expect(x.invert(.5), inDelta(.5, 1e-6));
        expect(x.invert(1.5), inDelta(1, 1e-6));
        x = d3.scale.linear().range([1, 0]).clamp(true);
        expect(x.invert(-.5), inDelta(1, 1e-6));
        expect(x.invert(.5), inDelta(.5, 1e-6));
        expect(x.invert(1.5), inDelta(0, 1e-6));
      });
    });

    test('maps a number to a number', () {
      var x = d3.scale.linear().domain([1, 2]);
      expect(x(.5), inDelta(-.5, 1e-6));
      expect(x(1), inDelta(0, 1e-6));
      expect(x(1.5), inDelta(.5, 1e-6));
      expect(x(2), inDelta(1, 1e-6));
      expect(x(2.5), inDelta(1.5, 1e-6));
    });

    group('invert', () {
      test('maps a number to a number', () {
        var x = d3.scale.linear().range([1, 2]);
        expect(x.invert(.5), inDelta(-.5, 1e-6));
        expect(x.invert(1), inDelta(0, 1e-6));
        expect(x.invert(1.5), inDelta(.5, 1e-6));
        expect(x.invert(2), inDelta(1, 1e-6));
        expect(x.invert(2.5), inDelta(1.5, 1e-6));
      });
      test('coerces range value to numbers', () {
        var x = d3.scale.linear().range(['0', '2']);
        expect(x.invert('1'), inDelta(.5, 1e-6));
        x = d3.scale.linear().range([new Date(1990, 0, 1), new Date(1991, 0, 1)]);
        expect(x.invert(new Date(1990, 6, 2, 13)), inDelta(.5, 1e-6));
        x = d3.scale.linear().range(['#000', '#fff']);
        assert.isNaN(x.invert('#999'), equals(double.NAN));
      });
      test('can invert a polylinear descending domain', () {
        var x = d3.scale.linear().domain([4, 2, 1]).range([1, 2, 4]);
        expect(x(1.5), inDelta(3, 1e-6));
        expect(x(3), inDelta(1.5, 1e-6));
        expect(x.invert(1.5), inDelta(3, 1e-6));
        expect(x.invert(3), inDelta(1.5, 1e-6));
      });
      test('can invert a polylinear descending range', () {
        var x = d3.scale.linear().domain([1, 2, 4]).range([4, 2, 1]);
        expect(x(1.5), inDelta(3, 1e-6));
        expect(x(3), inDelta(1.5, 1e-6));
        expect(x.invert(1.5), inDelta(3, 1e-6));
        expect(x.invert(3), inDelta(1.5, 1e-6));
      });
    });

    group('ticks', () {
      test('generates ticks of varying degree', () {
        var x = d3.scale.linear();
        expect(x.ticks(1).map(x.tickFormat(1)), equals([0, 1]));
        expect(x.ticks(2).map(x.tickFormat(2)), equals([0, .5, 1]));
        expect(x.ticks(5).map(x.tickFormat(5)), equals([0, .2, .4, .6, .8, 1]));
        expect(x.ticks(10).map(x.tickFormat(10)), equals([0, .1, .2, .3, .4, .5, .6, .7, .8, .9, 1]));
        var x = d3.scale.linear().domain([1, 0]);
        expect(x.ticks(1).map(x.tickFormat(1)), equals([0, 1]));
        expect(x.ticks(2).map(x.tickFormat(2)), equals([0, .5, 1]));
        expect(x.ticks(5).map(x.tickFormat(5)), equals([0, .2, .4, .6, .8, 1]));
        expect(x.ticks(10).map(x.tickFormat(10)), equals([0, .1, .2, .3, .4, .5, .6, .7, .8, .9, 1]));
      });
      test('formats ticks with the appropriate precision', () {
        var x = d3.scale.linear().domain([.123456789, 1.23456789]);
        expect(x.tickFormat(1)(x.ticks(1)[0]), equals('1'));
        expect(x.tickFormat(2)(x.ticks(2)[0]), equals('0.5'));
        expect(x.tickFormat(4)(x.ticks(4)[0]), equals('0.2'));
        expect(x.tickFormat(8)(x.ticks(8)[0]), equals('0.2'));
        expect(x.tickFormat(16)(x.ticks(16)[0]), equals('0.2'));
        expect(x.tickFormat(32)(x.ticks(32)[0]), equals('0.15'));
        expect(x.tickFormat(64)(x.ticks(64)[0]), equals('0.14'));
        expect(x.tickFormat(128)(x.ticks(128)[0]), equals('0.13'));
        expect(x.tickFormat(256)(x.ticks(256)[0]), equals('0.125'));
      });
    });

    group('tickFormat', () {
      test('applies automatic precision when not explicitly specified', () {
        var x = d3.scale.linear();
        expect(x.tickFormat(10, 'f')(Math.PI), equals('3.1'));
        expect(x.tickFormat(100, 'f')(Math.PI), equals('3.14'));
        expect(x.tickFormat(100, '$f')(Math.PI), equals('$3.14'));
        expect(x.domain([0, 100]).tickFormat(100, '%')(Math.PI), equals('314%'));
      });
      test('if count is not specified, defaults to 10', () {
        var x = d3.scale.linear();
        expect(x.tickFormat()(Math.PI), equals('3.1'));
        expect(x.tickFormat(1)(Math.PI), equals('3'));
        expect(x.tickFormat(10)(Math.PI), equals('3.1'));
        expect(x.tickFormat(100)(Math.PI), equals('3.14'));
      });
    });

    group('nice', () {
      test('nices the domain, extending it to round numbers', () {
        var x = d3.scale.linear().domain([1.1, 10.9]).nice();
        expect(x.domain(), equals([1, 11]));
        x = d3.scale.linear().domain([10.9, 1.1]).nice();
        expect(x.domain(), equals([11, 1]));
        x = d3.scale.linear().domain([.7, 11.001]).nice();
        expect(x.domain(), equals([0, 12]));
        x = d3.scale.linear().domain([123.1, 6.7]).nice();
        expect(x.domain(), equals([130, 0]));
        x = d3.scale.linear().domain([0, .49]).nice();
        expect(x.domain(), equals([0, .5]));
      });
      test('has no effect on degenerate domains', () {
        var x = d3.scale.linear().domain([0, 0]).nice();
        expect(x.domain(), equals([0, 0]));
        x = d3.scale.linear().domain([.5, .5]).nice();
        expect(x.domain(), equals([.5, .5]));
      });
      test('nicing a polylinear domain only affects the extent', () {
        var x = d3.scale.linear().domain([1.1, 1, 2, 3, 10.9]).nice();
        expect(x.domain(), equals([1, 1, 2, 3, 11]));
        x = d3.scale.linear().domain([123.1, 1, 2, 3, -.9]).nice();
        expect(x.domain(), equals([130, 1, 2, 3, -10]));
      });
      test('accepts a tick count to control nicing step', () {
        var x = d3.scale.linear().domain([12, 87]).nice(5);
        expect(x.domain(), equals([0, 100]));
        x = d3.scale.linear().domain([12, 87]).nice(10);
        expect(x.domain(), equals([10, 90]));
        x = d3.scale.linear().domain([12, 87]).nice(100);
        expect(x.domain(), equals([12, 87]));
      });
    });

    group('copy', () {
      test('changes to the domain are isolated', () {
        var x = d3.scale.linear(), y = x.copy();
        x.domain([1, 2]);
        expect(y.domain(), equals([0, 1]));
        expect(x(1), equals(0));
        expect(y(1), equals(1));
        y.domain([2, 3]);
        expect(x(2), equals(1));
        expect(y(2), equals(0));
        expect(x.domain(), equals([1, 2]));
        expect(y.domain(), equals([2, 3]));
      });
      test('changes to the range are isolated', () {
        var x = d3.scale.linear(), y = x.copy();
        x.range([1, 2]);
        expect(x.invert(1), equals(0));
        expect(y.invert(1), equals(1));
        expect(y.range(), equals([0, 1]));
        y.range([2, 3]);
        expect(x.invert(2), equals(1));
        expect(y.invert(2), equals(0));
        expect(x.range(), equals([1, 2]));
        expect(y.range(), equals([2, 3]));
      });
      test('changes to the interpolator are isolated', () {
        var x = d3.scale.linear().range(['red', 'blue']), y = x.copy();
        x.interpolate(d3.interpolateHsl);
        expect(x(0.5), equals('#ff00ff'));
        expect(y(0.5), equals('#800080'));
        expect(y.interpolate(), equals(d3.interpolate));
      });
      test('changes to clamping are isolated', () {
        var x = d3.scale.linear().clamp(true), y = x.copy();
        x.clamp(false);
        expect(x(2), equals(2));
        expect(y(2), equals(1));
        expect(y.clamp(), isTrue);
        y.clamp(false);
        expect(x(2), equals(2));
        expect(y(2), equals(2));
        expect(x.clamp(), isFalse);
      });
    });
  });
}
