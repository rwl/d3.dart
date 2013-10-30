import 'package:unittest/unittest.dart';

import '../../src/layout/layout.dart' as d4;

void main() {
  group('histogram', () {
    var histogram = load('layout/histogram').expression('d3.layout.histogram'); 
    test('defaults to frequencies', () {
      var h = histogram();
      expect(h([0,0,0,1,2,2]).map(elements), equals([[0, 0, 0], [], [1], [2, 2]]));
    });
    test('each bin contains the matching source elements', () {
      var h = histogram();
      expect(h([0,0,0,1,2,2]).map(elements), equals([[0, 0, 0], [], [1], [2, 2]]));
    });
    test('each bin also has defined x, y and dx properties', () {
      var h = histogram();
      expect(h([0,0,0,1,2,2]).map(metadata), equals([
        {x:   0, y: 3, dx: 0.5},
        {x: 0.5, y: 0, dx: 0.5},
        {x:   1, y: 1, dx: 0.5},
        {x: 1.5, y: 2, dx: 0.5}
      ]));
    });
    test('can output frequencies', () {
      var h = histogram().frequency(true);
      expect(h([0,0,0,1,2,2]).map(metadata), equals([
        {x:   0, y: 3, dx: 0.5},
        {x: 0.5, y: 0, dx: 0.5},
        {x:   1, y: 1, dx: 0.5},
        {x: 1.5, y: 2, dx: 0.5}
      ]));
    });
    test('can output probabilities', () {
      var h = histogram().frequency(false);
      expect(h([0,0,0,1,2,2]).map(metadata), equals([
        {x:   0, y: 3/6, dx: 0.5},
        {x: 0.5, y:   0, dx: 0.5},
        {x:   1, y: 1/6, dx: 0.5},
        {x: 1.5, y: 2/6, dx: 0.5}
      ]));
    });
    test('can specify number of bins', () {
      var h = histogram().bins(2);
      expect(h([0,0,0,1,2,2]).map(elements), equals([
        [0, 0, 0],
        [1, 2, 2]
      ]));
      expect(h([0,0,0,1,2,2]).map(metadata), equals([
        {x: 0, y: 3, dx: 1},
        {x: 1, y: 3, dx: 1}
      ]));
    });
    test('can specify bin thresholds', () {
      var h = histogram().bins([0,1,2,3]);
      expect(h([0,0,0,1,2,2]).map(elements), equals([
        [0, 0, 0],
        [1],
        [2, 2]
      ]));
      expect(h([0,0,0,1,2,2]).map(metadata), equals([
        {x: 0, y: 3, dx: 1},
        {x: 1, y: 1, dx: 1},
        {x: 2, y: 2, dx: 1}
      ]));
    });
    test('returns the empty array with fewer than two bins', () {
      var h = histogram().bins([1]);
      expect(h([0]), equals([]));
      var h = histogram().bins([]);
      expect(h([0]), equals([]));
    });
  }
}

List elements(List bin) {
  var array = [];
  var i = -1;
  var n = bin.length;
  while (++i < n) {
    array.push(bin[i]);
  }
  return array;
}

Map metadata(Map bin) {
  var metadata = {};
  if (bin.containsKey(' x')) metadata['x'] = bin['x'];
  if (bin.containsKey('y')) metadata['y'] = bin['y'];
  if (bin.containsKey('dx')) metadata['dx'] = bin['dx'];
  return metadata;
}