import 'package:test/test.dart';
import 'package:d3/js/d3.dart';

main() {
  group('select(body)', () {
    group('on a simple page', () {
      final Selection body = select('body');
      test('sets an attribute as a string', () {
        body.attr('bgcolor', 'red');
        expect(body.node().getAttribute('bgcolor'), equals('red'));
      });
      test('sets an attribute as a number', () {
        body.attr('opacity', 1);
        expect(body.node().getAttribute('opacity'), equals('1'));
      });
      test('sets an attribute as a function', () {
        body.attr('bgcolor', () {
          return 'orange';
        });
        expect(body.node().getAttribute('bgcolor'), equals('orange'));
      });
      test('sets an attribute as a function of data', () {
        body.data(['cyan']).attr('bgcolor', (d) => d.toString());
        expect(body.node().getAttribute('bgcolor'), equals('cyan'));
      });
      test('sets an attribute as a function of index', () {
        body.attr('bgcolor', (data, i) {
          return 'orange-$i';
        });
        expect(body.node().getAttribute('bgcolor'), equals('orange-0'));
      });
      test('sets a namespaced attribute as a string', () {
        body.attr('xlink:href', 'url');
        expect(
            body.node().getAttributeNS('http://www.w3.org/1999/xlink', 'href'),
            equals('url'));
      });
      test('sets a namespaced attribute as a function', () {
        body.data(['orange']).attr('xlink:href', (data, i) {
          return '$data-$i';
        });
        expect(
            body.node().getAttributeNS('http://www.w3.org/1999/xlink', 'href'),
            equals('orange-0'));
      });
      test('sets attributes as a map of constants', () {
        body.attr({'bgcolor': 'white', 'xlink:href': 'url.png'});
        expect(body.node().getAttribute('bgcolor'), equals('white'));
        expect(
            body.node().getAttributeNS('http://www.w3.org/1999/xlink', 'href'),
            equals('url.png'));
      });
      test('sets attributes as a map of functions', () {
        body.data(['orange']).attr({
          'xlink:href': (data, i, j) {
            return '$data-$i.png';
          }
        });
        expect(
            body.node().getAttributeNS('http://www.w3.org/1999/xlink', 'href'),
            equals('orange-0.png'));
      });
      test('gets an attribute value', () {
        body.node().setAttribute('bgcolor', 'yellow');
        expect(body.attr('bgcolor'), equals('yellow'));
      });
      test('gets a namespaced attribute value', () {
        body
            .node()
            .setAttributeNS('http://www.w3.org/1999/xlink', 'foo', 'bar');
        expect(body.attr('xlink:foo'), equals('bar'));
      });
      test('removes an attribute as null', () {
        body..attr('bgcolor', 'red')..attr('bgcolor', null);
        expect(body.attr('bgcolor'), isNull);
      });
      test('removes an attribute as null', () {
        body..attr('bgcolor', 'red')..attr('bgcolor', null);
        expect(body.attr('bgcolor'), isNull);
      });
      test('removes an attribute as a function', () {
        body
          ..attr('bgcolor', 'red')
          ..attr('bgcolor', () {
            return null;
          });
        expect(body.attr('bgcolor'), isNull);
      });
      test('removes a namespaced attribute as null', () {
        body..attr('xlink:href', 'url')..attr('xlink:href', null);
        expect(body.attr('bgcolor'), isNull);
      });
      test('removes a namespaced attribute as a function', () {
        body
          ..attr('xlink:href', 'url')
          ..attr('xlink:href', () {
            return null;
          });
        expect(body.attr('xlink:href'), isNull);
      });
      test('removes attributes as a map of null', () {
        body.node().setAttribute('bgcolor', 'white');
        body
            .node()
            .setAttributeNS('http://www.w3.org/1999/xlink', 'href', 'foo.png');
        body.attr({'bgcolor': null, 'xlink:href': null});
        expect(body.node().getAttribute('bgcolor'), isNull);
        expect(
            body.node().getAttributeNS('http://www.w3.org/1999/xlink', 'href'),
            isNull);
      });
      test('removes attributes as a map of functions that return null', () {
        body.node().setAttribute('bgcolor', 'white');
        body
            .node()
            .setAttributeNS('http://www.w3.org/1999/xlink', 'href', 'foo.png');
        body.attr({'bgcolor': (d, i, j) {}, 'xlink:href': (d, i, j) {}});
        expect(body.node().getAttribute('bgcolor'), isNull);
        expect(
            body.node().getAttributeNS('http://www.w3.org/1999/xlink', 'href'),
            isNull);
      });
      test('returns the current selection', () {
        expect(body.attr('foo', 'bar'), same(body));
      });
    });
  });
}
