import 'package:unittest/unittest.dart';

import '../../src/selection/selection.dart' as d4;

void main() {
  group('select(body)', () {
    group('on a simple page', () {
      Selection body = d4.select('body');
      body.append('div').attr('class', 'first');
      body.append('div').attr('class', 'second');
      test('selects all matching elements', () {
        var div = body.selectAll('div');
        expect(div[0][0], same(body.node().firstChild));
        expect(div[0][1], same(body.node().lastChild));
        expect(div.length, equals(1));
        expect(div[0].length, equals(2));
      });
      test('propagates parent node to the selected elements', () {
        var div = body.selectAll('div');
        expect(div[0].parentNode, isNotNull);
        expect(div[0].parentNode, same(body.node()));
      });
      test('does not propagate data if data was specified', () {
        var div = body.data([new Object()]).selectAll('div');
        expect(div[0][0].attributes['__data__'], isNull/*isUndefined*/);
        expect(div[0][1].attributes['__data__'], isNull/*isUndefined*/);
      });
      test('does not propagate data if data was not specified', () {
        var div = body.selectAll('div').data([1, 2]);
        div = body.data([new Object()]).selectAll('div');
        expect(div[0][0].attributes['__data__'], equals(1));
        expect(div[0][1].attributes['__data__'], equals(2));
      });
      test('returns empty array if no match is found', () {
        var span = body.selectAll('span');
        expect(span.length, equals(1));
        expect(span[0].length, equals(0));
      });
      test('can select via function', () {
        var d = {}, dd = [], ii = [], tt = [];
        var s = body.data([d]).selectAll((d, i) {
          dd.push(d); ii.push(i); tt.push(this);
          return this.childNodes;
        });
        expect(dd, equals([d]), 'expected data, got {actual}');
        expect(ii, equals([0]), 'expected index, got {actual}');
        expect(tt[0], domEquals(body.node()), 'expected this, got {actual}');
        expect(s[0][0], domEquals(body.node().firstChild));
        expect(s[0][1], domEquals(body.node().lastChild));
        body.node().attributes.remove(__data__);
      });
    });
  });

  group('selectAll(div)', () {
    var d3 = load('selection/selection').document();
    group('on a simple page', () {
      var div = d3.select('body').selectAll('div').data([0, 1]).enter().append('div');
      div.append('span').attr('class', 'first');
      div.append('span').attr('class', 'second');
      test('selects all matching elements', () {
        var span = div.selectAll('span');
        expect(span.length, equals(2));
        expect(span[0].length, equals(2));
        expect(span[0][0].parentNode, same(div[0][0]));
        expect(span[0][1].parentNode, same(div[0][0]));
        expect(span[1][0].parentNode, same(div[0][1]));
        expect(span[1][1].parentNode, same(div[0][1]));
      });
      test('propagates parent node to the selected elements', () {
        var span = div.selectAll('span');
        expect(span[0].parentNode, isNotNull);
        expect(span[0].parentNode, same(div[0][0]));
        expect(span[1].parentNode, same(div[0][1]));
      });
      test('does not propagate data if data was specified', () {
        var span = div.selectAll('span');
        span[0][0].attributes.remove('__data__');
        span[0][1].attributes.remove('__data__');
        span = div.data([new Object(), new Object()]).selectAll('span');
        expect(span[0][0].attributes['__data__'], isNull/*isUndefined*/);
        expect(span[0][1].attributes['__data__'], isNull/*isUndefined*/);
      });
      test('does not propagate data if data was not specified', () {
        var a = new Object(), b = new Object(), span = div.selectAll('span').data([a, b]);
        div[0][0].attributes.remove('__data__');
        div[0][1].attributes.remove('__data__');
        span = div.selectAll('span');
        expect(span[0][0].attributes['__data__'], equals(a));
        expect(span[0][1].attributes['__data__'], equals(b));
      });
      test('returns empty array if no match is found', () {
        var div = div.selectAll('div');
        expect(div.length, equals(2));
        expect(div[0].length, equals(0));
        expect(div[1].length, equals(0));
      });
      test('can select via function', () {
        var dd = [], ii = [], tt = [];
        var s = div.data(['a', 'b']).selectAll((d, i) {
          dd.push(d); ii.push(i); tt.push(this);
          return this.childNodes;
        });
        expect(dd, equals(['a', 'b']), 'expected data, got {actual}');
        expect(ii, equals([0, 1]), 'expected index, got {actual}');
        expect(tt[0], domEquals(div[0][0]), 'expected this, got {actual}');
        expect(tt[1], domEquals(div[0][1]), 'expected this, got {actual}');
        expect(s[0][0], domEquals(div[0][0].firstChild));
        expect(s[0][1], domEquals(div[0][0].lastChild));
        expect(s[1][0], domEquals(div[0][1].firstChild));
        expect(s[1][1], domEquals(div[0][1].lastChild));
      });
      test('ignores null nodes', () {
        var node = div[0][1];
        div[0][1] = null;
        var span = div.selectAll('span');
        expect(span.length, equals(1));
        expect(span[0].length, equals(2));
        expect(span[0][0].parentNode, same(div[0][0]));
        expect(span[0][1].parentNode, same(div[0][0]));
      });
    });
  });
}
