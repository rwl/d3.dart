import 'package:unittest/unittest.dart';

import 'package:d3/selection/selection.dart';
import 'package:d3/scale/scale.dart';
import 'package:d3/svg/svg.dart';

void main() {
  group('axis', () {
    group('scale', () {
      test('defaults to a linear scale', () {
        var a = new Axis(),
            x = a.scale();
        expect(x.domain(), equals([0, 1]));
        expect(x.range(), equals([0, 1]));
        expect(x(0.5), equals(0.5));
      });
      test('can be defined as a scale object', () {
        var x = new Linear(),
            a = new Axis().scale(x);
        expect(a.scale(), equals(x));
      });
      test('can be a polylinear scale', () {
        var x = new Linear().domain([0, 1, 10]).range([2, 20, 200]),
            a = new Axis().scale(x),
            g = new Selection.selector('body').html('').append('g').call(a),
            path = g.selectAll('path');
        expect(g.selectAll('.tick').data(), closeTo([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 1e-4));
        expect(g.selectAll('.tick').data().map(x), closeTo([2, 20, 40, 60, 80, 100, 120, 140, 160, 180, 200], 1e-4));
        expect(path.attr('d'), equals('M2,6V0H200V6'));
      });
      test('can be an ordinal scale', () {
        var x = new Ordinal().domain(['A', 'B', 'C']).rangeBands([10, 90]),
            a = new Axis().scale(x),
            g = new Selection.selector('body').html('').append('g').call(a),
            path = g.selectAll('path');
        expect(g.selectAll('.tick').data(), equals(['A', 'B', 'C']));
        expect(g.selectAll('.tick').data().map(x), closeTo([10, 36.6667, 63.3333], 1e-4));
        expect(path.attr('d'), equals('M10,6V0H90V6'));
      });
      test('can be an ordinal scale with explicit range', () {
        var x = new Ordinal().domain(['A', 'B', 'C']).range([10, 50, 90]),
            a = new Axis().scale(x),
            g = new Selection.selector('body').html('').append('g').call(a),
            path = g.selectAll('path');
        expect(g.selectAll('.tick').data(), equals(['A', 'B', 'C']));
        expect(g.selectAll('.tick').data().map(x), equals([10, 50, 90]));
        expect(path.attr('d'), equals('M10,6V0H90V6'));
      });
      test('can be a quantize scale', () {
        var x = new scale.Quantize().domain([0, 10]).range([10, 50, 90]),
            a = new Axis().scale(x),
            g = new Selection.selector('body').html('').append('g').call(a);
        expect(g.selectAll('.tick').data(), closeTo([0, 10], 1e-4));
        expect(g.selectAll('.tick').data().map(x), equals([10, 90]));
        expect(g.select('path').attr('d'), equals('M10,6V0H90V6'));
      });
      test('can be a quantile scale', () {
        var x = new scale.Quantile().domain([6, 3, 5, 2, 7, 8, 4, 0, 1, 9]).range([10, 50, 90]),
            a = new Axis().scale(x),
            g = new Selection.selector('body').html('').append('g').call(a);
        expect(g.selectAll('.tick').data(), closeTo([0, 3, 6], 1e-4));
        expect(g.selectAll('.tick').data().map(x), closeTo([10, 50, 90], 1e-4));
        expect(g.select('path').attr('d'), equals('M10,6V0H90V6'));
      });
      test('can be a threshold scale', () {
        var x = new scale.Threshold().domain([4, 5, 6]).range([0, 30, 60, 90]),
            a = new Axis().scale(x),
            g = new Selection.selector('body').html('').append('g').call(a);
        expect(g.selectAll('.tick').data(), closeTo([4, 5, 6], 1e-4));
        expect(g.selectAll('.tick').data().map(x), closeTo([30, 60, 90], 1e-4));
        expect(g.select('path').attr('d'), equals('M0,6V0H90V6'));
      });
      test('when an ordinal scale, does not pollute the scale’s domain with old values', () {
        var x = new Ordinal().domain(['A', 'B', 'C']).range([10, 50, 90]),
            a = new Axis().scale(x),
            g = new Selection.selector('body').html('').append('g').call(a),
            path = g.selectAll('path');
        x.domain(['D', 'E']);
        g.call(a);
        expect(x.domain(), ['D', 'E']);
      });
    });

    group('orient', () {
      test('defaults to bottom', () {
        var a = new Axis();
        expect(a.orient(), equals('bottom'));
      });
      test('defaults to bottom when an invalid orientation is specified', () {
        var a = new Axis().orient('invalid');
        expect(a.orient(), equals('bottom'));
      });
      test('coerces to a string', () {
        var a = new Axis().orient({'toString': () { return 'left'; }});
        expect(a.orient(), equals('left'));
      });
      test('supports top orientation', () {
        var a = new Axis().orient('top'),
            g = new Selection.selector('body').html('').append('g').call(a),
            tick = g.select('g:nth-child(3)'),
            text = tick.select('text'),
            line = tick.select('line'),
            path = g.select('path.domain');
        expect(tick.attr('transform'), equals('translate(0.2,0)'));
        expect(text.attr('y'), equals(-9));
        expect(text.attr('dy'), equals('0em'));
        expect(text.style('text-anchor'), equals('middle'));
        expect(text.text(), equals('0.2'));
        expect(line.attr('y2'), equals(-6));
        expect(path.attr('d'), equals('M0,-6V0H1V-6'));
      });
      test('supports right orientation', () {
        var a = new Axis().orient('right'),
            g = new Selection.selector('body').html('').append('g').call(a),
            tick = g.select('g:nth-child(3)'),
            text = tick.select('text'),
            line = tick.select('line'),
            path = g.select('path.domain');
        expect(tick.attr('transform'), equals('translate(0,0.2)'));
        expect(text.attr('x'), equals(9));
        expect(text.attr('dy'), equals('.32em'));
        expect(text.style('text-anchor'), equals('start'));
        expect(text.text(), equals('0.2'));
        expect(line.attr('x2'), equals(6));
        expect(path.attr('d'), equals('M6,0H0V1H6'));
      });
      test('supports bottom orientation', () {
        var a = new Axis().orient('bottom'),
            g = new Selection.selector('body').html('').append('g').call(a),
            tick = g.select('g:nth-child(3)'),
            text = tick.select('text'),
            line = tick.select('line'),
            path = g.select('path.domain');
        expect(tick.attr('transform'), equals('translate(0.2,0)'));
        expect(text.attr('y'), equals(9));
        expect(text.attr('dy'), equals('.71em'));
        expect(text.style('text-anchor'), equals('middle'));
        expect(text.text(), equals('0.2'));
        expect(line.attr('y2'), equals(6));
        expect(path.attr('d'), equals('M0,6V0H1V6'));
      });
      test('supports left orientation', () {
        var a = new Axis().orient('left'),
            g = new Selection.selector('body').html('').append('g').call(a),
            tick = g.select('g:nth-child(3)'),
            text = tick.select('text'),
            line = tick.select('line'),
            path = g.select('path.domain');
        expect(tick.attr('transform'), equals('translate(0,0.2)'));
        expect(text.attr('x'), equals(-9));
        expect(text.attr('dy'), equals('.32em'));
        expect(text.style('text-anchor'), equals('end'));
        expect(text.text(), equals('0.2'));
        expect(line.attr('x2'), equals(-6));
        expect(path.attr('d'), equals('M-6,0H0V1H-6'));
      });
    });

    group('tickSize', () {
      test('defaults to six pixels', () {
        var a = new Axis();
        expect(a.tickSize(), same(6));
      });
      test('can be defined as a number', () {
        var a = new Axis().tickSize(3);
        expect(a.tickSize(), same(3));
      });
      test('coerces input values to numbers', () {
        var a = new Axis().tickSize('3');
        expect(a.tickSize(), same(3));
        expect(a.innerTickSize(), same(3));
        expect(a.outerTickSize(), same(3));
        a.tickSize('4', '5');
        expect(a.tickSize(), same(4));
        expect(a.innerTickSize(), same(4));
        expect(a.outerTickSize(), same(5));
      });
      test('with no arguments, returns the inner tick size', () {
        var a = new Axis().innerTickSize(10);
        expect(a.tickSize(), same(10));
      });
      test('with one argument, specifies both the inner and outer tick size', () {
        var a = new Axis().tickSize(10);
        expect(a.innerTickSize(), same(10));
        expect(a.outerTickSize(), same(10));
      });
      test('with two arguments, specifies inner and outer tick sizes', () {
        var a = new Axis().tickSize(2, 4);
        expect(a.innerTickSize(), same(2));
        expect(a.outerTickSize(), same(4));
      });
      test('with three arguments (for backwards compatibility), specifies the inner and outer tick sizes', () {
        var a = new Axis().tickSize(1, 2, 3);
        expect(a.innerTickSize(), same(1));
        expect(a.outerTickSize(), same(3));
      });
    });

    group('innerTickSize', () {
      test('defaults to six pixels', () {
        var a = new Axis();
        expect(a.innerTickSize(), same(6));
      });
      test('can be defined as a number', () {
        var a = new Axis().innerTickSize(3);
        expect(a.innerTickSize(), same(3));
      });
      test('when changed, does not affect the outer tick size', () {
        var a = new Axis().innerTickSize(3);
        expect(a.outerTickSize(), same(6));
      });
      test('coerces the specified value to a number', () {
        var a = new Axis().innerTickSize('3');
        expect(a.innerTickSize(), same(3));
      });
      test('with no arguments, returns the outer tick size', () {
        var a = new Axis().outerTickSize(10);
        expect(a.outerTickSize(), same(10));
      });
      test('affects the generated tick lines', () {
        var a = new Axis().innerTickSize(3),
            g = new Selection.selector('body').html('').append('g').call(a),
            line = g.selectAll('g line');
        line.each((n, d, i, j) {
          expect(new Selection.node(n).attr('y2'), equals(3));
        });
      });
      test('if negative, labels are placed on the opposite end', () {
        var a = new Axis().innerTickSize(-80),
            g = new Selection.selector('body').html('').append('g').call(a),
            line = g.selectAll('g line'),
            text = g.selectAll('g text');
        line.each((n, d, i, j) {
          expect(new Selection.node(n).attr('y2'), equals(-80));
        });
        text.each((n, d, i, j) {
          expect(new Selection.node(n).attr('y'), equals(3));
        });
      });
    });

    group('outerTickSize', () {
      test('defaults to six pixels', () {
        var a = new Axis();
        expect(a.outerTickSize(), same(6));
      });
      test('can be defined as a number', () {
        var a = new Axis().outerTickSize(3);
        expect(a.outerTickSize(), same(3));
      });
      test('when changed, does not affect the inner tick size', () {
        var a = new Axis().outerTickSize(3);
        expect(a.innerTickSize(), same(6));
      });
      test('coerces the specified value to a number', () {
        var a = new Axis().outerTickSize('3');
        expect(a.outerTickSize(), same(3));
      });
      test('with no arguments, returns the inner tick size', () {
        var a = new Axis().innerTickSize(10);
        expect(a.innerTickSize(), same(10));
      });
      test('affects the generated domain path', () {
        var a = new Axis().tickSize(3),
            g = new Selection.selector('body').html('').append('g').call(a),
            path = g.select('path.domain');
        expect(path.attr('d'), equals('M0,3V0H1V3'));
      });
      test('with three arguments, specifies end tick size and ignores minor tick size', () {
        var a = new Axis().tickSize(6, 3, 9),
            g = new Selection.selector('body').html('').append('g').call(a),
            path = g.selectAll('path');
        expect(path.attr('d'), equals('M0,9V0H1V9'));
      });
    });

    group('tickPadding', () {
      test('defaults to three pixels', () {
        var a = new Axis();
        expect(a.tickPadding(), equals(3));
      });
      test('can be defined as a number', () {
        var a = new Axis().tickPadding(6);
        expect(a.tickPadding(), equals(6));
      });
      test('coerces input value to a number', () {
        var a = new Axis().tickPadding('6');
        expect(a.tickPadding(), equals(6));
      });
      test('affects the generated tick labels', () {
        var a = new Axis().tickSize(2).tickPadding(7),
            g = new Selection.selector('body').html('').append('g').call(a),
            text = g.selectAll('g text');
        text.each((n, d, i, j) {
          expect(new Selection.node(n).attr('y'), equals(9));
        });
      });
    });

    group('ticks', () {
      test('defaults to [10]', () {
        var a = new Axis();
        expect(a.ticks(), equals([10]));
      });
      test('can be defined as any arguments', () {
        var b = {}, a = new Axis().ticks(b, 42), t = a.ticks();
        expect(t[0], equals(b));
        expect(t[1], equals(42));
        expect(t.length, equals(2));
      });
      test('passes any arguments to the scale\'s ticks function', () {
        var x = _.scale.linear(), b = {}, a = new Axis().ticks(b, '%').scale(x), aa = [],
            g = new Selection.selector('body').html('').append('g');
        x.copy = () { return x; };
        x.ticks = () { aa.push(arguments); return [42]; };
        g.call(a);
        expect(aa.length, equals(1));
        expect(aa[0].length, equals(2));
        expect(aa[0][0], equals(b));
        expect(aa[0][1], equals('%'));
      });
      test('passes any arguments to the scale\'s tickFormat function', () {
        var b = {},
            x = _.scale.linear(),
            a = new Axis().scale(x).ticks(b, '%'),
            g = new Selection.selector('body').html('').append('g'),
            aa = [];
        x.copy = () { return x; };
        x.tickFormat = () { aa.push(arguments); return String; };
        g.call(a);
        expect(aa.length, equals(1));
        expect(aa[0].length, equals(2));
        expect(aa[0][0], equals(b));
        expect(aa[0][1], equals('%'));
      });
      test('affects the generated ticks', () {
        var a = new Axis().ticks(20, '%'),
            g = new Selection.selector('body').html('').append('g').call(a),
            t = g.selectAll('g');
        expect(t[0].length, equals(21));
        expect(t[0][0].textContent, equals('0%'));
      });
      test('only substitutes precision if not specified', () {
        var a = new Axis().ticks(20, '.5%'),
            g = new Selection.selector('body').html('').append('g').call(a),
            t = g.selectAll('g');
        expect(t[0].length, equals(21));
        expect(t[0][0].textContent, equals('0.00000%'));
      });
    });

    group('tickValues', () {
      test('defaults to null', () {
        var a = new Axis().tickValues();
        expect(a);
      });
      test('can be given as array of positions', () {
        var l = [1, 2.5, 3], a = new Axis().tickValues(l), t = a.tickValues();
        expect(t, equals(l));
        expect(t.length, equals(3));
      });
      test('does not change the tick arguments', () {
        var b = {}, a = new Axis().ticks(b, 42).tickValues([10]), t = a.ticks();
        expect(t[0], equals(b));
        expect(t[1], equals(42));
        expect(t.length, equals(2));
      });
      test('does not change the arguments passed to the scale\'s tickFormat function', () {
        var x = new Linear(),
            a = new Axis().scale(x).ticks(10).tickValues([1, 2, 3]),
            g = new Selection.selector('body').html('').append('g'),
            aa = [];
        x.copy = () { return x; };
        x.tickFormat = () { aa.push(arguments); return String; };
        g.call(a);
        expect(aa.length, equals(1));
        expect(aa[0].length, equals(1));
        expect(aa[0][0], equals(10));
      });
      test('affects the generated ticks', () {
        var a = new Axis().ticks(20),
            g = new Selection.selector('body').html('').append('g').call(a),
            t = g.selectAll('g');
        expect(t[0].length, equals(21));
      });
    });

    group('tickSubdivide', () {
      test('is deprecated and does nothing', () {
        var a = new Axis();
        expect(a.tickSubdivide(), equals(0));
        expect(a.tickSubdivide(1), same(a));
        expect(a.tickSubdivide(), equals(0));
      });
    });

    group('tickFormat', () {
      test('defaults to null', () {
        var a = new Axis();
        expect(a.tickFormat() == null, isTrue);
      });
      test('when null, uses the scale\'s tick format', () {
        var x = _.scale.linear(), a = new Axis().scale(x),
            g = new Selection.selector('body').html('').append('g');
        x.copy = () { return x; };
        x.tickFormat = () { return (d) { return 'foo-' + d; }; };
        g.call(a);
        var t = g.selectAll('g text');
        expect(t.text(), equals('foo-0'));
      });
      test('affects the generated tick labels', () {
        var a = new Axis().tickFormat(d3.format('+.2%')),
            g = new Selection.selector('body').html('').append('g').call(a),
            t = g.selectAll('g text');
        expect(t.text(), equals('+0.00%'));
      });
      test('can be set to a constant', () {
        var a = new Axis().tickFormat('I\'m a tick!'),
            g = new Selection.selector('body').html('').append('g').call(a),
            t = g.selectAll('g text');
        expect(t.text(), equals('I\'m a tick!'));
      });
      test('can be set to a falsey constant', () {
        var a = new Axis().tickFormat(''),
            g = new Selection.selector('body').html('').append('g').call(a),
            t = g.selectAll('g text');
        expect(t.text(), equals(''));
      });
    });

    group('enter', () {
      test('generates a new domain path', () {
        var a = new Axis(),
            g = new Selection.selector('body').html('').append('g').call(a),
            path = g.selectAll('path.domain');
        expect(path[0].length, equals(1));
        expect(path.attr('d'), equals('M0,6V0H1V6'));
        expect(path.node().nextSibling, isNull);
      });
      test('generates new tick marks with labels', () {
        var a = new Axis(),
            g = new Selection.selector('body').html('').append('g').call(a),
            x = _.scale.linear(),
            tick = g.selectAll('g'),
            ticks = x.ticks(10),
            tickFormat = x.tickFormat(10);
        expect(tick[0].length, equals(ticks.length));
        tick.each((n, d, i, j) {
          var t = new Selection.node(node);
          expect(t.select('line').empty(), isFalse);
          expect(t.select('text').empty(), isFalse);
          expect(t.select('text').text(), equals(tickFormat(ticks[i])));
        });
      });
    });

    group('update', () {
      test('updates the domain path', () {
        var a = new Axis(),
            g = new Selection.selector('body').html('').append('g').call(a);
        a.scale().domain([0, 2]).range([1, 2]);
        a.tickSize(3);
        g.call(a);
        var path = g.selectAll('path.domain');
        expect(path[0].length, equals(1));
        expect(path.attr('d'), equals('M1,3V0H2V3'));
        expect(path.node().nextSibling, /*domEquals*/equals((null)));
      });
      test('enters, exits and updates tick marks', () {
        var a = new Axis(),
            g = new Selection.selector('body').html('').append('g').call(a),
            x = new Linear().domain([1, 1.5]);
        a.scale().domain(x.domain());
        a.tickSize(3).tickPadding(9);
        g.call(a);
        var tick = g.selectAll('g'),
            ticks = x.ticks(10),
            tickFormat = x.tickFormat(10);
        expect(tick[0].length, equals(ticks.length));
        tick.each((n, d, i, j) {
          var t = new Selection.node(n);
          expect(t.select('line').empty(), isFalse);
          expect(t.select('text').empty(), isFalse);
          expect(t.select('text').text(), equals(tickFormat(ticks[i])));
        });
      });
    });
  });
}
