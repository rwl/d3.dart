import 'package:unittest/unittest.dart';

import '../../src/layout/layout.dart' as d4;

void main() {
  group('cluster', () {
    var cluster = load('layout/cluster').expression('d3.layout.cluster');
    test('can handle an empty children array', () {
      var c = cluster();
      expect(c.nodes({value: 1, children: [{value: 1, children: []}, {value: 1}]}).map(layout), equals([
        {value: 1, depth: 0, x: 0.5,  y: 0},
        {value: 1, depth: 1, x: 0.25, y: 1},
        {value: 1, depth: 1, x: 0.75, y: 1}
      ]));
    });
    test('can handle zero-valued nodes', () {
      var c = cluster();
      expect(c.nodes({value: 0, children: [{value: 0}, {value: 1}]}).map(layout), equals([
        {value: 0, depth: 0, x: 0.5,  y: 0},
        {value: 0, depth: 1, x: 0.25, y: 1},
        {value: 1, depth: 1, x: 0.75, y: 1}
      ]));
    });
    test('can handle a single node', () {
      var c = cluster();
      expect(c.nodes({value: 0}).map(layout), equals([
        {value: 0, depth: 0, x: 0.5,  y: 0}
      ]));
    });
  });
}

layout(node) {
  return {
    value: node.value,
    depth: node.depth,
    x: node.x,
    y: node.y
  };
}
