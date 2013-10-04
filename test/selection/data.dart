import 'package:unittest/unittest.dart';

import '../../src/selection/selection.dart' as d4;


void main() {
  group('select(body)', () {
    group('on a simple page', () {
      Selection body = d4.select('body');
      test('assigns data as an array', () {
        var data = new Object();
        body.data([data]);
        expect(body.node().__data__, same(data));
      });
      test('assigns data as a function', () {
        var data = new Object();
        body.data(() { return [data]; });
        expect(body.node().__data__, same(data));
      });
      test('stores data in the DOM', () {
        var expected = new Object(), actual;
        body.node().__data__ = expected;
        body.each((d) { actual = d; });
        expect(actual, same(expected));
      });
      test('returns a new selection', () {
        expect(body.data([1]), same(body));
      });
      test('with no arguments, returns an array of data', () {
        var data = new Object();
        body.data([data]);
        expect(body.data(), equals([data]));
        expect(body.data()[0], same(data));
      });
      test('throws an error if data is null', () {
        var errored;
        try { body.data(null); } catch (e) { errored = true; }
        expect(errored, isTrue);
      });
      test('throws an error if data is a function that returns null', () {
        var errored;
        try { body.data(() {}); } catch (e) { errored = true; }
        expect(errored, isTrue);
      });
    });
  });

  group('selectAll(div)', () {
    var d3 = load('selection/data').document();
    group('on a simple page', () {
      var div =  d3.select('body').selectAll('div').data([0, 1]).enter().append('div');
      test('assigns data as an array', () {
        var a = new Object(), b = new Object();
        div.data([a, b]);
        expect(div[0][0].__data__, same(a));
        expect(div[0][1].__data__, same(b));
      });
      test('assigns data as a function', () {
        var a = new Object(), b = new Object();
        div.data(() { return [a, b]; });
        expect(div[0][0].__data__, same(a));
        expect(div[0][1].__data__, same(b));
      });
      test('stores data in the DOM', () {
        var a = new Object(), b = new Object(), actual = [];
        div[0][0].__data__ = a;
        div[0][1].__data__ = b;
        div.each((d) { actual.push(d); });
        expect(actual, equals([a, b]));
      });
      test('returns a new selection', () {
        expect(div.data([0, 1]) ==/*=*/ div, isFalse);
      });
      test('throws an error if data is null', () {
        var errored;
        try { div.data(null); } catch (e) { errored = true; }
        expect(errored, isTrue);
      });
      test('throws an error if data is a function that returns null', () {
        var errored;
        try { div.data(() {}); } catch (e) { errored = true; }
        expect(errored, isTrue);
      });
      test('with no arguments, returns an array of data', () {
        var a = new Object(), b = new Object(), actual = [];
        div[0][0].__data__ = a;
        div[0][1].__data__ = b;
        expect(div.data(), equals([a, b]));
      });
      test('with no arguments, returned array has undefined for null nodes', () {
        var b = new Object(), actual = [];
        div[0][0] = null;
        div[0][1].__data__ = b;
        var data = div.data();
        expect(data[0], isNull/*isUndefined*/);
        expect(data[1], same(b));
        expect(data.length, equals(2));
      });
    });
  });

  group('selectAll(div)', () {
    var d3 = load('selection/data').document();
    group('on a simple page', () {
      test('ignores duplicate keys in both data and selection', () {
        var div = d3.select('body').html('').selectAll('div')
            .data(['aa', 'ab', 'ac', 'ba', 'bb', 'bc'])
          .enter().append('div')
            .text((d) { return d; });

        var update = div.data(['aa', 'ab', 'ba', 'bb'], (d) { return d.substring(0, 1); });
        var enter = update.enter();
        var exit = update.exit();

        expect(update.length, equals(1));

        // enter     - [   null,   null,   null,   null]
        expect(enter[0].length, equals(4));
        expect(enter[0][0], isNull);
        expect(enter[0][1], isNull);
        expect(enter[0][2], isNull);
        expect(enter[0][3], isNull);

        // update    - [ aa (a),   null, ba (b),   null]
        expect(update[0].length, equals(4));
        expect(update[0][0], same(div[0][0]));
        expect(update[0][1], isNull);
        expect(update[0][2], same(div[0][3]));
        expect(update[0][3], isNull);

        // exit      - [   null, ab (a), ac (a),   null, bb (b), bc (b)]
        expect(exit[0].length, equals(6));
        expect(exit[0][0], isNull);
        expect(exit[0][1], same(div[0][1]));
        expect(exit[0][2], same(div[0][2]));
        expect(exit[0][3], isNull);
        expect(exit[0][4], same(div[0][4]));
        expect(exit[0][5], same(div[0][5]));
      });
    });
  });

  group('selectAll(div).selectAll(span)', () {
    var d3 = load('selection/data').document();
    group('on a simple page', () {
      var span = d3.select('body').selectAll('div')
          .data([0, 1])
            .enter().append('div').selectAll('span')
              .data([0, 1])
                .enter().append('span');
      test('assigns data as an array', () {
        var a = new Object(), b = new Object();
        span.data([a, b]);
        equals(span[0][0].__data__, same(a));
        equals(span[0][1].__data__, same(b));
        equals(span[1][0].__data__, same(a));
        equals(span[1][1].__data__, same(b));
      });
      test('assigns data as a function', () {
        var a = new Object(), b = new Object(), c = new Object(), d = new Object();
        span.data((z, i) { return i ? [c, d] : [a, b]; });
        expect(span[0][0].__data__, same(a));
        expect(span[0][1].__data__, same(b));
        expect(span[1][0].__data__, same(c));
        expect(span[1][1].__data__, same(d));
      });
      test('evaluates the function once per group', () {
        var count = 0;
        span.data(() { ++count; return [0, 1]; });
        expect(count, equals(2));
      });
      test('defines an update selection for updating data', () {
        var update = span.data([0, 1, 2, 3]);
        expect(update.length, equals(2));
        expect(update[0].length, equals(4));
        expect(update[1].length, equals(4));
        expect(update[0][0], domEquals(span[0][0]));
        expect(update[0][1], domEquals(span[0][1]));
        expect(update[0][2], domNull);
        expect(update[0][3], domNull);
        expect(update[1][0], domEquals(span[1][0]));
        expect(update[1][1], domEquals(span[1][1]));
        expect(update[1][2], domNull);
        expect(update[1][3], domNull);
      });
      test('defines an enter selection for entering data', () {
        var enter = span.data([0, 1, 2, 3]).enter();
        expect(enter.empty(), isFalse);
        expect(enter.length, equals(2));
        expect(enter[0].length, equals(4));
        expect(enter[1].length, equals(4));
        expect(enter[0][0], domNull);
        expect(enter[0][1], domNull);
        expect(enter[0][2], equals({__data__: 2}));
        expect(enter[0][3], equals({__data__: 3}));
        expect(enter[1][0], domNull);
        expect(enter[1][1], domNull);
        expect(enter[1][2], equals({__data__: 2}));
        expect(enter[1][3], equals({__data__: 3}));
      });
      test('defines an exit selection for exiting data', () {
        var exit = span.data([0]).exit();
        expect(exit.empty(), isFalse);
        expect(exit.length, equals(2));
        expect(exit[0].length, equals(2));
        expect(exit[1].length, equals(2));
        expect(exit[0][0], domNull);
        expect(exit[0][1], domEquals(span[0][1]));
        expect(exit[1][0], domNull);
        expect(exit[1][1], domEquals(span[1][1]));
      });
      test('observes the specified key function', () {
        var update = span.data([1, 2], Number);
        expect(update.empty(), isFalse);
        expect(update.length, equals(2));
        expect(update[0].length, equals(2));
        expect(update[1].length, equals(2));
        expect(update[0][0], domEquals(span[0][1]));
        expect(update[0][1], domNull);
        expect(update[1][0], domEquals(span[1][1]));
        expect(update[1][1], domNull);

        var enter = update.enter();
        expect(enter.length, equals(2));
        expect(enter[0].length, equals(2));
        expect(enter[1].length, equals(2));
        expect(enter[0][0], domNull);
        expect(enter[0][1], equals({__data__: 2}));
        expect(enter[1][0], domNull);
        expect(enter[1][1], equals({__data__: 2}));

        var exit = update.exit();
        expect(exit.length, equals(2));
        expect(exit[0].length, equals(2));
        expect(exit[1].length, equals(2));
        expect(exit[0][0], domEquals(span[0][0]));
        expect(exit[0][1], domNull);
        expect(exit[1][0], domEquals(span[1][0]));
        expect(exit[1][1], domNull);
      });
      test('handles keys that are in the default object\'s prototype chain', () {
        // This also applies to the non-standard 'watch' and 'unwatch' in Mozilla Firefox.
        var update = span.data(['hasOwnProperty', 'isPrototypeOf', 'toLocaleString', 'toString', 'valueOf'], String);
        expect(update[0][0], domNull);
        expect(update[0][1], domNull);
        expect(update[0][2], domNull);
        expect(update[0][3], domNull);
        expect(update[0][4], domNull);
        // This throws an error if Object.hasOwnProperty isn't used.
        span.data([0], () { return 'hasOwnProperty'; });
      });
    });
  });
}