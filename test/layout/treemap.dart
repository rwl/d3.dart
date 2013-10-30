  import 'package:unittest/unittest.dart';

import '../../src/layout/layout.dart' as d4;

void main() {
  group('treemap', () {
    var treemap = load('layout/treemap').expression('d3.layout.treemap'); 
    test('outputs a squarified treemap', () {
      var t = treemap().size([1000, 1000]).sort(null);
      expect(t.nodes({children: [{value: 1}, {value: 2}, {children: [{value: 1}, {value: 2}]}]}).map(layout), equals([
        {x: 0, y: 0, dx: 1000, dy: 1000},
        {x: 0, y: 833, dx: 1000, dy: 167},
        {x: 600, y: 0, dx: 400, dy: 833},
        {x: 0, y: 0, dx: 600, dy: 833},
        {x: 0, y: 555, dx: 600, dy: 278},
        {x: 0, y: 0, dx: 600, dy: 555}
      ]));
    });
    test('sorts by value by default', () {
      var t = treemap().size([1000, 1000]);
      expect(t.nodes({children: [{value: 1}, {value: 2}, {children: [{value: 1}, {value: 2}]}]}).map(layout), equals([
        {x: 0, y: 0, dx: 1000, dy: 1000},
        {x: 0, y: 0, dx: 333, dy: 500},
        {x: 333, y: 0, dx: 667, dy: 500},
        {x: 0, y: 500, dx: 1000, dy: 500},
        {x: 0, y: 500, dx: 333, dy: 500},
        {x: 333, y: 500, dx: 667, dy: 500}
      ]));
    });
    test('ignores zero values', () {
      var t = treemap().size([1000, 1000]).sort(null);
      expect(t.nodes({children: [{value: 1}, {value: 0}, {value: 2}, {children: [{value: 1}, {value: 2}]}]}).map(layout), equals([
        {x: 0, y: 0, dx: 1000, dy: 1000},
        {x: 0, y: 833, dx: 1000, dy: 167},
        {x: 1000, y: 0, dx: 0, dy: 833},
        {x: 600, y: 0, dx: 400, dy: 833},
        {x: 0, y: 0, dx: 600, dy: 833},
        {x: 0, y: 555, dx: 600, dy: 278},
        {x: 0, y: 0, dx: 600, dy: 555}
      ]));
    });
    test('ignores NaN values', () {
      var t = treemap().size([1000, 1000]).sort(null);
      expect(t.nodes({children: [{value: 1}, {value: NaN}, {value: 2}, {children: [{value: 1}, {value: 2}]}]}).map(layout), equals([
        {x: 0, y: 0, dx: 1000, dy: 1000},
        {x: 0, y: 833, dx: 1000, dy: 167},
        {x: 1000, y: 0, dx: 0, dy: 833},
        {x: 600, y: 0, dx: 400, dy: 833},
        {x: 0, y: 0, dx: 600, dy: 833},
        {x: 0, y: 555, dx: 600, dy: 278},
        {x: 0, y: 0, dx: 600, dy: 555}
      ]));
    });
    test('does not overflow empty size', () {
      var t = treemap().size([0, 0]).sort(null);
      expect(t.nodes({children: [{value: 1}, {value: 2}, {children: [{value: 1}, {value: 2}]}]}).map(layout), equals([
        {x: 0, y: 0, dx: 0, dy: 0},
        {x: 0, y: 0, dx: 0, dy: 0},
        {x: 0, y: 0, dx: 0, dy: 0},
        {x: 0, y: 0, dx: 0, dy: 0},
        {x: 0, y: 0, dx: 0, dy: 0},
        {x: 0, y: 0, dx: 0, dy: 0}
      ]));
    });
    test('can specify padding as a number', () {
      var t = treemap().size([1000, 1000]).sort(null).padding(1);
      expect(t.nodes({children: [{value: 1}, {value: 2}, {children: [{value: 1}, {value: 2}]}]}).map(layout), equals([
        {x: 0, y: 0, dx: 1000, dy: 1000},
        {x: 1, y: 833, dx: 998, dy: 166},
        {x: 600, y: 1, dx: 399, dy: 832},
        {x: 1, y: 1, dx: 599, dy: 832},
        {x: 2, y: 555, dx: 597, dy: 277},
        {x: 2, y: 2, dx: 597, dy: 553}
      ]));
    });
    test('can specify padding as an array', () {
      var t = treemap().size([1000, 1000]).sort(null).padding([1,2,3,4]);
      expect(t.nodes({children: [{value: 1}, {value: 2}, {children: [{value: 1}, {value: 2}]}]}).map(layout), equals([
        {x: 0, y: 0, dx: 1000, dy: 1000},
        {x: 4, y: 831, dx: 994, dy: 166},
        {x: 600, y: 1, dx: 398, dy: 830},
        {x: 4, y: 1, dx: 596, dy: 830},
        {x: 8, y: 553, dx: 590, dy: 275},
        {x: 8, y: 2, dx: 590, dy: 551}
      ]));
    });
    test('can specify padding as null', () {
      var t = treemap().size([1000, 1000]).sort(null).padding(null);
      expect(t.nodes({children: [{value: 1}, {value: 2}, {children: [{value: 1}, {value: 2}]}]}).map(layout), equals([
        {x: 0, y: 0, dx: 1000, dy: 1000},
        {x: 0, y: 833, dx: 1000, dy: 167},
        {x: 600, y: 0, dx: 400, dy: 833},
        {x: 0, y: 0, dx: 600, dy: 833},
        {x: 0, y: 555, dx: 600, dy: 278},
        {x: 0, y: 0, dx: 600, dy: 555}
      ]));
    });
    test('can specify padding as a function that returns a number', () {
      var t = treemap().size([1000, 1000]).sort(null).padding((d) { return d.depth; });
      expect(t.nodes({children: [{value: 1}, {value: 2}, {children: [{value: 1}, {value: 2}]}]}).map(layout), equals([
        {x: 0, y: 0, dx: 1000, dy: 1000},
        {x: 0, y: 833, dx: 1000, dy: 167},
        {x: 600, y: 0, dx: 400, dy: 833},
        {x: 0, y: 0, dx: 600, dy: 833},
        {x: 1, y: 555, dx: 598, dy: 277},
        {x: 1, y: 1, dx: 598, dy: 554}
      ]));
    });
    test('can specify padding as a function that returns an array', () {
      var t = treemap().size([1000, 1000]).sort(null).padding((d) { return [d.depth,2,3,4]; });
      expect(t.nodes({children: [{value: 1}, {value: 2}, {children: [{value: 1}, {value: 2}]}]}).map(layout), equals([
        {x: 0, y: 0, dx: 1000, dy: 1000},
        {x: 4, y: 831, dx: 994, dy: 166},
        {x: 600, y: 0, dx: 398, dy: 831},
        {x: 4, y: 0, dx: 596, dy: 831},
        {x: 8, y: 552, dx: 590, dy: 276},
        {x: 8, y: 1, dx: 590, dy: 551}
      ]));
    });
    test('can specify padding as a function that returns null', () {
      var t = treemap().size([1000, 1000]).sort(null).padding((d) { return d.depth & 1 ? null : 1; });
      expect(t.nodes({children: [{value: 1}, {value: 2}, {children: [{value: 1}, {value: 2}]}]}).map(layout), equals([
        {x: 0, y: 0, dx: 1000, dy: 1000},
        {x: 1, y: 833, dx: 998, dy: 166},
        {x: 600, y: 1, dx: 399, dy: 832},
        {x: 1, y: 1, dx: 599, dy: 832},
        {x: 1, y: 556, dx: 599, dy: 277},
        {x: 1, y: 1, dx: 599, dy: 555}
      ]));
    });
    test('no negatively sized rectangles', () {
      var t = treemap().size([615, 500]).sort((a, b) { return a.value - b.value; }).padding(29),
          data = [1, 9, 3, 15, 44, 28, 32, 41, 50, 60, 64, 75, 76, 84, 88, 100, 140, 142, 363, 657, 670, 822, 1173, 1189],
          nodes = t.nodes({children: data.map((d) { return {value: d}; })}).map(layout);
      expect(nodes.filter((n) { return n.dx < 0 || n.dy < 0; }).length, equals(0));
    });
    test('no overhanging rectangles', () {
      var t = treemap().size([100, 100]).sort((a, b) { return a.value - b.value; }),
          data = [0, 0, 81681.85, 370881.9, 0, 0, 0, 255381.59, 0, 0, 0, 0, 0, 0, 0, 125323.95, 0, 0, 0, 186975.07, 185707.05, 267370.93, 0],
          nodes = t.nodes({children: data.map((d) { return {value: d}; })}).map(layout);
      expect(nodes.filter((n) { return n.dx < 0 || n.dy < 0 || n.x + n.dx > 100 || n.y + n.dy > 100; }).length, equals(0));
    });
    test('can handle an empty children array', () {
      expect(treemap().nodes({children: []}).map(layout), equals([
        {x: 0, y: 0, dx: 1, dy: 1}
      ]));
      expect(treemap().nodes({children: [{children: []}, {value: 1}]}).map(layout), equals([
        {x: 0, y: 0, dx: 1, dy: 1},
        {x: 0, y: 0, dx: 0, dy: 1},
        {x: 0, y: 0, dx: 1, dy: 1}
      ]));
    });
    test('slice-dice', () {
      expect(treemap().size([100, 10]).mode('slice-dice').nodes({children: [
        {children: [{value: 1}, {value: 1}]},
        {children: [{value: 1}, {value: 1}]}
      ]}).map(layout), equals([
        {x: 0, y: 0, dx: 100, dy: 10},
        {x: 50, y: 0, dx: 50, dy: 10},
        {x: 50, y: 5, dx: 50, dy: 5},
        {x: 50, y: 0, dx: 50, dy: 5},
        {x: 0, y: 0, dx: 50, dy: 10},
        {x: 0, y: 5, dx: 50, dy: 5},
        {x: 0, y: 0, dx: 50, dy: 5}
      ]));
    });
  });
}

Map layout(node) {
  return {
    x: node.x,
    y: node.y,
    dx: node.dx,
    dy: node.dy
  };
}
