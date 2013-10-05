import 'package:unittest/unittest.dart';

import '../../src/selection/selection.dart' as d4;

void main() {
  group('selectAll(div).selectAll(span)', () {
    group('on a page with some spans', () {
      var span = d3.select('body').append('div').selectAll('div')
          .data([1, 2, 10, 20])
        .enter().append('div')
        .selectAll('span')
          .data((d) { return [20 + d, 2 + d, 10, 1]; })
        .enter().append('span');
      test('sorts elements by natural order', () {
        span.sort();
        expect(span[0][0].previousSibling, domNull);
        expect(span[0][1].previousSibling, domEquals(span[0][0]));
        expect(span[0][2].previousSibling, domEquals(span[0][1]));
        expect(span[0][3].previousSibling, domEquals(span[0][2]));
        expect(span[0][3].nextSibling, domNull);
      });
      test('sorts each group independently', () {
        span.sort((a, b) { return b - a; });
        expect(span[0].map(data), equals([21, 10, 3, 1]));
        expect(span[1].map(data), equals([22, 10, 4, 1]));
        expect(span[2].map(data), equals([30, 12, 10, 1]));
        expect(span[3].map(data), equals([40, 22, 10, 1]));
      });
      test('sorts using the specified comparator', () {
        span.sort((a, b) { return (a + '').localeCompare(b + ''); });
        expect(span[0].map(data), equals([1, 10, 21, 3]));
        expect(span[1].map(data), equals([1, 10, 22, 4]));
        expect(span[2].map(data), equals([1, 10, 12, 30]));
        expect(span[3].map(data), equals([1, 10, 22, 40]));
      });
      test('returns the current selection', () {
        expect(span.sort(), same(span));
      });
      test('sorts null nodes at the end of the selection', () {
        var nulls = 0;
        span[0][0].parentNode.removeChild(span[0][0]);
        span[0][2].parentNode.removeChild(span[0][2]);
        span[0][0] = span[0][2] = null;
        span.sort((a, b) {
          if ((a == null) || (b == null)) ++nulls;
          return a - b;
        });
        expect(nulls, equals(0));

        expect(span[0][2], domNull);
        expect(span[0][3], domNull);
        expect(span[0][0].previousSibling, domNull);
        expect(span[0][1], domEquals(span[0][0].nextSibling));
        expect(span[0][0], domEquals(span[0][1].previousSibling));
        expect(span[0][1].nextSibling, domNull);
        expect(span[0].slice(0, -2).map(data), equals([3, 21]));

        for (var i = 1; i < 4; ++i) {
          var d = span[i].parentNode.__data__;
          expect(span[i][0].previousSibling);
          expect(span[i][1], domEquals(span[i][0].nextSibling));
          expect(span[i][0], domEquals(span[i][1].previousSibling);
          expect(span[i][2], domEquals(span[i][1].nextSibling);
          expect(span[i][1], domEquals(span[i][2].previousSibling);
          expect(span[i][3], domEquals(span[i][2].nextSibling);
          expect(span[i][2], domEquals(span[i][3].previousSibling);
          expect(span[i][3].nextSibling, domNull);
          expect(span[i].map(data), equals([1, 2 + d, 10, 20 + d].sort((a, b) { return a - b; })));
        }
      });
    });
  });
}
