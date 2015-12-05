import 'package:test/test.dart';
import 'package:d3/d3.dart' as d3;

main() {
  group('select(body)', () {
    group('on a simple page', () {
      d3.Selection body = d3.select('body');

      body.append('div').attr('class', 'first');
      body.append('div').attr('class', 'second');
      test('selects the first matching element', () {
        var div = body.select('div');
        expect(div[0][0], same(body.node().firstChild));
        expect(div.length, equals(1));
        expect(div[0].length, equals(1));
//        expect(div['attr']('class'), equals('first'));
      });
      test('propagates parent node to the selected elements', () {
        var div = body.select('div');
        expect(div[0]['parentNode'], isNotNull);
        expect(div[0]['parentNode'], same(body.node().parentNode));
        expect(div[0]['parentNode'], same(body[0]['parentNode']));
      });
//      test('propagates data to the selected elements', () {
//        var data = new Object();
//        var div = body.data([data]).select('div');
//        expect(div[0][0]['__data__'], same(data));
//      });
//      test('does not propagate data if no data was specified', () {
//        body.node()['__data__'] = null;
//        var data = new Object();
//        var div = body.select('div').data([data]);
//        div = body.select('div');
//        expect(div[0][0]['__data__'], same(data));
//        expect(body.node()['__data__'], isNull);
//      });
      test('returns null if no match is found', () {
        var span = body.select('span');
        expect(span[0][0], isNull);
        expect(span.length, equals(1));
        expect(span[0].length, equals(1));
      });
      test('can select via function', () {
        body.append('foo');
        var d = {}, dd = [], ii = [], tt = [];
        var s = body.data([d]).select((node, d, i, j) {
          dd.add(d);
          ii.add(i);
          tt.add(node);
          return node.firstChild;
        });
        expect(dd, equals([d]));
        expect(ii, equals([0]));
        expect(tt[0], equals(body.node()));
        expect(s[0][0], equals(body.node().firstChild));
//        dataProp[body.node] = null;
      });
    });
  });
}
