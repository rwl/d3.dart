import 'package:unittest/unittest.dart';

import '../../src/selection/selection.dart' as d4;

void main() {
  group('select(body)', () {
    group('on a simple page', () {
      Selection body = d4.select('body');
      test('returns true for empty selections', () {
        expect(body.select('foo').empty(), isTrue);
      });
      test('returns false for non-empty selections', () {
        expect(body.empty(), isFalse);
      });
      test('ignores null nodes', () {
        body[0][0] = null;
        expect(body.empty(), isTrue);
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
      test('returns true for empty selections', () {
        expect(div.select('foo').empty(), isTrue);
      });
      test('returns false for non-empty selections', () {
        expect(div.empty(), isFalse);
        expect(div.select('span').empty(), isFalse);
      });
      test('ignores null nodes', () {
        div[0][0] = null;
        expect(div.select('span').empty(), isTrue);
      });
    });
  });
}
