import 'package:unittest/unittest.dart';

import '../../src/selection/selection.dart' as d4;


void main() {
  group('select(body)', () {
    group('on a simple page', () {
      Selection body = d4.select('body');
      test('appends an HTML element', () {
        var div = body.append('div');
        expect(div[0][0].tagName, equals('DIV'));
        expect(div[0][0].namespaceURI, isNull);
        expect(div[0][0].parentNode == body.node(), isTrue);
        expect(div[0][0] == body.node().lastChild, isTrue);        
      });
      test('appends an SVG element', () {
        var svg = body.append('svg:svg');
        expect(svg[0][0].tagName, equals('SVG'));
        expect(svg[0][0].namespaceURI, equals('http://www.w3.org/2000/svg'));
        expect(svg[0][0].parentNode, same(body.node()));
        expect(svg[0][0], same(body.node().lastChild));        
      });
      test('appends an element specified as a function', () {
        var svg = body.select('svg').remove().node();
        expect(svg, same(body.node().lastChild));
        body.appendFunc(() { return svg; });
        expect(svg, same(body.node().lastChild));
      });
      test('propagates data to new element', () {
        var data = new Object();
        var div = body.data([data]).append('div');
        expect(div[0][0].attributes['__data__'], equals(data));
      });
      test('returns a new selection', () {
        expect(body.append('div') ==/*=*/ body, isFalse);
      });
      test('inherits namespace from parent node', () {
        var g = body.append('svg:svg').append('g');
        expect(g[0][0].namespaceURI, equals('http://www.w3.org/2000/svg'));
      });
    });
  });

  group('select(body)', () {
    group('on a simple page', () {
      var div = d4.select('body').selectAll('div').data([0, 1]).enter().append('div');
      test('appends an HTML element', () {
        var span = div.append('span');
        expect(span[0].length, equals(2));
        expect(span[0][0].tagName, equals('SPAN'));
        expect(span[0][1].tagName, equals('SPAN'));
        expect(span[0][0].namespaceURI, isNull);
        expect(span[0][1].namespaceURI, isNull);
        expect(span[0][0].parentNode, same(div[0][0]));
        expect(span[0][1].parentNode, same(div[0][1]));
        expect(div[0][0].lastChild, same(span[0][0]));
        expect(div[0][1].lastChild, same(span[0][1]));        
      });
      test('appends an SVG element', () {
        var svg = div.append('svg:svg');
        expect(svg[0].length, equals(2));
        expect(svg[0][0].tagName, equals('SVG'));
        expect(svg[0][1].tagName, equals('SVG'));
        expect(svg[0][0].namespaceURI, equals('http://www.w3.org/2000/svg'));
        expect(svg[0][1].namespaceURI, equals('http://www.w3.org/2000/svg'));
        expect(svg[0][0].parentNode, same(div[0][0]));
        expect(svg[0][1].parentNode, same(div[0][1]));
        expect(div[0][0].lastChild, same(svg[0][0]));
        expect(div[0][1].lastChild, same(svg[0][1]));
      });
      test('propagates data to new elements', () {
        var a = new Object();
        var b = new Object();
        var span = div.data([a, b]).append('span');
        expect(span[0][0].__data__, equals(a));
        expect(span[0][1].__data__, equals(b));
      });
      test('returns a new selection', () {
        expect(div.append('div') ==/*=*/ div, isFalse);
      });
      test('ignores null nodes', () {
        var node = div.html('')[0][1];
        div[0][1] = null;
        var span = div.append('span');
        expect(span[0].length, equals(2));
        expect(span[0][0].tagName, equals('SPAN'));
        expect(span[0][1], isNull);
        expect(span[0][0].parentNode, same(div[0][0]));
        expect(div[0][0].lastChild, same(span[0][0]));
        expect(node.lastChild, isNull);
      });      
    });
  });

  group('enter-append', () {
    group('on a page with existing elements', () {
      Selection body = d3.select('body');
      body.selectAll('div').data(['apple', 'orange']).enter().append('div');
      test('appends to the end of the parent', () {
        var data = ['peach', 'apple', 'banana', 'orange', 'apricot'];
        body.selectAll('div').data(data, String).enter().append('div');
        expect(body.selectAll('div').data(), equals(['apple', 'orange', 'peach', 'banana', 'apricot']));
      });
    });      
  });

  group('selectAll(div).data(…).enter()', () {
    group('on a simple page', () {
      Selection body = d3.select('body');
      test('appends to the parent node', () {
        var div = body.selectAll('div').data([0, 1]).enter().append('div');
        expect(div.length, equals(1));
        expect(div[0].length, equals(2));
        expect(div[0][0].parentNode, /*dom*/equals(body.node()));
        expect(div[0][1].parentNode, /*dom*/equals(body.node()));
      });
      test('propagates data to new elements', () {
        var a = new Object();
        var b = new Object();
        var div = body.html('').selectAll('div').data([a, b]).enter().append('div');
        expect(div[0][0].__data__, same(a));
        expect(div[0][1].__data__, same(b));
      });
      test('ignores null nodes', () {
        body.html('').append('div');
        var div = body.selectAll('div').data([0, 1, 2]).enter().append('div');
        expect(div.length, equals(1));
        expect(div[0].length, equals(3));
        expect(div[0][0], /*dom*/isNull);
        expect(div[0][1].parentNode, /*dom*/equals(body.node()));
        expect(div[0][2].parentNode, /*dom*/equals(body.node()));
      });
    });
  });      
}
