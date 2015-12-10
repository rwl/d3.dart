import 'package:test/test.dart';
import 'package:d3/js/d3.dart';

import '../util.dart';

main() {
  group('select(body)', () {
    test('removes the matching elements', () {
      var div = select('body').append('div');
      div.remove();
      expect(parentNode(div[0][0]), /*dom*/ isNull);
    });
    test('does not remove non-matching elements', () {
      var body = select('body'),
          div1 = body.append('div'),
          div2 = body.append('div');
      div1.remove();
      expect(parentNode(div2[0][0]), /*dom*/ equals(body.node()));
    });
    test('ignores null nodes', () {
      var div1 = select('body').append('div');
      var div2 = div1.selectAll('div').data([0, 1]).enter().append('div');
      var node = div2[0][0];
      div2[0][0] = null;
      div2.remove();
      expect(node.parentNode, /*dom*/ equals(div1.node()));
      expect(div2[0][1].parentNode, /*dom*/ isNull);
    });
    test('returns the current selection', () {
      var div = select('body').append('div');
      expect(div..remove(), same(div));
    });
  });
}
