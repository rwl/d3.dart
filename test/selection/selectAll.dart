import 'package:unittest/unittest.dart';

import '../../src/selection/selection.dart' as d4;

void main() {
  group('select(body)', () {
    group('on a simple page', () {
      Selection body = d4.select('body');
      body.append('span').attr('class', 'f00').attr('id', 'b4r').attr('name', 'b4z');
      body.append('div').attr('class', 'foo').attr('id', 'bar').attr('name', 'baz');
      test('selects by element name', () {
        var div = d3.selectAll('div');
        expect(div[0][0].tagName, equals('DIV'));
      });
      test('selects by class name', () {
        var div = d3.selectAll('.foo');
        expect(div[0][0].className, equals('foo'));
      });
      test('selects by id', () {
        var div = d3.selectAll('div#bar');
        expect(div[0][0].id, equals('bar'));
      });
      test('selects by attribute value', () {
        var div = d3.selectAll('[name=baz]');
        expect(div[0][0].getAttribute('name'), equals('baz'));
      });
      test('selects by array', () {
        var body = d3.select('body').node(), div = d3.selectAll([body.lastChild]);
        expect(div[0][0], same(body.lastChild));
        expect(div.length, equals(1));
        expect(div[0].length, equals(1));
      });
      test('groups are arrays, not NodeLists', () {
        var div = d3.select('body').selectAll(() {
          return this.getElementsByClassName('div');
        });
        expect(Array.isArray(div[0]), isTrue);
      });
      test('sets the parentNode to the document element', () {
        var selection = d3.selectAll('body'),
            document = d3.selection().node().ownerDocument;
        expect(selection[0].parentNode, same(document.documentElement));
      });
    });
  });
}
