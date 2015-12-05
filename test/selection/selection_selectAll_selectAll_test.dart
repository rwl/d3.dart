import 'package:test/test.dart';
import 'package:d3/d3.dart' as d3;

main() {
  group('selectAll(div)', () {
    group('on a simple page', () {
      var div =
          d3.select('body').selectAll('div').data([0, 1]).enter().append('div');
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
        expect(span[0]['parentNode'], isNotNull);
        expect(span[0]['parentNode'], same(div[0][0]));
        expect(span[1]['parentNode'], same(div[0][1]));
      });
//      test('does not propagate data if data was specified', () {
//        var span = div.selectAll('span');
//        dataProp[span[0][0]] = null;
//        dataProp[span[0][1]] = null;
//        span = div.data([new Object(), new Object()]).selectAll('span');
//        expect(nodeData(span[0][0]), isNull);
//        expect(nodeData(span[0][1]), isNull);
//      });
//      test('does not propagate data if data was not specified', () {
//        var a = new Object(),
//            b = new Object(),
//            span = div.selectAll('span').data([a, b]);
//        dataProp[div[0][0]] = null;
//        dataProp[div[0][1]] = null;
//        span = div.selectAll('span');
//        expect(nodeData(span[0][0]), equals(a));
//        expect(nodeData(span[0][1]), equals(b));
//      });
      test('returns empty array if no match is found', () {
        var div2 = div.selectAll('div');
        expect(div2.length, equals(2));
        expect(div2[0].length, equals(0));
        expect(div2[1].length, equals(0));
      });
      test('can select via function', () {
        var dd = [], ii = [], tt = [];
        var s = div.data(['a', 'b']).selectAll((node, d, i, j) {
          dd.add(d);
          ii.add(i);
          tt.add(node);
          return node.childNodes;
        });
        expect(dd, equals(['a', 'b']));
        expect(ii, equals([0, 1]));
        expect(tt[0], equals(div[0][0]));
        expect(tt[1], equals(div[0][1]));
        expect(s[0][0], equals(div[0][0].firstChild));
        expect(s[0][1], equals(div[0][0].lastChild));
        expect(s[1][0], equals(div[0][1].firstChild));
        expect(s[1][1], equals(div[0][1].lastChild));
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
