import 'package:unittest/unittest.dart';

import '../../src/scale/scale.dart' as d4;

void main() {
  group('log', () {
    var log = load('scale/log').expression('interpolate/hsl'); // beware instanceof d3_Color
    group('domain', () {
      test('defaults to [1, 10], exactly', () {
        var x = d3.scale.log();
        expect(x.domain(), equals([1, 10]));
        expect(x(5), inDelta(0.69897, 1e-6));
      });
      test('coerces domain values to numbers', () {
        var x = d3.scale.log().domain([new Date(1990, 0, 1), new Date(1991, 0, 1)]);
        expect(x.domain()[0], typeof('number'));
        expect(x.domain()[1], typeof('number'));
        expect(x(new Date(1989, 09, 20)), inDelta(-.2, 1e-2));
        expect(x(new Date(1990, 00, 01)), inDelta(0, 1e-2));
        expect(x(new Date(1990, 02, 15)), inDelta(.2, 1e-2));
        expect(x(new Date(1990, 04, 27)), inDelta(.4, 1e-2));
        expect(x(new Date(1991, 00, 01)), inDelta(1, 1e-2));
        expect(x(new Date(1991, 02, 15)), inDelta(1.2, 1e-2));
        x = d3.scale.log().domain(['1', '10']);
        expect(x.domain()[0], typeof('number'));
        expect(x.domain()[1], typeof('number'));
        expect(x(5), 0.69897, 1e-6);
        x = d3.scale.log().domain([new Number(1), new Number(10)]);
        expect(x.domain()[0], typeof('number'));
        expect(x.domain()[1], typeof('number'));
        expect(x(5), inDelta(0.69897, 1e-6));
      });
      test('can specify negative domain values', () {
        var x = d3.scale.log().domain([-100, -1]);
        expect(x.ticks().map(x.tickFormat()), [
          '-1e+2',
          '-9e+1', '-8e+1', '-7e+1', '-6e+1', '-5e+1', '-4e+1', '-3e+1', '-2e+1', '-1e+1',
          '-9e+0', '-8e+0', '-7e+0', '-6e+0', '-5e+0', '-4e+0', '-3e+0', '-2e+0', '-1e+0'
        ]);
        expect(x(-50), inDelta(0.150515, 1e-6));
      });
      test('can specify a polylog domain and range', () {
        var x = d3.scale.log().domain([.1, 1, 100]).range(['red', 'white', 'green']);
        expect(x(.5), equals('#ffb2b2'));
        expect(x(50), equals('#269326'));
        expect(x(75), equals('#108810'));
      });
      test('preserves specified domain exactly, with no floating point error', () {
        var x = d3.scale.log().domain([.1, 1000]);
        expect(x.domain(), equals([.1, 1000]));
      });
    });

    group('range', () {
      test('defaults to [0, 1]', () {
        var x = d3.scale.log();
        expect(x.range(), equals([0, 1]));
        expect(x.invert(.5), inDelta(3.162278, 1e-6))
      });
      test('does not coerce range to numbers', () {
        var x = d3.scale.log().range(['0', '2']);
        expect(x.range()[0], typeof('string'));
        expect(x.range()[1], typeof('string'));
      });
      test('can specify range values as colors', () {
        var x = d3.scale.log().range(['red', 'blue']);
        expect(x(5), equals('#4d00b2'));
        x = d3.scale.log().range(['#ff0000', '#0000ff']);
        expect(x(5), equals('#4d00b2'));
        x = d3.scale.log().range(['#f00', '#00f']);
        expect(x(5), equals('#4d00b2'));
        x = d3.scale.log().range([d3.rgb(255,0,0), d3.hsl(240,1,.5)]);
        expect(x(5), equals('#4d00b2'));
        x = d3.scale.log().range(['hsl(0,100%,50%)', 'hsl(240,100%,50%)']);
        expect(x(5), equals('#4d00b2'));
      });
      test('can specify range values as arrays or objects', () {
        var x = d3.scale.log().range([{color: 'red'}, {color: 'blue'}]);
        expect(x(5), equals({color: '#4d00b2'}));
        x = d3.scale.log().range([['red'], ['blue']]);
        expect(x(5), equals(['#4d00b2']));
      });
    });

    group('interpolate', () {
      test('defaults to d3.interpolate', () {
        var x = d3.scale.log().range(['red', 'blue']);
        expect(x.interpolate(), equals(d3.interpolate));
        expect(x(5), equals('#4d00b2'));
      });
      test('can specify a custom interpolator', () {
        var x = d3.scale.log().range(['red', 'blue']).interpolate(d3.interpolateHsl);
        expect(x(5), equals('#9a00ff'));
      });
    });

    group('clamp', () {
      test('defaults to false', () {
        var x = d3.scale.log();
        expect(x.clamp(), isFalse);
        expect(x(.5), inDelta(-0.3010299, 1e-6));
        expect(x(15), inDelta(1.1760913, 1e-6));
      });
      test('can clamp to the domain', () {
        var x = d3.scale.log().clamp(true);
        expect(x(-1), inDelta(0, 1e-6));
        expect(x(5), inDelta(0.69897, 1e-6));
        expect(x(15), inDelta(1, 1e-6));
        x = d3.scale.log().domain([10, 1]).clamp(true);
        expect(x(-1), inDelta(1, 1e-6));
        expect(x(5), inDelta(0.30103, 1e-6));
        expect(x(15), inDelta(0, 1e-6));
      });
      test('can clamp to the range', () {
        var x = d3.scale.log().clamp(true);
        expect(x.invert(-.1), inDelta(1, 1e-6));
        expect(x.invert(0.69897), inDelta(5, 1e-6));
        expect(x.invert(1.5), inDelta(10, 1e-6));
        x = d3.scale.log().domain([10, 1]).clamp(true);
        expect(x.invert(-.1), inDelta(10, 1e-6));
        expect(x.invert(0.30103), inDelta(5, 1e-6));
        expect(x.invert(1.5), inDelta(1, 1e-6));
      });
    });

    group('maps a number to a number', () {
      var x = d3.scale.log().domain([1, 2]);
      expect(x(.5), inDelta(-1, 1e-6));
      expect(x(1), inDelta(0, 1e-6));
      expect(x(1.5), inDelta(0.5849625, 1e-6));
      expect(x(2), inDelta(1, 1e-6));
      expect(x(2.5), inDelta(1.3219281, 1e-6));
    },

    group('invert', () {
      test('maps a number to a number', () {
        var x = d3.scale.log().domain([1, 2]);
        expect(x.invert(-1), inDelta(.5, 1e-6));
        expect(x.invert(0), inDelta(1, 1e-6));
        expect(x.invert(0.5849625), inDelta(1.5, 1e-6));
        expect(x.invert(1), inDelta(2, 1e-6));
        expect(x.invert(1.3219281), inDelta(2.5, 1e-6));
      });
      test('coerces range value to number on invert', () {
        var x = d3.scale.log().range(['0', '2']);
        expect(x.invert('1'), inDelta(3.1622777, 1e-6));
        x = d3.scale.log().range([new Date(1990, 0, 1), new Date(1991, 0, 1)]);
        expect(x.invert(new Date(1990, 6, 2, 13)), inDelta(3.1622777, 1e-6));
        x = d3.scale.log().range(['#000', '#fff']);
        assert.isNaN(x.invert('#999'));
      });
    });

    group('ticks', () {
      test('can generate ticks', () {
        var x = d3.scale.log();
        expect(x.ticks().map(x.tickFormat()), equals([
          '1e+0', '2e+0', '3e+0', '4e+0', '5e+0', '6e+0', '7e+0', '8e+0', '9e+0',
          '1e+1'
        ]));
        x = d3.scale.log().domain([100, 1]);
        expect(x.ticks().map(x.tickFormat()), equals([
          '1e+0', '2e+0', '3e+0', '4e+0', '5e+0', '6e+0', '7e+0', '8e+0', '9e+0',
          '1e+1', '2e+1', '3e+1', '4e+1', '5e+1', '6e+1', '7e+1', '8e+1', '9e+1',
          '1e+2'
        ]));
        x = d3.scale.log().domain([0.49999, 0.006029505943610648]);
        expect(x.ticks().map(x.tickFormat()), equals([
          '7e-3', '8e-3', '9e-3', '1e-2', '2e-2', '3e-2', '4e-2', '5e-2',
          '6e-2', '7e-2', '8e-2', '9e-2', '1e-1', '2e-1', '3e-1', '4e-1'
        ]));
        x = d3.scale.log().domain([.95, 1.05e8]);
        expect(x.ticks().map(x.tickFormat(8)).filter(String), equals([
          '1e+0', '1e+1', '1e+2', '1e+3', '1e+4', '1e+5', '1e+6', '1e+7', '1e+8'
        ]));
      });
      test('can generate fewer ticks, if desired', () {
        var x = d3.scale.log();
        expect(x.ticks().map(x.tickFormat(5)), equals([
          '1e+0', '2e+0', '3e+0', '4e+0', '5e+0', '', '', '', '',
          '1e+1'
        ]));
        x = d3.scale.log().domain([100, 1]);
        expect(x.ticks().map(x.tickFormat(10)), equals([
          '1e+0', '2e+0', '3e+0', '4e+0', '5e+0', '', '', '', '',
          '1e+1', '2e+1', '3e+1', '4e+1', '5e+1', '', '', '', '',
          '1e+2'
        ]));
      });
      test('generates powers-of-ten ticks, even for huge domains', () {
        var x = d3.scale.log().domain([1e10, 1]);
        expect(x.ticks().map(x.tickFormat(10)), equals([
          '1e+0', '', '', '', '', '', '', '', '',
          '1e+1', '', '', '', '', '', '', '', '',
          '1e+2', '', '', '', '', '', '', '', '',
          '1e+3', '', '', '', '', '', '', '', '',
          '1e+4', '', '', '', '', '', '', '', '',
          '1e+5', '', '', '', '', '', '', '', '',
          '1e+6', '', '', '', '', '', '', '', '',
          '1e+7', '', '', '', '', '', '', '', '',
          '1e+8', '', '', '', '', '', '', '', '',
          '1e+9', '', '', '', '', '', '', '', '',
          '1e+10'
        ]));
      });
      test('generates ticks that cover the domain', () {
        var x = d3.scale.log().domain([.01, 10000]);
        expect(x.ticks(20).map(x.tickFormat(20)), equals([
          '1e-2', '2e-2', '3e-2', '', '', '', '', '', '',
          '1e-1', '2e-1', '3e-1', '', '', '', '', '', '',
          '1e+0', '2e+0', '3e+0', '', '', '', '', '', '',
          '1e+1', '2e+1', '3e+1', '', '', '', '', '', '',
          '1e+2', '2e+2', '3e+2', '', '', '', '', '', '',
          '1e+3', '2e+3', '3e+3', '', '', '', '', '', '',
          '1e+4'
        ]));
      });
      test('generates ticks that cover the niced domain', () {
        var x = d3.scale.log().domain([.0124123, 1230.4]).nice();
        expect(x.ticks(20).map(x.tickFormat(20)), equals([
          '1e-2', '2e-2', '3e-2', '', '', '', '', '', '',
          '1e-1', '2e-1', '3e-1', '', '', '', '', '', '',
          '1e+0', '2e+0', '3e+0', '', '', '', '', '', '',
          '1e+1', '2e+1', '3e+1', '', '', '', '', '', '',
          '1e+2', '2e+2', '3e+2', '', '', '', '', '', '',
          '1e+3', '2e+3', '3e+3', '', '', '', '', '', '',
          '1e+4'
        ]));
      });
      test('can override the tick format', () {
        var x = d3.scale.log().domain([1000.1, 1]);
        expect(x.ticks().map(x.tickFormat(10, d3.format('+,d'))), equals([
          '+1', '+2', '+3', '', '', '', '', '', '',
          '+10', '+20', '+30', '', '', '', '', '', '',
          '+100', '+200', '+300', '', '', '', '', '', '',
          '+1,000'
        ]));
      });
      test('can override the tick format as string', () {
        var x = d3.scale.log().domain([1000.1, 1]);
        expect(x.ticks().map(x.tickFormat(10, '.1s')), equals([
          '1', '2', '3', '', '', '', '', '', '',
          '10', '20', '30', '', '', '', '', '', '',
          '100', '200', '300', '', '', '', '', '', '',
          '1k'
        ]));
      });
      test('generates empty ticks when the domain is degenerate', () {
        var x = d3.scale.log();
        expect(x.domain([0, 1]).ticks(), equals([]));
        expect(x.domain([1, 0]).ticks(), equals([]));
        expect(x.domain([0, -1]).ticks(), equals([]));
        expect(x.domain([-1, 0]).ticks(), equals([]));
        expect(x.domain([-1, 1]).ticks(), equals([]));
        expect(x.domain([0, 0]).ticks(), equals([]));
      });
    });

    group('base two', () {
      var x = () {
        return d3.scale.log().domain([1, 32]).base(2);
      };
      group('with a suitable tick format', () {
        var ticks = () {
          return x.ticks().map(x.tickFormat(10, d3.format('+,d')));
        };
        test('generates ticks at powers of two', () {
          expect(ticks, equals([
            '+1', '+2', '+4', '+8', '+16', '+32'
          ]));
        });
      });
    });

    group('base e', () {
      var x = () {
        return d3.scale.log().domain([1, 32]).base(Math.E);
      };
      group('with a suitable tick format', () {
        var ticks = () {
          return x.ticks().map(x.tickFormat(10, d3.format('+.6r')));
        };
        test('generates ticks at powers of e', () {
          expect(ticks, equals([
            '+1.00000', '+2.71828', '+7.38906', '+20.0855'
          ]));
        });
      });
    });

    group('nice', () {
      test('can nice the domain, extending it to powers of ten', () {
        var x = d3.scale.log().domain([1.1, 10.9]).nice();
        expect(x.domain(), inDelta([1, 100], 1e-6));
        var x = d3.scale.log().domain([10.9, 1.1]).nice();
        expect(x.domain(), inDelta([100, 1], 1e-6));
        var x = d3.scale.log().domain([.7, 11.001]).nice();
        expect(x.domain(), inDelta([.1, 100], 1e-6));
        var x = d3.scale.log().domain([123.1, 6.7]).nice();
        expect(x.domain(), inDelta([1000, 1], 1e-6));
        var x = d3.scale.log().domain([.01, .49]).nice();
        expect(x.domain(), inDelta([.01, 1], 1e-6));
      });
      test('works on degenerate domains', () {
        var x = d3.scale.log().domain([0, 0]).nice();
        expect(x.domain(), inDelta([0, 0], 1e-6));
        var x = d3.scale.log().domain([.5, .5]).nice();
        expect(x.domain(), inDelta([.1, 1], 1e-6));
      });
      test('nicing a polylog domain only affects the extent', () {
        var x = d3.scale.log().domain([1.1, 1.5, 10.9]).nice();
        expect(x.domain(), inDelta([1, 1.5, 100], 1e-6));
        var x = d3.scale.log().domain([-123.1, -1.5, -.5]).nice();
        expect(x.domain(), inDelta([-1000, -1.5, -.1], 1e-6));
      });
      test('the niced domain is subsequently used by the scale', () {
        var x = d3.scale.log().domain([1.5, 50]).nice();
        expect(x.domain(), inDelta([1, 100], 1e-6));
        expect(x(1), inDelta(0, 1e-6));
        expect(x(100), inDelta(1, 1e-6));
      });
    });

    group('copy', () {
      test('changes to the domain are isolated', () {
        var x = d3.scale.log(), y = x.copy();
        x.domain([10, 100]);
        expect(y.domain(), inDelta([1, 10], 1e-6));
        expect(x(10), inDelta(0, 1e-6));
        expect(y(1), inDelta(0, 1e-6));
        y.domain([100, 1000]);
        expect(x(100), inDelta(1, 1e-6));
        expect(y(100), inDelta(0, 1e-6));
        expect(x.domain(), inDelta([10, 100], 1e-6));
        expect(y.domain(), inDelta([100, 1000], 1e-6));
      });
      test('changes to the range are isolated', () {
        var x = d3.scale.log(), y = x.copy();
        x.range([1, 2]);
        expect(x.invert(1), inDelta(1, 1e-6));
        expect(y.invert(1), inDelta(10, 1e-6));
        expect(y.range(), [0, 1]);
        y.range([2, 3]);
        expect(x.invert(2), inDelta(10, 1e-6));
        expect(y.invert(2), inDelta(1, 1e-6));
        expect(x.range(), [1, 2]);
        expect(y.range(), [2, 3]);
      });
      test('changes to the interpolator are isolated', () {
        var x = d3.scale.log().range(['red', 'blue']), y = x.copy();
        x.interpolate(d3.interpolateHsl);
        expect(x(5), equals('#9a00ff'));
        expect(y(5), equals('#4d00b2'));
        expect(y.interpolate(), equals(d3.interpolate));
      });
      test('changes to clamping are isolated', () {
        var x = d3.scale.log().clamp(true), y = x.copy();
        x.clamp(false);
        expect(x(.5), inDelta(-0.30103, 1e-6));
        expect(y(.5), inDelta(0, 1e-6));
        expect(y.clamp(), isTrue);
        y.clamp(false);
        expect(x(20), inDelta(1.30103, 1e-6));
        expect(y(20), inDelta(1.30103, 1e-6));
        expect(x.clamp(), isFalse);
      });
      test('changes to nicing are isolated', () {
        var x = d3.scale.log().domain([1.5, 50]), y = x.copy().nice();
        expect(x.domain(), inDelta([1.5, 50], 1e-6));
        expect(x(1.5), inDelta(0, 1e-6));
        expect(x(50), inDelta(1, 1e-6));
        expect(x.invert(0), inDelta(1.5, 1e-6));
        expect(x.invert(1), inDelta(50, 1e-6));
        expect(y.domain(), inDelta([1, 100], 1e-6));
        expect(y(1), inDelta(0, 1e-6));
        expect(y(100), inDelta(1, 1e-6));
        expect(y.invert(0), inDelta(1, 1e-6));
        expect(y.invert(1), inDelta(100, 1e-6));
      });
    });
  });
}