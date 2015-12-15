import 'package:test/test.dart';
import 'package:d3/js/d3.dart';

import '../util.dart';

void main() {
  group('select(body)', () {
    group('on a simple page', () {
      var body = select('body');
      test('inserts before the specified selector', () {
        var span = body
          ..html('')
          ..append('span');
        var div = body.insert('div', 'span');
        expect(div[0][0].tagName, equals('DIV'));
        expect(div[0][0].namespaceUri, isNull);
        expect(div[0][0], /*domEquals*/ equals(body.node().firstChild));
        expect(div[0][0].nextElementSibling, /*domEquals*/ equals(span[0][0]));
      });
      test('inserts before the specified node', () {
        var span = body
          ..html('')
          ..append('span');
        var div = body.insert('div', () {
          return span.node;
        });
        expect(div[0][0].tagName, equals('DIV'));
        expect(div[0][0].namespaceURI, isNull);
        expect(div[0][0], /*domEquals*/ equals((body.node().firstChild)));
        expect(div[0][0].nextSibling, /*domEquals*/ equals((span[0][0])));
      });
      test('appends an HTML element', () {
        var div = body.insert('div');
        expect(div[0][0].tagName, equals('DIV'));
        expect(div[0][0].namespaceURI, isNull);
        expect(div[0][0], /*domEquals*/ equals(body.node().lastChild));
      });
      test('appends an SVG element', () {
        var svg = body.insert('svg:svg');
        expect(svg[0][0].tagName, equals('SVG'));
        expect(svg[0][0].namespaceURI, equals('http://www.w3.org/2000/svg'));
        expect(svg[0][0].parentNode, /*domEquals*/ equals(body.node));
        expect(svg[0][0], /*domEquals*/ equals(body.node().lastChild));
      });
      test('propagates data to new element', () {
        var data = new Object(), div = body.data([data]).insert('div');
        expect(div[0][0].__data__, same(data));
      });
      test('returns a new selection', () {
        expect(body.insert('div') == /*=*/ body, isFalse);
      });
      test('inherits namespace from parent node', () {
        var g = body.insert('svg:svg').insert('g');
        expect(g[0][0].namespaceURI, equals('http://www.w3.org/2000/svg'));
      });
    });
  });

  group('selectAll(div)', () {
//    var d3 = load('selection/empty').document();
    group('on a simple page', () {
      var div =
          select('body').selectAll('div').data([0, 1]).enter().append('div');
      test('appends an HTML element', () {
        var span = div.insert('span');
        expect(span[0].length, equals(2));
        expect(span[0][0].tagName, equals('SPAN'));
        expect(span[0][1].tagName, equals('SPAN'));
        expect(span[0][0].namespaceURI, isNull);
        expect(span[0][1].namespaceURI, isNull);
        expect(span[0][0].parentNode, /*domEquals*/ equals(div[0][0]));
        expect(span[0][1].parentNode, /*domEquals*/ equals(div[0][1]));
        expect(div[0][0].lastChild, /*domEquals*/ equals(span[0][0]));
        expect(div[0][1].lastChild, /*domEquals*/ equals(span[0][1]));
      });
      test('appends an SVG element', () {
        var svg = div.insert('svg:svg');
        expect(svg[0].length, equals(2));
        expect(svg[0][0].tagName, equals('SVG'));
        expect(svg[0][1].tagName, equals('SVG'));
        expect(svg[0][0].namespaceURI, equals('http://www.w3.org/2000/svg'));
        expect(svg[0][1].namespaceURI, equals('http://www.w3.org/2000/svg'));
        expect(svg[0][0].parentNode, /*domEquals*/ equals(div[0][0]));
        expect(svg[0][1].parentNode, /*domEquals*/ equals(div[0][1]));
        expect(div[0][0].lastChild, /*domEquals*/ equals(svg[0][0]));
        expect(div[0][1].lastChild, /*domEquals*/ equals(svg[0][1]));
      });
      test('propagates data to new elements', () {
        var a = new Object(), b = new Object();
        var span = div.data([a, b]).insert('span');
        expect(nodeData(span[0][0]), same(a));
        expect(nodeData(span[0][1]), same(b));
      });
      test('returns a new selection', () {
        expect(div.insert('div') == /*=*/ div, isFalse);
      });
      test('ignores null nodes', () {
        div.html('');
        var node = div[0][1];
        div[0][1] = null;
        var span = div.insert('span');
        expect(span[0].length, equals(2));
        expect(span[0][0].tagName, equals('SPAN'));
        expect(span[0][1], /*domNull*/ isNull);
        expect(span[0][0].parentNode, /*domEqual*/ equals(div[0][0]));
        expect(div[0][0].lastChild, /*domEqual*/ equals(span[0][0]));
        expect(node.lastChild, /*domNull*/ isNull);
      });
    });
  });

  group('enter-insert', () {
//    var d3 = load('selection/empty').document();
    group('on a simple page', () {
      var body = select('body');
      body.selectAll('div').data(['apple', 'orange']).enter().append('div');
      test('inserts before the following updating sibling', () {
        var data = [
          'peach',
          'apple',
          'apple2',
          'apple3',
          'banana',
          'orange',
          'apricot'
        ];
        body.selectAll('div').data(data, String).enter().insert('div');
        expect(body.selectAll('div').groupData, equals(data));
      });
    });
  });

  group('selectAll(div).data(…).enter()', () {
//    var d3 = load('selection/empty').document();
    group('on a simple page', () {
//      var div = new Selection.selector('body').selectAll('div').data([0, 1]).enter().append('div');

      var body = select('body');
      test('inserts before the specified selector', () {
        var span = body.append('span');
        var div =
            body.selectAll('div').data([0, 1]).enter().insert('div', 'span');
        expect(div.length, equals(1));
        expect(div[0].length, equals(2));
        expect(div[0][0], /*domEquals*/ equals(body.node().firstChild));
        expect(div[0][1].previousSibling, /*domEquals*/ equals(div[0][0]));
        expect(div[0][1].nextSibling, /*domEquals*/ equals(span[0][0]));
      });

      body = select('body'); // TODO: setUp
      test('propagates data to new elements', () {
        var a = new Object(),
            b = new Object(),
            div =
            body.html('').selectAll('div').data([a, b]).enter().insert('div');
        expect(nodeData(div[0][0]), same(a));
        expect(nodeData(div[0][1]), same(b));
      });

      body = select('body');
      test('ignores null nodes', () {
        body.html('').insert('div');
        var div = body.selectAll('div').data([0, 1, 2]).enter().insert('div');
        expect(div.length, equals(1));
        expect(div[0].length, equals(3));
        expect(div[0][0], /*domNull*/ isNull);
        expect(div[0][1].parentNode, /*domEquals*/ equals(body.node()));
        expect(div[0][2].parentNode, /*domEquals*/ equals(body.node()));
      });

      body = select('body');
      test('returns a new selection', () {
        var enter = body.html('').selectAll('div').data([0, 1]).enter();
        expect(enter.insert('div') == /*=*/ enter, isFalse);
      });
    });
  });
}
