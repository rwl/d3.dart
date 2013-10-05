import 'package:unittest/unittest.dart';

import '../../src/selection/selection.dart' as d4;

void main() {
  group('select(body)', () {
    group('on a simple page', () {
      Selection body = d4.select('body');
      test('returns zero for empty selections', () {
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
  });

  group('selectAll(div)', () {
    var d3 = load('selection/selection').document();
    group('on a simple page', () {
      body = d3.select('body');
      body.append('div').append('span');
      body.append('div');
      var div = body.selectAll('div');
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
  });
}
