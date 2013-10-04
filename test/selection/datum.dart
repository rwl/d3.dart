import 'package:unittest/unittest.dart';

import '../../src/selection/selection.dart' as d4;

void main() {
  group('select(body)', () {
    group('on a simple page', () {
      Selection body = d4.select('body');
      test('updates the data according to the specified function', () {
        body.data([42]).datum((d, i) { return d + i; });
        expect(body.node().__data__, equals(42));
      });
      test('updates the data to the specified constant', () {
        body.datum(43);
        expect(body.node().__data__, equals(43));
      });
      test('deletes the data if the function returns null', () {
        body.data([42]).datum(() { return null; });
        expect(body.node().containsKey('__data__'), isFalse);
      });
      test('deletes the data if the constant is null', () {
        body.data([42]).datum(null);
        expect(body.node().containsKey('__data__'), isFalse);
      });
      test('returns the current selection', () {
        expect(body.datum(() { return 1; }), same(body));
        expect(body.datum(2), same(body));
      });
      test('with no arguments, returns the first node\'s datum', () {
        body.data([42]);
        expect(body.datum(), equals(42));
      });
    });
  });

  group('selectAll(div)', () {
    var d3 = load('selection/datum').document();
    group('on a simple page', () {
      var div =  d3.select('body').selectAll('div').data([0, 1]).enter().append('div');
      test('updates the data according to the specified function', () {
        div.data([42, 43]).datum((d, i) { return d + i; });
        expect(div[0][0].__data__, equals(42));
        expect(div[0][1].__data__, equals(44));
      });
      test('updates the data to the specified constant', () {
        div.datum(44);
        expect(div[0][0].__data__, equals(44));
        expect(div[0][1].__data__, equals(44));
      });
      test('deletes the data if the function returns null', () {
        div.datum(() { return null; });
        expect(div[0][0].containsKey('__data__'), isFalse);
        expect(div[0][1].containsKey('__data__'), isFalse);
      });
      test('deletes the data if the constant is null', () {
        div.datum(null);
        expect(div[0][0].containsKey('__data__'), isFalse);
        expect(div[0][1].containsKey('__data__'), isFalse);
      });
      test('returns the current selection', () {
        expect(div.datum(() { return 1; }), same(div));
        expect(div.datum(2), same(div));
      });
      test('ignores null nodes', () {
        var node = div[0][1];
        div[0][1] = null;
        div.datum(() { return 1; });
        expect(div[0][0].__data__, equals(1));
        expect(node.__data__, equals(2));
        div.datum(43);
        expect(div[0][0].__data__, equals(43));
        expect(node.__data__, equals(2));
      });
    });
  });
}