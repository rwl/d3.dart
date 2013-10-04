import 'package:unittest/unittest.dart';

import '../../src/selection/selection.dart' as d4;

void main() {
  group('select(body)', () {
    group('on a simple page', () {
      Selection body = d4.select('body');
      test('returns null for empty selections', () {
        expect(body.select('foo').node(), isNull);
      });
      test('returns the first element for non-empty selections', () {
        expect(body.node(), same(body[0][0]));
        expect(body.node().tagName, equals('BODY'));
      });
      test('ignores null nodes', () {
        body[0][0] = null;
        expect(body.node(), isNull);
      });
    });
  });

  group('selectAll(div)', () {
    var d3 = load('selection/empty').document();
    group('on a simple page', () {
      var body = d3.select('body');
      body.append('div').append('span');
      body.append('div');
      var div = body.selectAll('div');
      test('returns null for empty selections', () {
        expect(div.select('foo').node(), isNull);
      });
      test('returns the first element for non-empty selections', () {
        expect(div.node(), same(div[0][0]));
        expect(div.node().tagName, equals('DIV'));
      });
      test('ignores null nodes', () {
        div[0][0] = null;
        expect(div.node(), same(div[0][1]));
        expect(div.node().tagName, equals('DIV'));
      });
    });
  });
}
