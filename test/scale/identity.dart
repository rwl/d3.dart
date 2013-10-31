import 'package:unittest/unittest.dart';

import '../../src/scale/scale.dart' as d4;

void main() {
  group('identity', () {
    var identity = load('scale/identity').expression('d3.scale.identity'); 
    group('domain and range', () {
      test('are identical', () {
        var x = identity();
        expect(x.domain, same(x.range));
        expect(x.domain(), same(x.range()));
        x = identity().domain([-10, 0, 100]);
        expect(x.range(), equals([-10, 0, 100]));
        x = identity().range([-10, 0, 100]);
        expect(x.domain(), equals([-10, 0, 100]));
      });
      test('default to [0, 1]', () {
        var x = identity();
        expect(x.domain(), equals([0, 1]));
        expect(x.range(), equals([0, 1]));
        expect(x(.5), same(.5));
      });
      test('coerce values to numbers', () {
        var x = identity().domain([new Date(1990, 0, 1), new Date(1991, 0, 1)]);
        expect(x.domain()[0], typeOf('number'));
        expect(x.domain()[1], typeOf('number'));
        expect(x.domain()[0], same(/*+*/new Date(1990, 0, 1)));
        expect(x.domain()[1], same(/*+*/new Date(1991, 0, 1)));
        expect(x(new Date(1989, 09, 20)), typeOf('number'));
        expect(x(new Date(1989, 09, 20)), same(/*+*/new Date(1989, 09, 20)));
        x = identity().domain(['0', '1']);
        expect(x.domain()[0], typeOf('number'));
        expect(x.domain()[1], typeOf('number'));
        expect(x(.5), same(.5));
        x = identity().domain([new Number(0), new Number(1)]);
        expect(x.domain()[0], typeOf('number'));
        expect(x.domain()[1], typeOf('number'));
        expect(x(.5), same(.5));

        x = identity().range([new Date(1990, 0, 1), new Date(1991, 0, 1)]);
        expect(x.range()[0], typeOf('number'));
        expect(x.range()[1], typeOf('number'));
        expect(x.range()[0], same(/*+*/new Date(1990, 0, 1)));
        expect(x.range()[1], same(/*+*/new Date(1991, 0, 1)));
        expect(x(new Date(1989, 09, 20)), typeOf('number'));
        expect(x(new Date(1989, 09, 20)), same(/*+*/new Date(1989, 09, 20)));
        x = identity().range(['0', '1']);
        expect(x.range()[0], typeOf('number'));
        expect(x.range()[1], typeOf('number'));
        expect(x(.5), same(.5));
        x = identity().range([new Number(0), new Number(1)]);
        expect(x.range()[0], typeOf('number'));
        expect(x.range()[1], typeOf('number'));
        expect(x(.5), same(.5));
      });
      test('can specify a polyidentity domain and range', () {
        var x = identity().domain([-10, 0, 100]);
        expect(x.domain(), equals([-10, 0, 100]));
        expect(x(-5), same(-5));
        expect(x(50), same(50));
        expect(x(75), same(75));

        x = identity().range([-10, 0, 100]);
        expect(x.range(), equals([-10, 0, 100]));
        expect(x(-5), same(-5));
        expect(x(50), same(50));
        expect(x(75), same(75));
      });
      test('do not affect the identity function', () {
        var x = identity().domain([double.INFINITY, double.NAN]);
        expect(x(42), same(42));
        expect(x.invert(-42), same(-42));
      });
    });

    test('is the identity function', () {
      var x = identity().domain([1, 2]);
      expect(x(.5), same(.5));
      expect(x(1), same(1));
      expect(x(1.5), same(1.5));
      expect(x(2), same(2));
      expect(x(2.5), same(2.5));
    });
    test('coerces input to a number', () {
      var x = identity().domain([1, 2]);
      expect(x('2'), same(2));
    });

    group('invert', () {
      test('is the identity function', () {
        var x = identity().domain([1, 2]);
        expect(x.invert(.5), same(.5));
        expect(x.invert(1), same(1));
        expect(x.invert(1.5), same(1.5));
        expect(x.invert(2), same(2));
        expect(x.invert(2.5), same(2.5));
      });
      test('coerces range value to numbers', () {
        var x = identity().range(['0', '2']);
        expect(x.invert('1'), same(1));
        x = identity().range([new Date(1990, 0, 1), new Date(1991, 0, 1)]);
        expect(x.invert(new Date(1990, 6, 2, 13)), same(/*+*/new Date(1990, 6, 2, 13)));
        x = identity().range(['#000', '#fff']);
        expect(x.invert('#999'), equals(double.NAN));
      });
      test('coerces input to a number', () {
        var x = identity().domain([1, 2]);
        expect(x.invert('2'), same(2));
      });
    });

    group('ticks', () {
      test('generates ticks of varying degree', () {
        var x = identity();
        expect(x.ticks(1).map(x.tickFormat(1)), equals([0, 1]));
        expect(x.ticks(2).map(x.tickFormat(2)), equals([0, .5, 1]));
        expect(x.ticks(5).map(x.tickFormat(5)), equals([0, .2, .4, .6, .8, 1]));
        expect(x.ticks(10).map(x.tickFormat(10)), equals([0, .1, .2, .3, .4, .5, .6, .7, .8, .9, 1]));
        x = identity().domain([1, 0]);
        expect(x.ticks(1).map(x.tickFormat(1)), equals([0, 1]));
        expect(x.ticks(2).map(x.tickFormat(2)), equals([0, .5, 1]));
        expect(x.ticks(5).map(x.tickFormat(5)), equals([0, .2, .4, .6, .8, 1]));
        expect(x.ticks(10).map(x.tickFormat(10)), equals([0, .1, .2, .3, .4, .5, .6, .7, .8, .9, 1]));
      });
      test('formats ticks with the appropriate precision', () {
        var x = identity().domain([.123456789, 1.23456789]);
        expect(x.tickFormat(1)(x.ticks(1)[0]), same('1'));
        expect(x.tickFormat(2)(x.ticks(2)[0]), same('0.5'));
        expect(x.tickFormat(4)(x.ticks(4)[0]), same('0.2'));
        expect(x.tickFormat(8)(x.ticks(8)[0]), same('0.2'));
        expect(x.tickFormat(16)(x.ticks(16)[0]), same('0.2'));
        expect(x.tickFormat(32)(x.ticks(32)[0]), same('0.15'));
        expect(x.tickFormat(64)(x.ticks(64)[0]), same('0.14'));
        expect(x.tickFormat(128)(x.ticks(128)[0]), same('0.13'));
        expect(x.tickFormat(256)(x.ticks(256)[0]), same('0.125'));
      });
    });

    group('copy', () {
      test('changes to the domain or range are isolated', () {
        var x = identity(), y = x.copy();
        x.domain([1, 2]);
        expect(y.domain(), equals([0, 1]));
        y.domain([2, 3]);
        expect(x.domain(), equals([1, 2]));
        expect(y.domain(), equals([2, 3]));

        x = identity();
        y = x.copy();//TODO check redeclaration order
        x.range([1, 2]);
        expect(y.range(), equals([0, 1]));
        y.range([2, 3]);
        expect(x.range(), equals([1, 2]));
        expect(y.range(), equals([2, 3]));
      });
    });
  });
}