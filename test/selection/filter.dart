import 'package:unittest/unittest.dart';

import '../../src/selection/selection.dart' as d4;

void main() {
  group('select(body)', () {
    var d3 = load('selection/filter').document();
    group('on a simple page', () {
      var span = d3.select('body').selectAll('div')
          .data([0, 1])
        .enter().append('div')
        .selectAll('span')
          .data((d) { d <<= 1; return [d, d + 1]; })
        .enter().append('span');
      test('preserves matching elements', () {
        var some = span.filter((d, i) { return i == 0; });
        expect(some[0][0], same(span[0][0]));
        expect(some[1][0], same(span[1][0]));
      });
      test('removes non-matching elements', () {
        var some = _.merge(span.filter((d, i) { return d & 1; }));
        expect(some.indexOf(span[0][0]), equals(-1));
        expect(some.indexOf(span[1][0]), equals(-1));
      });
      test('preserves data', () {
        var some = span.filter((d, i) { return d & 1; });
        expect(some[0][0].__data__, equals(1));
        expect(some[1][0].__data__, equals(3));
      });
      test('preserves grouping', () {
        var some = span.filter((d, i) { return d & 1; });
        expect(some.length, equals(2));
        expect(some[0].length, equals(1));
        expect(some[1].length, equals(1));
      });
      test('preserves parent node', () {
        var some = span.filter((d, i) { return d & 1; });
        expect(some[0].parentNode, same(span[0].parentNode));
        expect(some[1].parentNode, same(span[1].parentNode));
      });
      test('does not preserve index', () {
        var indexes = [];
        span.filter((d, i) { return d & 1; }).each((d, i) { indexes.push(i); });
        expect(indexes, equals([0, 0]));
      });
      test('can be specified as a selector', () {
        span.classed('foo', (d, i) { return d & 1; });
        var some = span.filter('.foo');
        expect(some.length, equals(2));
        expect(some[0].length, equals(1));
        expect(some[1].length, equals(1));
      });
      test('returns a new selection', () {
        expect(span.filter(() { return 1; }) ==/*=*/ span, isFalse);
      });
      test('ignores null nodes', () {
        var node = span[0][1];
        span[0][1] = null;
        var some = span.filter((d, i) { return d & 1; });
        expect(some[0][0], same(span[0][3]));
        expect(some.length, equals(2));
      });
    });
  });
}
