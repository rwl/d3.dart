import 'package:unittest/unittest.dart';
import 'package:unittest/html_enhanced_config.dart';
import 'package:d3/selection/selection.dart';

main() {
  useHtmlEnhancedConfiguration();

  group('select(body)', () {
    group('on a simple page', () {
      final Selection body = new Selection.fromSelector('body');
      test('sets an attribute as a string', () {
        body.attr('bgcolor', 'red');
        expect(body.node.getAttribute('bgcolor'), equals('red'));
      });
      test('sets an attribute as a number', () {
        body.attr('opacity', 1);
        expect(body.node.getAttribute('opacity'), equals('1'));
      });
      test('sets an attribute as a function', () {
        body.attrFunc('bgcolor', (node, data, i, j) { return 'orange'; });
        expect(body.node.getAttribute('bgcolor'), equals('orange'));
      });
      /*test('sets an attribute as a function of data', () {
        body.data(['cyan']).attr('bgcolor', String);
        expect(body.node.getAttribute('bgcolor'), equals('cyan'));
      });*/
      test('sets an attribute as a function of index', () {
        body.attrFunc('bgcolor', (node, data, i, j) { return 'orange-$i'; });
        expect(body.node.getAttribute('bgcolor'), equals('orange-0'));
      });
      test('sets a namespaced attribute as a string', () {
        body.attr('xlink:href', 'url');
        expect(body.node.getAttributeNS('http://www.w3.org/1999/xlink', 'href'), equals('url'));
      });
      /*test('sets a namespaced attribute as a function', () {
        body.data(['orange']).attr('xlink:href', (node, data, i) { return '$data-$i'; });
        expect(body.node.getAttributeNS('http://www.w3.org/1999/xlink', 'href'), equals('orange-0'));
      });*/
      test('sets attributes as a map of constants', () {
        body.attrMap({'bgcolor': 'white', 'xlink:href': 'url.png'});
        expect(body.node.getAttribute('bgcolor'), equals('white'));
        expect(body.node.getAttributeNS('http://www.w3.org/1999/xlink', 'href'), equals('url.png'));
      });
      /*test('sets attributes as a map of functions', () {
        body.data(['orange']).attr({'xlink:href': (node, data, i) { return '$data-$i.png'; }});
        expect(body.node.getAttributeNS('http://www.w3.org/1999/xlink', 'href'), equals('orange-0.png'));
      });*/
      test('gets an attribute value', () {
        body.node.setAttribute('bgcolor', 'yellow');
        expect(body.nodeAttr('bgcolor'), equals('yellow'));
      });
      test('gets a namespaced attribute value', () {
        body.node.setAttributeNS('http://www.w3.org/1999/xlink', 'foo', 'bar');
        expect(body.nodeAttr('xlink:foo'), equals('bar'));
      });
      test('removes an attribute as null', () {
        body..attr('bgcolor', 'red')..attrNull('bgcolor');
        expect(body.nodeAttr('bgcolor'), isNull);
      });
      test('removes an attribute as null', () {
        body..attr('bgcolor', 'red')..attr('bgcolor', null);
        expect(body.nodeAttr('bgcolor'), isNull);
      });
      test('removes an attribute as a function', () {
        body..attr('bgcolor', 'red')..attrFunc('bgcolor',
            (n, d, i, j) { return null; });
        expect(body.nodeAttr('bgcolor'), isNull);
      });
      test('removes a namespaced attribute as null', () {
        body..attr('xlink:href', 'url')..attr('xlink:href', null);
        expect(body.nodeAttr('bgcolor'), isNull);
      });
      test('removes a namespaced attribute as a function', () {
        body..attr('xlink:href', 'url')..attrFunc('xlink:href', (n, d, i, j) { return null; });
        expect(body.nodeAttr('xlink:href'), isNull);
      });
      test('removes attributes as a map of null', () {
        body.node.setAttribute('bgcolor', 'white');
        body.node.setAttributeNS('http://www.w3.org/1999/xlink', 'href', 'foo.png');
        body.attrMap({'bgcolor': null, 'xlink:href': null});
        expect(body.node.getAttribute('bgcolor'), isNull);
        expect(body.node.getAttributeNS('http://www.w3.org/1999/xlink', 'href'), equals('')/*isNull*/);
      });
      /*test('removes attributes as a map of functions that return null', () {
        body.node.setAttribute('bgcolor', 'white');
        body.node.setAttributeNS('http://www.w3.org/1999/xlink', 'href', 'foo.png');
        body.attr({'bgcolor': () {}, 'xlink:href': () {}});
        expect(body.node.getAttribute('bgcolor'), isNull);
        expect(body.node.getAttributeNS('http://www.w3.org/1999/xlink', 'href'), isNull);
      });
      test('returns the current selection', () {
        expect(body.attr('foo', 'bar'), same(body));
      });*/
    });
  });
}