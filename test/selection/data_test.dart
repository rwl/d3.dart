import 'package:test/test.dart';
import 'package:d3/js/d3.dart';

import '../util.dart';

main() {
  group('select(body)', () {
    group('on a simple page', () {
      final Selection body = select('body');

      test('assigns data as an array', () {
        var data = new Object();
        body.data([data]);
        expect(nodeData(body.node()), same(data));
      });
      test('assigns data as a function', () {
        var data = new Object();
        body.data(() {
          return [data];
        });
        expect(nodeData(body.node()), same(data));
      });
      test('stores data in the DOM', () {
        var expected = new Object(), actual;
        setNodeData(body.node(), expected);
        body.each((d) {
          actual = d;
        });
        expect(actual, same(expected));
      });
      test('returns a new selection', () {
        expect(body.data([1]) == body, isFalse);
      });
      test('with no arguments, returns an array of data', () {
        var data = new Object();
        body.data([data]);
        expect(body.data(), equals([data]));
        expect(body.data()[0], same(data));
      });
//      test('throws an error if data is null', () {
//        var errored = false;
//        try {
//          body.data(null);
//        } catch (e) {
//          errored = true;
//        }
//        expect(errored, isTrue);
//      });
//      test('throws an error if data is a function that returns null', () {
//        var errored = false;
//        try {
//          body.data(() {});
//        } catch (e) {
//          errored = true;
//        }
//        expect(errored, isTrue);
//      });
    });
  });

//  group('selectAll(div)', () {
//    group('on a simple page', () {
//      final Selection div =
//          select('body').selectAll('div').data([0, 1]).enter().append('div');
//      test('assigns data as an array', () {
//        var a = new Object(), b = new Object();
//        div.data([a, b]);
//        expect(nodeData(div[0][0]), same(a));
//        expect(nodeData(div[0][1]), same(b));
//      });
//      test('assigns data as a function', () {
//        var a = new Object(), b = new Object();
//        div.data(() {
//          return [a, b];
//        });
//        expect(nodeData(div[0][0]), same(a));
//        expect(nodeData(div[0][1]), same(b));
//      });
//      test('stores data in the DOM', () {
//        var a = new Object(), b = new Object(), actual = [];
//        setNodeData(div[0][0], a);
//        setNodeData(div[0][1], b);
//        div.each((n, d, i, j) {
//          actual.add(d);
//        });
//        expect(actual, equals([a, b]));
//      });
//      test('returns a new selection', () {
//        expect(div.data([0, 1]) == div, isFalse);
//      });
//      test('throws an error if data is null', () {
//        var errored;
//        try {
//          div.data(null);
//        } catch (e) {
//          errored = true;
//        }
//        expect(errored, isTrue);
//      });
//      test('throws an error if data is a function that returns null', () {
//        var errored;
//        try {
//          div.data(() {});
//        } catch (e) {
//          errored = true;
//        }
//        expect(errored, isTrue);
//      });
//      test('with no arguments, returns an array of data', () {
//        var a = new Object(), b = new Object();
////        var actual = [];
//        setNodeData(div[0][0], a);
//        setNodeData(div[0][1], b);
//        expect(div.data(), equals([a, b]));
//      });
//      /*test('with no arguments, returned array has undefined for null nodes', () {
//        var b = new Object(), actual = [];
//        nodeData(div[0][0], null);
//        nodeData(div[0][1], b);
//        var data = div.data();
//        expect(data[0], isNull/*isUndefined*/);
//        expect(data[1], same(b));
//        expect(data.length, equals(2));
//      });*/
//    });
//  });
}
