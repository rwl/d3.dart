import 'package:unittest/unittest.dart';

import '../../src/selection/selection.dart' as d4;

void main() {
  group('select(body)', () {
    group('on a simple page', () {
      Selection body = d4.select('body');
      test('calls the function once per element', () {
        var count = 0;
        body.each(() { ++count; });
        expect(count, equals(1));
      });
      test('passes the data and index to the function', () {
        var data = new Object(), dd, ii;
        body.data([data]).each((d, i) { dd = d; ii = i; });
        expect(dd, same(data));
        expect(ii, same(0));
      });
      test('uses the node as the context', () {
        var node;
        body.each(() { node = this; });
        expect(node, same(body.node()));
      });
      test('returns the same selection', () {
        expect(body.each(() {}), same(body));
      });
      test('returns the current selection', () {
        expect(body.each(() {}), same(body));
      });
      test('ignores null nodes', () {
        var count = 0;
        body[0][0] = null;
        body.each(() { ++count; });
        expect(count, equals(0));
      });
    });
  });

  group('selectAll(div)', () {
    var d3 = load('selection/each').document();
    group('on a simple page', () {
      var div =  d3.select('body').selectAll('div').data([0, 1]).enter().append('div');
      test('calls the function once per element', () {
        var count = 0;
        div.each(() { ++count; });
        expect(count, equals(2));
      });
      test('passes the data and index to the function', () {
        var data = [new Object(), new Object()], dd = [], ii = [];
        div.data(data).each((d, i) { dd.push(d); ii.push(i); });
        expect(dd, equals(data));
        expect(ii, equals([0, 1]));
      });
      test('uses the node as the context', () {
        var nodes = [];
        div.each(() { nodes.push(this); });
        expect(nodes.length, equals(2));
        expect(div[0][0] == nodes[0], isTrue);
        expect(div[0][1] == nodes[1], isTrue);
      });
      test('returns the same selection', () {
        expect(div.each(() {}), same(div));
      });
      test('returns the current selection', () {
        expect(div.each(() {}), same(div));
      });
      test('ignores null nodes', () {
        var count = 0;
        div[0][0] = null;
        div.each(() { ++count; });
        expect(count, equals(1));
      });
    });
  });
}
