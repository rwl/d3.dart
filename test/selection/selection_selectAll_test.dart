import 'package:test/test.dart';
import 'package:d3/d3.dart' as d3;

main() {
  group('select(body)', () {
    group('on a simple page', () {
      d3.Selection body = d3.select('body');
      body.append('div').attr('class', 'first');
      body.append('div').attr('class', 'second');
      test('selects all matching elements', () {
        var div = body.selectAll('div');
//        expect(div[0][0], same(body.node().firstChild));
//        expect(div[0][1], same(body.node().lastChild));
        expect(div.length, equals(1));
        expect(div[0].length, equals(2));
      });
      test('propagates parent node to the selected elements', () {
        var div = body.selectAll('div');
        expect(div[0]['parentNode'], isNotNull);
        expect(div[0]['parentNode'], same(body.node));
      });
//      test('does not propagate data if data was specified', () {
//        var div = body.data([new Object()]).selectAll('div');
//        expect(nodeData(div[0][0]), isNull);
//        expect(nodeData(div[0][1]), isNull);
//      });
//      test('does not propagate data if data was not specified', () {
//        var div = body.selectAll('div').data([1, 2]);
//        div = body.data([new Object()]).selectAll('div');
//        expect(nodeData(div[0][0]), equals(1));
//        expect(nodeData(div[0][1]), equals(2));
//      });
      test('returns empty array if no match is found', () {
        var span = body.selectAll('span');
        expect(span.length, equals(1));
        expect(span[0].length, equals(0));
      });
      test('can select via function', () {
        var d = {}, dd = [], ii = [], tt = [];
        var s = body.data([d]).selectAll((node, data, i, j) {
          dd.add(data);
          ii.add(i);
          tt.add(node);
          return node.childNodes;
        });
        expect(dd, equals([d]));
        expect(ii, equals([0]));
        expect(tt[0], equals(body.node));
        expect(s[0][0], equals(body.node().firstChild));
        expect(s[0][1], equals(body.node().lastChild));
//        dataProp[body.node] = null;
      });
    });
  });
}
