import 'package:unittest/unittest.dart';

var datum = {};

void main() {
  var span = () {
    return d3.select('body').html('').selectAll('div')
        .data([0, 1])
      .enter().append('div')
      .selectAll('span')
        .data((d) { d <<= 1; return [d, d + 1]; })
      .enter().append('span')
        .classed('foo', (d, i) { return d & 1; })
      .transition()
        .delay(100)
        .duration(150)
        .ease('bounce');
  };

  test('preserves matching elements', () {
    var some = span.filter((d, i) { return i == 0; });
    expect(some[0][0] == span[0][0], isTrue);
    expect(some[1][0] == span[1][0], isTrue);
  });
  test('removes non-matching elements', () {
    var some = _.merge(span.filter(function(d, i) { return d & 1; }));
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
    expect(some[0].parentNode == span[0].parentNode, isTrue);
    expect(some[1].parentNode == span[1].parentNode, isTrue);
  });
  test('does not preserve index', () {
    var indexes = [];
    span.filter((d, i) { return d & 1; }).each((d, i) { indexes.push(i); });
    expect(indexes, equals([0, 0]));
  });
  test('ignores null nodes', () {
    var node = span[0][1];
    span[0][1] = null;
    var some = span.filter((d, i) { return d & 1; });
    expect(some[0][0] == span[0][3], isTrue);
    expect(some.length, equals(2));
    span[0][1] = node;
  });
  test('can be specified as a selector', () {
    var some = span.filter('.foo');
    expect(some.length, equals(2));
    expect(some[0].length, equals(1));
    expect(some[1].length, equals(1));
  });
  test('returns a new selection', () {
    expect(span.filter(() { return 1; }) == span, isFalse);
  });
  test('works on empty selections', () {
    var none = () { return false; },
        empty = span.filter(none);
    expect(empty.empty(), isTrue);
    expect(empty.filter(none).empty(), isTrue);
  });
  test('inherits the transition id and, by extension, all transition parameters', (t1) {
    var t2 = t1.filter(() { return 1; });
    expect(t2.id, equals(t1.id));
    expect(t2[0][0].__transition__[t2.id], same(t1[0][0].__transition__[t1.id]));
  });
}
