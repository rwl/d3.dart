import 'package:unittest/unittest.dart';

import '../../src/layout/layout.dart' as d4;

void main() {
  group('tree', () {
    var tree = load('layout/tree').expression('d3.layout.tree'); 
    test('can handle an empty children array', () {
      var t = tree();
      expect(t.nodes({children: []}).map(layout), [
        {depth: 0, x: 0.5, y: 0}
      ]);
      expect(t.nodes({children: [
        {children: []},
        {children: [{}]},
        {children: [{}]}
      ]}).map(layout), equals([
        {depth: 0, x: .5,   y: 0},
        {depth: 1, x: .125, y: 0.5},
        {depth: 1, x: .375, y: 0.5},
        {depth: 2, x: .375, y: 1},
        {depth: 1, x: .875, y: 0.5},
        {depth: 2, x: .875, y: 1}
      ]));
    });
    test('can handle a single node', () {
      var t = tree();
      expect(t.nodes({value: 0}).map(layout), [
        {depth: 0, x: 0.5, y: 0}
      ]);
    });
  });
}

Map layout(node) {
  return {
    depth: node.depth,
    x: node.x,
    y: node.y
  };
}
