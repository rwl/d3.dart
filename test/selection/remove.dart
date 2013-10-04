import 'package:unittest/unittest.dart';

import '../../src/selection/selection.dart' as d4;

void main() {
  group('select(body)', () {
    test('removes the matching elements', () {
      var div = d3.select('body').append('div');
      div.remove();
      expect(div[0][0].parentNode, domNull);
    });
    test('does not remove non-matching elements', () {
      var body = d3.select('body'),
          div1 = body.append('div'),
          div2 = body.append('div');
      div1.remove();
      expect(div2[0][0].parentNode, domEquals(body.node()));
    });
    test('ignores null nodes', () {
      var div1 = d3.select('body').append('div'),
          div2 = div1.selectAll('div').data([0, 1]).enter().append('div'),
          node = div2[0][0];
      div2[0][0] = null;
      div2.remove();
      expect(node.parentNode, domEquals(div1.node()));
      expect(div2[0][1].parentNode, domNull);
    });
    test('returns the current selection', () {
      var div = d3.select('body').append('div');
      expect(div.remove(), same(div));
    });
  });
}
