import 'package:unittest/unittest.dart';

import '../../src/selection/selection.dart' as d4;

void main() {
  group('selectAll(div)', () {
    group('on a simple page', () {
      var div = d3.select("body").selectAll("div")
          .data([1, 2, 10, 20])
        .enter().append("div")
          .attr("id", String);
      test('orders elements by data', () {
        div = div.data([1, 10, 20, 2], String).order();
        expect(div[0][0].previousSibling, domNull);
        expect(div[0][1].previousSibling, domEquals(div[0][0]));
        expect(div[0][2].previousSibling, domEquals(div[0][1]));
        expect(div[0][3].previousSibling, domEquals(div[0][2]));
        expect(div[0][3].nextSibling, domNull);
      });
      test('returns the current selection', () {
        expect(span.order(), same(span));
      });
    });
  });
}