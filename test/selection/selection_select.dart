import 'package:unittest/unittest.dart';

import '../../src/selection/selection.dart' as d4;

void main() {
  group('select(body)', () {
    group('on a simple page', () {
      Selection body = d4.select('body');
      body.append('div').attr('class', 'first');
      body.append('div').attr('class', 'second');
      test('selects the first matching element', () {
        var div = body.select('div');
        expect(div[0][0], same(body.node().firstChild));
        expect(div.length, equals(1));
        expect(div[0].length, equals(1));
        expect(div.attr('class'), equals('first'));
      });
      test('propagates parent node to the selected elements', () {
        var div = body.select('div');
        expect(div[0].parentNode, isNotNull);
        expect(div[0].parentNode, same(body.node().parentNode));
        expect(div[0].parentNode, same(body[0].parentNode));
      });
      test('propagates data to the selected elements', () {
        var data = new Object(), div = body.data([data]).select('div');
        expect(div[0][0].__data__, same(data));
      });
      test('does not propagate data if no data was specified', () {
        body.node().attributes.remove('__data__');
        var data = new Object(), div = body.select('div').data([data]);
        div = body.select('div');
        expect(div[0][0].__data__, same(data));
        expect(body.node().__data__, isNull/*isUndefined*/);
      });
      test('returns null if no match is found', () {
        var span = body.select('span');
        expect(span[0][0], isNull);
        expect(span.length, equals(1));
        expect(span[0].length, equals(1));
      });
      test('can select via function', () {
        body.append('foo');
        var d = {}, dd = [], ii = [], tt = [];
        var s = body.data([d]).select((d, i) {
          dd.push(d); ii.push(i); tt.push(this); return this.firstChild;
        });
        expect(dd, equals([d]), 'expected data, got {actual}');
        expect(ii, equals([0]), 'expected index, got {actual}');
        expect(tt[0], domEquals(body.node()), 'expected this, got {actual}');
        expect(s[0][0], domEquals(body.node().firstChild));
        body.node().attributes.remove('__data__');
      });
    });
  });

  group('selectAll(div)', () {
    var d3 = load('selection/selection').document();
    group('on a simple page', () {
      var div = d3.select('body').selectAll('div').data([0, 1]).enter().append('div');
      div.append('span').attr('class', 'first');
      div.append('span').attr('class', 'second');
      test('selects the first matching element', () {
        var span = div.select('span');
        expect(span[0][0].parentNode, same(div[0][0]));
        expect(span[0][1].parentNode, same(div[0][1]));
        expect(span.length, equals(1));
        expect(span[0].length, equals(2));
        expect(span.attr('class'), equals('first'));
      });
      test('propagates parent node to the selected elements', () {
        var span = div.select('span');
        expect(span[0].parentNode, isNotNull);
        expect(span[0].parentNode, same(div.node().parentNode));
        expect(span[0].parentNode, same(div[0].parentNode));
      });
      test('propagates data to the selected elements', () {
        var data = new Object(), span = div.data([data]).select('span');
        expect(span[0][0].__data__, same(data));
      });
      test('does not propagate data if no data was specified', () {
        div[0][0].attributes.remove('__data__');
        div[0][1].attributes.remove('__data__');
        var a = new Object(), b = new Object();
        var span = div.select('span').data([a, b]);
        span = div.select('span');
        expect(span[0][0].attributes['__data__'], same(a));
        expect(span[0][1].attributes['__data__'], same(b));
        expect(div[0][0].attributes['__data__'], isNull/*isUndefined*/);
        expect(div[0][1].attributes['__data__'], isNull/*isUndefined*/);
      });
      test('returns null if no match is found', () {
        var div2 = div.select('div');
        expect(div2[0][0], isNull);
        expect(div2[0][1], isNull);
        expect(div2.length, equals(1));
        expect(div2[0].length, equals(2));
      });
      test('can select via function', () {
        var dd = [], ii = [], tt = [];
        var s = div.data(['a', 'b']).select((d, i) {
          dd.push(d); ii.push(i); tt.push(this);
          return this.firstChild;
        });
        expect(dd, equals(['a', 'b']), 'expected data, got {actual}');
        expect(ii, equals([0, 1]), 'expected index, got {actual}');
        expect(tt[0], domEquals(div[0][0]), 'expected this, got {actual}');
        expect(tt[1], domEquals(div[0][1]), 'expected this, got {actual}');
        expect(s[0][0], domEquals(div[0][0].firstChild));
        expect(s[0][1], domEquals(div[0][1].firstChild));
      });
      test('ignores null nodes', () {
        div[0][1] = null;
        var span = div.select('span');
        expect(span.length, equals(1));
        expect(span[0].length, equals(2));
        expect(span[0][0].parentNode, same(div[0][0]));
        expect(span[0][1], isNull);
      });
    });
  });
}