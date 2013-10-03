import 'package:unittest/unittest.dart';

import '../../src/d4.dart' as d4;


void main() {
  group('selection', () {
    test('selects the document element', () {
      var selection = d4.selection();
      expect(selection.length, equals(1));
      expect(selection[0].length, equals(1));
      expect(selection[0][0].nodeType, equals(1));
      expect(selection[0][0].tagName, equals('HTML'));
    });
    test('the parentNode is also the document element', () {
      var parentNode = d4.selection()[0].parentNode;
      expect(parentNode.nodeType, equals(1));
      expect(parentNode.tagName, equals('HTML'));
    });
    test('is an instanceof d3.selection', () {
      expect(d4.selection(), new isInstanceOf<d4.selection>());
    });
    test('subselections are also instanceof d4.selection', () {
      expect(d3.selection().select("body"), new isInstanceOf<d4.selection>());
      expect(d3.selection().selectAll("body"), new isInstanceOf<d4.selection>());
    });
    test('selection prototype can be extended', () {
//      d4.selection.prototype.foo = (v) => return this.attr("foo", v);
      var body = d3.selection().select("body").foo(42);
      expect(body.attr("foo"), equals("42"));
//      delete d3.selection.prototype.foo;
    });
  });
}
