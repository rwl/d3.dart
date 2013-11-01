import 'package:unittest/unittest.dart';

void main() {
  group('with a single element selected', () {
    var body = () {
      return d3.select('body').transition();
    };
    test('returns null for empty subselections', () {
      expect(body.select('foo').node(), isNull);
    });
    test('returns the selected element', () {
      expect(body.node().tagName, equals('BODY'));
    });
    test('returns null if no elements are slected', () {
      body[0][0] = null;
      expect(body.node(), isNull);
    });
  });
  group('with multiple elements selected', () {
    var div = () {
      var body = d3.select('body').html(null);
      body.append('div').attr('class', 'first').append('span');
      body.append('div').attr('class', 'second');
      return body.selectAll('div').transition();
    };
    test('returns null for empty subselections', () {
      expect(div.select('foo').node(), isNull);
    });
    test('returns the first selected element', () {
      expect(div.node().className, equals('first'));
      expect(div.node().tagName, equals('DIV'));
    });
    test('does not count null nodes', () {
      div[0][0] = null;
      expect(div.node().className, equals('second'));
      expect(div.node().tagName, equals('DIV'));
    });
  });
}
