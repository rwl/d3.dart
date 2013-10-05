import 'package:unittest/unittest.dart';

import '../../src/arrays/arrays.dart' as d4;

void main() {
  group('nest', () {
    var nest = load('arrays/nest').expression('d3.nest');
    test('returns an array of each distinct key in arbitrary order', () {
      var keys = nest()
          .key((d) { return d.foo; })
          .entries([{foo: 1}, {foo: 1}, {foo: 2}])
          .map((d) { return d.key; })
          .sort(_.ascending);
      expect(keys, equals(['1', '2']));
    });
    test('each entry is a key-values object, with values in input order', () {
      var entries = nest()
          .key((d) { return d.foo; })
          .entries([{foo: 1, bar: 0}, {foo: 2}, {foo: 1, bar: 1}]);
      expect(entries, equals([
        {key: '1', values: [{foo: 1, bar: 0}, {foo: 1, bar: 1}]},
        {key: '2', values: [{foo: 2}]}
      ]));
    });
    test('keys can be sorted using an optional comparator', () {
      var keys = nest()
          .key((d) { return d.foo; }).sortKeys(_.descending)
          .entries([{foo: 1}, {foo: 1}, {foo: 2}])
          .map((d) { return d.key; });
      expect(keys, equals(['2', '1']));
    });
    test('values can be sorted using an optional comparator', () {
      var entries = nest()
          .key((d) { return d.foo; })
          .sortValues((a, b) { return a.bar - b.bar; })
          .entries([{foo: 1, bar: 2}, {foo: 1, bar: 0}, {foo: 1, bar: 1}, {foo: 2}]);
      expect(entries, equals([
        {key: '1', values: [{foo: 1, bar: 0}, {foo: 1, bar: 1}, {foo: 1, bar: 2}]},
        {key: '2', values: [{foo: 2}]}
      ]));
    });
    test('values can be aggregated using an optional rollup', () {
      var entries = nest()
          .key((d) { return d.foo; })
          .rollup((values) { return _.sum(values, (d) { return d.bar; }); })
          .entries([{foo: 1, bar: 2}, {foo: 1, bar: 0}, {foo: 1, bar: 1}, {foo: 2}]);
      expect(entries, equals([
        {key: '1', values: 3},
        {key: '2', values: 0}
      ]));
    });
    test('multiple key functions can be specified', () {
      var entries = nest()
          .key((d) { return d[0]; }).sortKeys(_.ascending)
          .key((d) { return d[1]; }).sortKeys(_.ascending)
          .entries([[0, 1], [0, 2], [1, 1], [1, 2], [0, 2]]);
      expect(entries, equals([
        {key: '0', values: [
          {key: '1', values: [[0, 1]]},
          {key: '2', values: [[0, 2], [0, 2]]}
        ]},
        {key: '1', values: [
          {key: '1', values: [[1, 1]]},
          {key: '2', values: [[1, 2]]}
        ]}
      ]));
    });
    test('the rollup function only applies to leaf values', () {
      var entries = nest()
          .key((d) { return d[0]; }).sortKeys(_.ascending)
          .key((d) { return d[1]; }).sortKeys(_.ascending)
          .rollup((values) { return values.length; })
          .entries([[0, 1], [0, 2], [1, 1], [1, 2], [0, 2]]);
      expect(entries, equals([
        {key: '0', values: [
          {key: '1', values: 1},
          {key: '2', values: 2}
        ]},
        {key: '1', values: [
          {key: '1', values: 1},
          {key: '2', values: 1}
        ]}
      ]));
    });
    test('the value comparator only applies to leaf values', () {
      var entries = nest()
          .key((d) { return d[0]; }).sortKeys(_.ascending)
          .key((d) { return d[1]; }).sortKeys(_.ascending)
          .sortValues((a, b) { return a[2] - b[2]; })
          .entries([[0, 1], [0, 2, 1], [1, 1], [1, 2], [0, 2, 0]]);
      expect(entries, equals([
        {key: '0', values: [
          {key: '1', values: [[0, 1]]},
          {key: '2', values: [[0, 2, 0], [0, 2, 1]]}
        ]},
        {key: '1', values: [
          {key: '1', values: [[1, 1]]},
          {key: '2', values: [[1, 2]]}
        ]}
      ]));
    });
    test('the key comparator only applies to the last-specified key', () {
      var entries = nest()
          .key((d) { return d[0]; }).sortKeys(_.ascending)
          .key((d) { return d[1]; }).sortKeys(_.descending)
          .entries([[0, 1], [0, 2], [1, 1], [1, 2], [0, 2]]);
      expect(entries, equals([
        {key: '0', values: [
          {key: '2', values: [[0, 2], [0, 2]]},
          {key: '1', values: [[0, 1]]}
        ]},
        {key: '1', values: [
          {key: '2', values: [[1, 2]]},
          {key: '1', values: [[1, 1]]}
        ]}
      ]));
      var entries = nest()
          .key((d) { return d[0]; }).sortKeys(_.descending)
          .key((d) { return d[1]; }).sortKeys(_.ascending)
          .entries([[0, 1], [0, 2], [1, 1], [1, 2], [0, 2]]);
      expect(entries, equals([
        {key: '1', values: [
          {key: '1', values: [[1, 1]]},
          {key: '2', values: [[1, 2]]}
        ]},
        {key: '0', values: [
          {key: '1', values: [[0, 1]]},
          {key: '2', values: [[0, 2], [0, 2]]}
        ]}
      ]));
    });
    test('if no keys are specified, the input array is returned', () {
      var array = [new Object()];
      expect(nest().entries(array), same(array));
    });
  });
  group('map', () {
    var nest = load('arrays/nest').expression('d3.nest');
    test('returns a map of each distinct key', () {
      var map = nest()
          .key((d) { return d.foo; })
          .map([{foo: 1, bar: 0}, {foo: 2}, {foo: 1, bar: 1}]);
      expect(map, equals({
        '1': [{foo: 1, bar: 0}, {foo: 1, bar: 1}],
        '2': [{foo: 2}]
      }));
    });
    test('values can be sorted using an optional comparator', () {
      var map = nest()
          .key((d) { return d.foo; })
          .sortValues((a, b) { return a.bar - b.bar; })
          .map([{foo: 1, bar: 2}, {foo: 1, bar: 0}, {foo: 1, bar: 1}, {foo: 2}]);
      expect(map, equals({
        '1': [{foo: 1, bar: 0}, {foo: 1, bar: 1}, {foo: 1, bar: 2}],
        '2': [{foo: 2}]
      }));
    });
    test('values can be aggregated using an optional rollup', () {
      var map = nest()
          .key((d) { return d.foo; })
          .rollup((values) { return _.sum(values, (d) { return d.bar; }); })
          .map([{foo: 1, bar: 2}, {foo: 1, bar: 0}, {foo: 1, bar: 1}, {foo: 2}]);
      expect(map, equals({
        '1': 3,
        '2': 0
      }));
    });
    test('multiple key functions can be specified', () {
      var map = nest()
          .key((d) { return d[0]; }).sortKeys(_.ascending)
          .key((d) { return d[1]; }).sortKeys(_.ascending)
          .map([[0, 1], [0, 2], [1, 1], [1, 2], [0, 2]]);
      expect(map, equals({
        '0': {
          '1': [[0, 1]],
          '2': [[0, 2], [0, 2]]
        },
        '1': {
          '1': [[1, 1]],
          '2': [[1, 2]]
        }
      }));
    });
    test('the rollup function only applies to leaf values', () {
      var map = nest()
          .key((d) { return d[0]; }).sortKeys(_.ascending)
          .key((d) { return d[1]; }).sortKeys(_.ascending)
          .rollup((values) { return values.length; })
          .map([[0, 1], [0, 2], [1, 1], [1, 2], [0, 2]]);
      expect(map, equals({
        '0': {
          '1': 1,
          '2': 2
        },
        '1': {
          '1': 1,
          '2': 1
        }
      }));
    });
    test('the value comparator only applies to leaf values', () {
      var map = nest()
          .key((d) { return d[0]; }).sortKeys(_.ascending)
          .key((d) { return d[1]; }).sortKeys(_.ascending)
          .sortValues((a, b) { return a[2] - b[2]; })
          .map([[0, 1], [0, 2, 1], [1, 1], [1, 2], [0, 2, 0]]);
      expect(map, equals({
        '0': {
          '1': [[0, 1]],
          '2': [[0, 2, 0], [0, 2, 1]]
        },
        '1': {
          '1': [[1, 1]],
          '2': [[1, 2]]
        }
      }));
    });
    test('if no keys are specified, the input array is returned', () {
      var array = [new Object()];
      expect(nest().map(array), same(array));
    });
    test('handles keys that are built-in prototype properties', () {
      var map = nest()
          .key(String)
          .map(['hasOwnProperty']); // but note __proto__ wouldn’t work!
      expect(map, equals({hasOwnProperty: ['hasOwnProperty']}));
    });
    test('a custom map implementation can be specified', () {
      var map = nest()
          .key(String)
          .map(['hasOwnProperty', '__proto__'], _.map);
      expect(map.entries(), equals([
        {key: 'hasOwnProperty', value: ['hasOwnProperty']},
        {key: '__proto__', value: ['__proto__']}
      ]));
    });
    test('the custom map implementation works on multiple levels of nesting', () {
      var map = nest()
          .key((d) { return d.foo; })
          .key((d) { return d.bar; })
          .map([{foo: 42, bar: 'red'}], _.map);
      expect(map.keys(), equals(['42']));
      expect(map.get('42').keys(), equals(['red']));
      expect(map.get('42').values(), equals([[{foo: 42, bar: 'red'}]]));
      expect(map.get('42').entries(), equals([{key: 'red', value: [{foo: 42, bar: 'red'}]}]));
    });    
  });
}
