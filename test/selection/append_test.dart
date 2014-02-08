import 'package:unittest/unittest.dart';
import 'package:unittest/html_enhanced_config.dart';
import 'package:d3/selection/selection.dart';

main() {
  useHtmlEnhancedConfiguration();

  group('select(body)', () {
    group('on a simple page', () {
      final Selection body = new Selection.fromSelector('body');
      test('appends an HTML element', () {
        var div = body.append('div');
        expect(div[0][0].tagName, equals('DIV'));
        expect(div[0][0].namespaceUri, equals('http://www.w3.org/1999/xhtml')/*isNull*/);
        expect(div[0][0].parentNode == body.node, isTrue);
        expect(div[0][0] == body.node.lastChild, isTrue);
      });
      test('appends an SVG element', () {
        var svg = body.append('svg:svg');
        expect(svg[0][0].tagName, equals('svg')/*equals('SVG')*/);
        expect(svg[0][0].namespaceUri, equals('http://www.w3.org/2000/svg'));
        expect(svg[0][0].parentNode, same(body.node));
        expect(svg[0][0], same(body.node.lastChild));
      });
      test('appends an element specified as a function', () {
        var svg = body.select('svg').remove().node;
        //expect(svg, same(body.node.lastChild));
        body.appendFunc((n, d, i, j) { return svg; });
        expect(svg, same(body.node.lastChild));
      });
      /*test('propagates data to new element', () {
        var data = new Object();
        var div = body.data([data]).append('div');
        expect(div[0][0].attributes['__data__'], equals(data));
      });*/
      test('returns a new selection', () {
        expect(body.append('div') ==/*=*/ body, isFalse);
      });
      test('inherits namespace from parent node', () {
        var g = body.append('svg:svg').append('g');
        expect(g[0][0].namespaceUri, equals('http://www.w3.org/2000/svg'));
      });
    });
  });
}