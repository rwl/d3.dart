import 'package:unittest/unittest.dart';

void main() {
  group('with a single element selected', () {
    var body = () {
      return d3.select('body').transition();
    };
    test('returns zero for empty subselections', () {
      expect(body.select('foo').size(), equals(0));
    });
    test('returns one for a singleton selection', () {
      expect(body.size(), equals(1));
    });
    test('does not count null nodes', () {
      body[0][0] = null;
      expect(body.size(), equals(0));
    });
  });
  group('with multiple elements selected', () {
    var div = () {
      var body = d3.select('body').html(null);
      body.append('div').append('span');
      body.append('div');
      return body.selectAll('div').transition();
    };
    test('returns null for empty selections', () {
      expect(div.select('foo').size(), equals(0));
    });
    test('returns the number of non-null nodes', () {
      expect(div.size(), equals(2));
    });
    test('does not count null nodes', () {
      div[0][0] = null;
      expect(div.size(), equals(1));
    });
  });
}
