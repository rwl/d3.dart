import 'package:unittest/unittest.dart';

import '../../src/layout/layout.dart' as d4;

void main() {
  group('pie', () {
    var pie = load('layout/pie').expression('d3.layout.pie'); 
    test('arcs are in same order as original data', () {
      var p = pie();
      expect(p([5, 30, 15]).map((d) { return d.data; }), equals([
        5, 30, 15
      ]));
      expect(p([
        84, 90, 48, 61, 58, 8, 6, 31, 45, 18
      ]).map((d) { return d.data; }), equals([
        84, 90, 48, 61, 58, 8, 6, 31, 45, 18
      ]));
    });
  });
}
