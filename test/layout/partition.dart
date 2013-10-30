import 'package:unittest/unittest.dart';

import '../../src/layout/layout.dart' as d4;

void main() {
  group('partition', () {
    var partition = load('layout/partition').expression('d3.layout.partition'); 
    test('ignores zero values', () {
      var p = partition().size([3, 3]);
      expect(p.nodes({children: [{value: 1}, {value: 0}, {value: 2}, {children: [{value: 0}, {value: 0}]}]}).map(metadata), equals([
        {x: 0, y: 0, dx: 3, dy: 1},
        {x: 2, y: 1, dx: 1, dy: 1},
        {x: 3, y: 1, dx: 0, dy: 1},
        {x: 0, y: 1, dx: 2, dy: 1},
        {x: 3, y: 1, dx: 0, dy: 1},
        {x: 3, y: 2, dx: 0, dy: 1},
        {x: 3, y: 2, dx: 0, dy: 1}
      ]));
    });
    test('can handle an empty children array', () {
      var p = partition();
      expect(p.nodes({children: []}).map(metadata), [
        {x: 0, y: 0, dx: 1, dy: 1}
      ]);
      expect(p.nodes({children: [{children: []}, {value: 1}]}).map(metadata), equals([
        {x: 0, y: 0,   dx: 1, dy: 0.5},
        {x: 1, y: 0.5, dx: 0, dy: 0.5},
        {x: 0, y: 0.5, dx: 1, dy: 0.5}
      ])) ;
    });
  });
}

Map metadata(node) {
  var metadata = {};
  if (bin.containsKey(' x')) metadata['x'] = bin['x'];
  if (bin.containsKey('y')) metadata['y'] = bin['y'];
  if (bin.containsKey('dx')) metadata['dx'] = bin['dx'];
  if (bin.containsKey('dy')) metadata['dy'] = bin['dy'];
  return metadata;
}
