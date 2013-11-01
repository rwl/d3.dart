import 'package:unittest/unittest.dart';

import '../../src/scale/scale.dart' as d4;

void main() {
  group('pow', () {
    var d3 = load('scale/pow').expression('interpolate/hsl');
    group('domain', () {
      test('defaults to [0, 1]', () {
        var x = d3.scale.pow();
        expect(x.domain(), equals([0, 1]));
        expect(x(.5), .5, 1e-6);
      });
      test('coerces domain to numbers', () {
        var x = d3.scale.pow().domain([new Date(1990, 0, 1), new Date(1991, 0, 1)]);
        expect(x.domain()[0], typeof('number'));
        expect(x.domain()[1], typeof('number'));
        expect(x(new Date(1989, 09, 20)), inDelta(-.2, 1e-2));
        expect(x(new Date(1990, 00, 01)), inDelta(0, 1e-2));
        expect(x(new Date(1990, 02, 15)), inDelta(.2, 1e-2));
        expect(x(new Date(1990, 04, 27)), inDelta(.4, 1e-2));
        expect(x(new Date(1991, 00, 01)), inDelta(1, 1e-2));
        expect(x(new Date(1991, 02, 15)), inDelta(1.2, 1e-2));
        var x = d3.scale.pow().domain(['0', '1']);
        expect(x.domain()[0], typeof('number'));
        expect(x.domain()[1], typeof('number'));
        expect(x(.5), inDelta(.5, 1e-6));
        x = d3.scale.pow().domain([new Number(0), new Number(1)]);
        expect(x.domain()[0], typeof('number'));
        expect(x.domain()[1], typeof('number'));
        expect(x(.5), inDelta(.5, 1e-6));
      });
      test('can specify a polypower domain and range', () {
        var x = d3.scale.pow().domain([-10, 0, 100]).range(['red', 'white', 'green']);
        expect(x(-5), equals('#ff8080'));
        expect(x(50), equals('#80c080'));
        expect(x(75), equals('#40a040'));
      });
    });

    group('range', () {
      test('defaults to [0, 1]', () {
        var x = d3.scale.pow();
        expect(x.range(), equals([0, 1]));
        expect(x.invert(.5), inDelta(.5, 1e-6));
      });
      test('does not coerce range values to numbers', () {
        var x = d3.scale.pow().range(['0', '2']);
        expect(x.range()[0], typeof('string'));
        expect(x.range()[1], typeof('string'));
      });
      test('coerces range values to number on invert', () {
        var x = d3.scale.pow().range(['0', '2']);
        expect(x.invert('1'), inDelta(.5, 1e-6));
        x = d3.scale.pow().range([new Date(1990, 0, 1), new Date(1991, 0, 1)]);
        expect(x.invert(new Date(1990, 6, 2, 13)), inDelta(.5, 1e-6));
        x = d3.scale.pow().range(['#000', '#fff']);
        assert.isNaN(x.invert('#999'));
      });
      test('can specify range values as colors', () {
        var x = d3.scale.pow().range(['red', 'blue']);
        expect(x(.5), equals('#800080'));
        x = d3.scale.pow().range(['#ff0000', '#0000ff']);
        expect(x(.5), equals('#800080'));
        x = d3.scale.pow().range(['#f00', '#00f']);
        expect(x(.5), equals('#800080'));
        x = d3.scale.pow().range([d3.rgb(255,0,0), d3.hsl(240,1,.5)]);
        expect(x(.5), equals('#800080'));
        x = d3.scale.pow().range(['hsl(0,100%,50%)', 'hsl(240,100%,50%)']);
        expect(x(.5), equals('#800080'));
      });
      test('can specify range values as arrays or objects', () {
        var x = d3.scale.pow().range([{color: 'red'}, {color: 'blue'}]);
        expect(x(.5), equals({color: '#800080'}));
        x = d3.scale.pow().range([['red'], ['blue']]);
        expect(x(.5), equals(['#800080']));
      });
    });

    group('exponent', () {
      test('defaults to one', () {
        var x = d3.scale.pow();
        expect(x.exponent(), equals(1));
      });
      test('observes the specified exponent', () {
        var x = d3.scale.pow().exponent(.5).domain([1, 2]);
        expect(x(1), inDelta(0, 1e-6));
        expect(x(1.5), inDelta(0.5425821, 1e-6));
        expect(x(2), inDelta(1, 1e-6));
        expect(x.exponent(), equals(.5));
        x = d3.scale.pow().exponent(2).domain([1, 2]);
        expect(x(1), inDelta(0, 1e-6));
        expect(x(1.5), inDelta(.41666667, 1e-6));
        expect(x(2), inDelta(1, 1e-6));
        expect(x.exponent(), equals(2));
        x = d3.scale.pow().exponent(-1).domain([1, 2]);
        expect(x(1), inDelta(0, 1e-6));
        expect(x(1.5), inDelta(.6666667, 1e-6));
        expect(x(2), inDelta(1, 1e-6));
        expect(x.exponent(), equals(-1));
      });
      test('changing the exponent does not change the domain or range', () {
        var x = d3.scale.pow().domain([1, 2]).range([3, 4]), f = d3.format('.6f');
        x.exponent(.5);
        expect(x.domain().map(f), equals([1, 2]));
        expect(x.range(), equals([3, 4]));
        x.exponent(2);
        expect(x.domain().map(f), equals([1, 2]));
        expect(x.range(), equals([3, 4]));
        x.exponent(-1);
        expect(x.domain().map(f), equals([1, 2]));
        expect(x.range(), equals([3, 4]));
      });
    });

    group('interpolate', () {
      test('defaults to d3.interpolate', () {
        var x = d3.scale.pow().range(['red', 'blue']);
        expect(x.interpolate(), equals(d3.interpolate));
        expect(x(.5), equals('#800080'));
      });
      test('can specify a custom interpolator', () {
        var x = d3.scale.pow().range(['red', 'blue']).interpolate(d3.interpolateHsl);
        expect(x(.5), equals('#ff00ff'));
      });
    });

    group('clamp', () {
      test('does not clamp by default', () {
        var x = d3.scale.pow();
        expect(x.clamp(), isFalse);
        expect(x(-.5), inDelta(-.5, 1e-6));
        expect(x(1.5), inDelta(1.5, 1e-6));
      });
      test('can clamp to the domain', () {
        var x = d3.scale.pow().clamp(true);
        expect(x(-.5), inDelta(0, 1e-6));
        expect(x(.5), inDelta(.5, 1e-6));
        expect(x(1.5), inDelta(1, 1e-6));
        x = d3.scale.pow().domain([1, 0]).clamp(true);
        expect(x(-.5), inDelta(1, 1e-6));
        expect(x(.5), inDelta(.5, 1e-6));
        expect(x(1.5), inDelta(0, 1e-6));
      });
    });

    test('maps a number to a number', () {
      var x = d3.scale.pow().domain([1, 2]);
      expect(x(.5), inDelta(-.5, 1e-6));
      expect(x(1), inDelta(0, 1e-6));
      expect(x(1.5), inDelta(.5, 1e-6));
      expect(x(2), inDelta(1, 1e-6));
      expect(x(2.5), inDelta(1.5, 1e-6));
    });

    group('ticks', () {
      test('can generate ticks of varying degree', () {
        var x = d3.scale.pow();
        expect(x.ticks(1).map(x.tickFormat(1)), equals([0, 1]));
        expect(x.ticks(2).map(x.tickFormat(2)), equals([0, .5, 1]));
        expect(x.ticks(5).map(x.tickFormat(5)), equals([0, .2, .4, .6, .8, 1]));
        expect(x.ticks(10).map(x.tickFormat(10)), equals([0, .1, .2, .3, .4, .5, .6, .7, .8, .9, 1]));
        x = d3.scale.pow().domain([1, 0]);
        expect(x.ticks(1).map(x.tickFormat(1)), equals([0, 1]));
        expect(x.ticks(2).map(x.tickFormat(2)), equals([0, .5, 1]));
        expect(x.ticks(5).map(x.tickFormat(5)), equals([0, .2, .4, .6, .8, 1]));
        expect(x.ticks(10).map(x.tickFormat(10)), equals([0, .1, .2, .3, .4, .5, .6, .7, .8, .9, 1]));
      });
    });

    group('tickFormat', () {
      test('if count is not specified, defaults to 10', () {
        var x = d3.scale.pow();
        expect(x.tickFormat()(Math.PI), same('3.1'));
        expect(x.tickFormat(1)(Math.PI), same('3'));
        expect(x.tickFormat(10)(Math.PI), same('3.1'));
        expect(x.tickFormat(100)(Math.PI), same('3.14'));
      });
    });

    group('nice', () {
      test('can nice the domain, extending it to round numbers', () {
        var x = d3.scale.pow().domain([1.1, 10.9]).nice();
        expect(x.domain(), equals([1, 11]));
        x = d3.scale.pow().domain([10.9, 1.1]).nice();
        expect(x.domain(), equals([11, 1]));
        x = d3.scale.pow().domain([.7, 11.001]).nice();
        expect(x.domain(), equals([0, 12]));
        x = d3.scale.pow().domain([123.1, 6.7]).nice();
        expect(x.domain(), equals([130, 0]));
        x = d3.scale.pow().domain([0, .49]).nice();
        expect(x.domain(), equals([0, .5]));
        x = d3.scale.pow().domain([0, 0]).nice();
        expect(x.domain(), equals([0, 0]));
        x = d3.scale.pow().domain([.5, .5]).nice();
        expect(x.domain(), equals([.5, .5]));
      });
      test('nicing a polypower domain only affects the extent', () {
        var x = d3.scale.pow().domain([1.1, 1, 2, 3, 10.9]).nice();
        expect(x.domain(), equals([1, 1, 2, 3, 11]));
        x = d3.scale.pow().domain([123.1, 1, 2, 3, -.9]).nice();
        expect(x.domain(), equals([130, 1, 2, 3, -10]));
      });
      test('accepts a tick count to control nicing step', () {
        var x = d3.scale.pow().domain([12, 87]).nice(5);
        expect(x.domain(), equals([0, 100]));
        x = d3.scale.pow().domain([12, 87]).nice(10);
        expect(x.domain(), equals([10, 90]));
        x = d3.scale.pow().domain([12, 87]).nice(100);
        expect(x.domain(), equals([12, 87]));
      });
    });

    group('copy', () {
      test('changes to the domain are isolated', () {
        var x = d3.scale.pow(), y = x.copy();
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
        var x = d3.scale.pow(), y = x.copy();
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
      test('changes to the exponent are isolated', () {
        var x = d3.scale.pow().exponent(2), y = x.copy();
        x.exponent(.5);
        expect(x(.5), inDelta(Math.SQRT1_2, 1e-6));
        expect(y(.5), inDelta(0.25, 1e-6));
        expect(x.exponent(), equals(.5));
        expect(y.exponent(), equals(2));
        y.exponent(3);
        expect(x(.5), inDelta(Math.SQRT1_2, 1e-6));
        expect(y(.5), inDelta(0.125, 1e-6));
        expect(x.exponent(), equals(.5));
        expect(y.exponent(), equals(3));
      });
      test('changes to the interpolator are isolated', () {
        var x = d3.scale.pow().range(['red', 'blue']), y = x.copy();
        x.interpolate(d3.interpolateHsl);
        expect(x(0.5), equals('#ff00ff'));
        expect(y(0.5), equals('#800080'));
        expect(y.interpolate(), equals(d3.interpolate));
      });
      test('changes to clamping are isolated', () {
        var x = d3.scale.pow().clamp(true), y = x.copy();
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