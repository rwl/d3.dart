import 'package:unittest/unittest.dart';

import '../../src/layout/layout.dart' as d4;

void main() {
  group('hierarchy', () {
    var hierarchy = load('layout/treemap').expression('d3.layout.treemap'); // hierarchy is abstract, so test a subclass
    test('doesn\'t overwrite the value of a node that has an empty children array', () {
      var h = hierarchy(),
          nodes = h.sticky(true).nodes({value: 1, children: []});
      expect(nodes[0].value, equals(1));
      h.nodes(nodes[0]);
      expect(nodes[0].value, equals(1));
    });
    test('a valueless node that has an empty children array gets a value of 0', () {
      var h = hierarchy(),
          nodes = h.sticky(true).nodes({children: []});
      expect(nodes[0].value, equals(0));
      h.nodes(nodes[0]);
      expect(nodes[0].value, equals(0));
    });
  });
}
