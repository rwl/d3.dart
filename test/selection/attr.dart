import 'package:unittest/unittest.dart';

import '../../src/selection/selection.dart' as d4;


void main() {
  group('select(body)', () {
    group('on a simple page', () {
      Selection body = d4.select('body');
      test('sets an attribute as a string', () {
        body.attr('bgcolor', 'red');
        expect(body.node().getAttribute('bgcolor'), equals('red'));
      });
      test('sets an attribute as a number', () {
        body.attr('opacity', 1);
        expect(body.node().getAttribute('opacity'), equals('1'));
      });
      test('sets an attribute as a function', () {
        body.attr('bgcolor', () { return 'orange'; });
        expect(body.node().getAttribute('bgcolor'), equals('orange'));
      });
      test('sets an attribute as a function of data', () {
        body.data(['cyan']).attr('bgcolor', String);
        expect(body.node().getAttribute('bgcolor'), equals('cyan'));
      });
      test('sets an attribute as a function of index', () {
        body.attr('bgcolor', (d, i) { return 'orange-' + i; });
        expect(body.node().getAttribute('bgcolor'), equals('orange-0'));
      });
      test('sets a namespaced attribute as a string', () {
        body.attr('xlink:href', 'url');
        expect(body.node().getAttributeNS('http://www.w3.org/1999/xlink', 'href'), equals('url'));
      });
      test('sets a namespaced attribute as a function', () {
        body.data(['orange']).attr('xlink:href', (d, i) { return d + '-' + i; });
        expect(body.node().getAttributeNS('http://www.w3.org/1999/xlink', 'href'), equals('orange-0'));
      });
      test('sets attributes as a map of constants', () {
        body.attr({bgcolor: 'white', 'xlink:href': 'url.png'});
        expect(body.node().getAttribute('bgcolor'), equals('white'));
        expect(body.node().getAttributeNS('http://www.w3.org/1999/xlink', 'href'), equals('url.png'));
      });
      test('sets attributes as a map of functions', () {
        body.data(['orange']).attr({'xlink:href': (d, i) { return d + '-' + i + '.png'; }});
        expect(body.node().getAttributeNS('http://www.w3.org/1999/xlink', 'href'), equals('orange-0.png'));
      });
      test('gets an attribute value', () {
        body.node().setAttribute('bgcolor', 'yellow');
        expect(body.attr('bgcolor'), equals('yellow'));
      });
      test('gets a namespaced attribute value', () {
        body.node().setAttributeNS('http://www.w3.org/1999/xlink', 'foo', 'bar');
        expect(body.attr('xlink:foo'), equals('bar'));
      });
      test('removes an attribute as null', () {
        body.attr('bgcolor', 'red').attr('bgcolor', null);
        expect(body.attr('bgcolor'), isNull);
      });
      test('removes an attribute as a function', () {
        body.attr('bgcolor', 'red').attr('bgcolor', () { return null; });
        expect(body.attr('bgcolor'), isNull);
      });
      test('removes a namespaced attribute as null', () {
        body.attr('xlink:href', 'url').attr('xlink:href', null);
        expect(body.attr('bgcolor'), isNull);
      });
      test('removes a namespaced attribute as a function', () {
        body.attr('xlink:href', 'url').attr('xlink:href', () { return null; });
        expect(body.attr('xlink:href'), isNull);
      });
      test('removes attributes as a map of null', () {
        body.node().setAttribute('bgcolor', 'white');
        body.node().setAttributeNS('http://www.w3.org/1999/xlink', 'href', 'foo.png');
        body.attr({bgcolor: null, 'xlink:href': null});
        expect(body.node().getAttribute('bgcolor'), isNull);
        expect(body.node().getAttributeNS('http://www.w3.org/1999/xlink', 'href'), isNull);
      });
      test('removes attributes as a map of functions that return null', () {
        body.node().setAttribute('bgcolor', 'white');
        body.node().setAttributeNS('http://www.w3.org/1999/xlink', 'href', 'foo.png');
        body.attr({bgcolor: () {}, 'xlink:href': () {}});
        expect(body.node().getAttribute('bgcolor'), isNull);
        expect(body.node().getAttributeNS('http://www.w3.org/1999/xlink', 'href'), isNull);
      });
      test('returns the current selection', () {
        expect(body.attr('foo', 'bar'), same(body));
      });
    });
  });

  group('selectAll(div)', () {
    var d3 = load('selection/attr').document();
    group('on a simple page', () {
      var div = d3.select('body').selectAll('div').data([0, 1]).enter().append('div');
      test('sets an attribute as a string', () {
        div.attr('bgcolor', 'red');
        expect(div[0][0].getAttribute('bgcolor'), equals('red'));
        expect(div[0][1].getAttribute('bgcolor'), equals('red'));
      });
      test('sets an attribute as a number', () {
        div.attr('opacity', 0.4);
        expect(div[0][0].getAttribute('opacity'), equals('0.4'));
        expect(div[0][1].getAttribute('opacity'), equals('0.4'));
      });
      test('sets an attribute as a function', () {
        div.attr('bgcolor', () { return 'coral'; });
        expect(div[0][0].getAttribute('bgcolor'), equals('coral'));
        expect(div[0][1].getAttribute('bgcolor'), equals('coral'));
      });
      test('sets an attribute as a function of data', () {
        div.attr('bgcolor', _.interpolateRgb('brown', 'steelblue'));
        expect(div[0][0].getAttribute('bgcolor'), equals('#a52a2a'));
        expect(div[0][1].getAttribute('bgcolor'), equals('#4682b4'));
      });
      test('sets an attribute as a function of index', () {
        div.attr('bgcolor', (d, i) { return 'color-' + i; });
        expect(div[0][0].getAttribute('bgcolor'), equals('color-0'));
        expect(div[0][1].getAttribute('bgcolor'), equals('color-1'));
      });
      test('sets a namespaced attribute as a string', () {
        div.attr('xlink:href', 'url');
        expect(div[0][0].getAttributeNS('http://www.w3.org/1999/xlink', 'href'), equals('url'));
        expect(div[0][1].getAttributeNS('http://www.w3.org/1999/xlink', 'href'), equals('url'));
      });
      test('sets a namespaced attribute as a function', () {
        div.data(['red', 'blue']).attr('xlink:href', (d, i) { return d + '-' + i; });
        expect(div[0][0].getAttributeNS('http://www.w3.org/1999/xlink', 'href'), equals('red-0'));
        expect(div[0][1].getAttributeNS('http://www.w3.org/1999/xlink', 'href'), equals('blue-1'));
      });
      test('gets an attribute value', () {
        div[0][0].setAttribute('bgcolor', 'purple');
        expect(div.attr('bgcolor'), equals('purple'));
      });
      test('gets a namespaced attribute value', () {
        div[0][0].setAttributeNS('http://www.w3.org/1999/xlink', 'foo', 'bar');
        expect(div.attr('xlink:foo'), equals('bar'));
      });
      test('removes an attribute as null', () {
        div.attr('href', 'url').attr('href', null);
        expect(div[0][0].getAttribute('href'), isNull);
        expect(div[0][1].getAttribute('href'), isNull);
      });
      test('removes an attribute as a function', () {
        div.attr('href', 'url').attr('href', () { return null; });
        expect(div[0][0].getAttribute('href'), isNull);
        expect(div[0][1].getAttribute('href'), isNull);
      });
      test('removes a namespaced attribute as null', () {
        div.attr('xlink:foo', 'bar').attr('xlink:foo', null);
        expect(div[0][0].getAttributeNS('http://www.w3.org/1999/xlink', 'foo'), isNull);
        expect(div[0][1].getAttributeNS('http://www.w3.org/1999/xlink', 'foo'), isNull);
      });
      test('removes a namespaced attribute as a function', () {
        div.attr('xlink:foo', 'bar').attr('xlink:foo', () { return null; });
        expect(div[0][0].getAttributeNS('http://www.w3.org/1999/xlink', 'foo'), isNull);
        expect(div[0][1].getAttributeNS('http://www.w3.org/1999/xlink', 'foo'), isNull);
      });
      test('returns the current selection', () {
        expect(div.attr('foo', 'bar'), same(div));
      });
      test('ignores null nodes', () {
        var node = div[0][1];
        div.attr('href', null);
        div[0][1] = null;
        div.attr('href', 'url');
        expect(div[0][0].getAttribute('href'), equals('url'));
        expect(node.getAttribute('href'), isNull);
      });
    });
  });
}
