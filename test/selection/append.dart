import 'package:unittest/unittest.dart';

import '../../src/d4.dart' as d4;
import '../../src/selection/selection.dart';


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
        var svg = body.select("svg").remove().node();
        expect(svg, same(body.node().lastChild));
        body.appendFunc(() { return svg; });
        expect(svg, same(body.node().lastChild));
      });
      test('propagates data to new element', () {
        var data = new Object();
        var div = body.data([data]).append("div");
        expect(div[0][0].attributes['__data__'], equals(data));
      });
      test('returns a new selection', () {
        expect(body.append("div") ==/*=*/ body, isFalse);
      });
      test('inherits namespace from parent node', () {
        var g = body.append("svg:svg").append("g");
        expect(g[0][0].namespaceURI, equals("http://www.w3.org/2000/svg"));
      });
    });
  });

  group('select(body)', () {
    group('on a simple page', () {
      var div = d4.select("body").selectAll("div").data([0, 1]).enter().append("div");
      test('appends an HTML element', () {
        
      });
    });
  });
}
