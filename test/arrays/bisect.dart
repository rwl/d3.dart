import 'package:unittest/unittest.dart';

import '../../src/arrays/arrays.dart' as d4;

var i30 = 1 << 30;

void main() {
  group('bisectLeft', () {
    var bisect = load('arrays/bisect').expression('d3.bisectLeft');
    test('finds the index of an exact match', () {
      var array = [1, 2, 3];
      expect(bisect(array, 1), equals(0));
      expect(bisect(array, 2), equals(1));
      expect(bisect(array, 3), equals(2));
    });
    test('finds the index of the first match', () {
      var array = [1, 2, 2, 3];
      expect(bisect(array, 1), equals(0));
      expect(bisect(array, 2), equals(1));
      expect(bisect(array, 3), equals(3));
    });
    test('finds the insertion point of a non-exact match', () {
      var array = [1, 2, 3];
      expect(bisect(array, 0.5), equals(0));
      expect(bisect(array, 1.5), equals(1));
      expect(bisect(array, 2.5), equals(2));
      expect(bisect(array, 3.5), equals(3));
    });
    test('has undefined behavior if the search value is unorderable', () {
      var array = [1, 2, 3];
      bisect(array, new Date(NaN)); // who knows what this will return!
      bisect(array, undefined);
      bisect(array, NaN);
    });
    test('observes the optional lower bound', () {
      var array = [1, 2, 3, 4, 5];
      expect(bisect(array, 0, 2), equals(2));
      expect(bisect(array, 1, 2), equals(2));
      expect(bisect(array, 2, 2), equals(2));
      expect(bisect(array, 3, 2), equals(2));
      expect(bisect(array, 4, 2), equals(3));
      expect(bisect(array, 5, 2), equals(4));
      expect(bisect(array, 6, 2), equals(5));
    });
    test('observes the optional bounds', () {
      var array = [1, 2, 3, 4, 5];
      expect(bisect(array, 0, 2, 3), equals(2));
      expect(bisect(array, 1, 2, 3), equals(2));
      expect(bisect(array, 2, 2, 3), equals(2));
      expect(bisect(array, 3, 2, 3), equals(2));
      expect(bisect(array, 4, 2, 3), equals(3));
      expect(bisect(array, 5, 2, 3), equals(3));
      expect(bisect(array, 6, 2, 3), equals(3));
    });
    test('large arrays', () {
      var array = [],
          i = i30;
      array[i++] = 1;
      array[i++] = 2;
      array[i++] = 3;
      array[i++] = 4;
      array[i++] = 5;
      expect(bisect(array, 0, i - 5, i), equals(i - 5));
      expect(bisect(array, 1, i - 5, i), equals(i - 5));
      expect(bisect(array, 2, i - 5, i), equals(i - 4));
      expect(bisect(array, 3, i - 5, i), equals(i - 3));
      expect(bisect(array, 4, i - 5, i), equals(i - 2));
      expect(bisect(array, 5, i - 5, i), equals(i - 1));
      expect(bisect(array, 6, i - 5, i), equals(i - 0));
    });
  });
  group('bisectRight', () {
    var bisect = load('arrays/bisect').expression('d3.bisectRight');
    test('finds the index after an exact match', () {
      var array = [1, 2, 3];
      expect(bisect(array, 1), equals(1));
      expect(bisect(array, 2), equals(2));
      expect(bisect(array, 3), equals(3));
    });
    test('finds the index after the last match', () {
      var array = [1, 2, 2, 3];
      expect(bisect(array, 1), equals(1));
      expect(bisect(array, 2), equals(3));
      expect(bisect(array, 3), equals(4));
    });
    test('finds the insertion point of a non-exact match', () {
      var array = [1, 2, 3];
      expect(bisect(array, 0.5), equals(0));
      expect(bisect(array, 1.5), equals(1));
      expect(bisect(array, 2.5), equals(2));
      expect(bisect(array, 3.5), equals(3));
    });
    test('observes the optional lower bound', () {
      var array = [1, 2, 3, 4, 5];
      expect(bisect(array, 0, 2), equals(2));
      expect(bisect(array, 1, 2), equals(2));
      expect(bisect(array, 2, 2), equals(2));
      expect(bisect(array, 3, 2), equals(3));
      expect(bisect(array, 4, 2), equals(4));
      expect(bisect(array, 5, 2), equals(5));
      expect(bisect(array, 6, 2), equals(5));
    });
    test('observes the optional bounds', () {
      var array = [1, 2, 3, 4, 5];
      expect(bisect(array, 0, 2, 3), equals(2));
      expect(bisect(array, 1, 2, 3), equals(2));
      expect(bisect(array, 2, 2, 3), equals(2));
      expect(bisect(array, 3, 2, 3), equals(3));
      expect(bisect(array, 4, 2, 3), equals(3));
      expect(bisect(array, 5, 2, 3), equals(3));
      expect(bisect(array, 6, 2, 3), equals(3));
    });
    test('large arrays', () {
      var array = [], i = i30;
      array[i++] = 1;
      array[i++] = 2;
      array[i++] = 3;
      array[i++] = 4;
      array[i++] = 5;
      expect(bisect(array, 0, i - 5, i), equals(i - 5));
      expect(bisect(array, 1, i - 5, i), equals(i - 4));
      expect(bisect(array, 2, i - 5, i), equals(i - 3));
      expect(bisect(array, 3, i - 5, i), equals(i - 2));
      expect(bisect(array, 4, i - 5, i), equals(i - 1));
      expect(bisect(array, 5, i - 5, i), equals(i - 0));
      expect(bisect(array, 6, i - 5, i), equals(i - 0));
    });
  });
  group('bisector(key)', () {
    var bisector = load('arrays/bisect').expression('d3.bisector');
    group('left', () {
      var bisect = (bisector) {
        return bisector((d) { return d.key; }).left;
      };
      test('finds the index of an exact match', () {
        var array = [{key: 1}, {key: 2}, {key: 3}];
        expect(bisect(array, 1), equals(0));
        expect(bisect(array, 2), equals(1));
        expect(bisect(array, 3), equals(2));
      });
      test('finds the index of the first match', () {
        var array = [{key: 1}, {key: 2}, {key: 2}, {key: 3}];
        expect(bisect(array, 1), equals(0));
        expect(bisect(array, 2), equals(1));
        expect(bisect(array, 3), equals(3));
      });
      test('finds the insertion point of a non-exact match', () {
        var array = [{key: 1}, {key: 2}, {key: 3}];
        expect(bisect(array, 0.5), equals(0));
        expect(bisect(array, 1.5), equals(1));
        expect(bisect(array, 2.5), equals(2));
        expect(bisect(array, 3.5), equals(3));
      });
      test('observes the optional lower bound', () {
        var array = [{key: 1}, {key: 2}, {key: 3}, {key: 4}, {key: 5}];
        expect(bisect(array, 0, 2), equals(2));
        expect(bisect(array, 1, 2), equals(2));
        expect(bisect(array, 2, 2), equals(2));
        expect(bisect(array, 3, 2), equals(2));
        expect(bisect(array, 4, 2), equals(3));
        expect(bisect(array, 5, 2), equals(4));
        expect(bisect(array, 6, 2), equals(5));
      });
      test('observes the optional bounds', () {
        var array = [{key: 1}, {key: 2}, {key: 3}, {key: 4}, {key: 5}];
        expect(bisect(array, 0, 2, 3), equals(2));
        expect(bisect(array, 1, 2, 3), equals(2));
        expect(bisect(array, 2, 2, 3), equals(2));
        expect(bisect(array, 3, 2, 3), equals(2));
        expect(bisect(array, 4, 2, 3), equals(3));
        expect(bisect(array, 5, 2, 3), equals(3));
        expect(bisect(array, 6, 2, 3), equals(3));
      });
      test('large arrays', () {
        var array = [],
            i = i30;
        array[i++] = {key: 1};
        array[i++] = {key: 2};
        array[i++] = {key: 3};
        array[i++] = {key: 4};
        array[i++] = {key: 5};
        expect(bisect(array, 0, i - 5, i), equals(i - 5));
        expect(bisect(array, 1, i - 5, i), equals(i - 5));
        expect(bisect(array, 2, i - 5, i), equals(i - 4));
        expect(bisect(array, 3, i - 5, i), equals(i - 3));
        expect(bisect(array, 4, i - 5, i), equals(i - 2));
        expect(bisect(array, 5, i - 5, i), equals(i - 1));
        expect(bisect(array, 6, i - 5, i), equals(i - 0));
      });
    });
    group('right', () {
      var bisect = (bisector) {
        return bisector((d) { return d.key; }).right;
      };
      test('finds the index after an exact match', () {
        var array = [{key: 1}, {key: 2}, {key: 3}];
        expect(bisect(array, 1), equals(1));
        expect(bisect(array, 2), equals(2));
        expect(bisect(array, 3), equals(3));
      });
      test('finds the index after the last match', () {
        var array = [{key: 1}, {key: 2}, {key: 2}, {key: 3}];
        expect(bisect(array, 1), equals(1));
        expect(bisect(array, 2), equals(3));
        expect(bisect(array, 3), equals(4));
      });
      test('finds the insertion point of a non-exact match', () {
        var array = [{key: 1}, {key: 2}, {key: 3}];
        expect(bisect(array, 0.5), equals(0));
        expect(bisect(array, 1.5), equals(1));
        expect(bisect(array, 2.5), equals(2));
        expect(bisect(array, 3.5), equals(3));
      });
      test('observes the optional lower bound', () {
        var array = [{key: 1}, {key: 2}, {key: 3}, {key: 4}, {key: 5}];
        expect(bisect(array, 0, 2), equals(2));
        expect(bisect(array, 1, 2), equals(2));
        expect(bisect(array, 2, 2), equals(2));
        expect(bisect(array, 3, 2), equals(3));
        expect(bisect(array, 4, 2), equals(4));
        expect(bisect(array, 5, 2), equals(5));
        expect(bisect(array, 6, 2), equals(5));
      });
      test('observes the optional bounds', () {
        var array = [{key: 1}, {key: 2}, {key: 3}, {key: 4}, {key: 5}];
        expect(bisect(array, 0, 2, 3), equals(2));
        expect(bisect(array, 1, 2, 3), equals(2));
        expect(bisect(array, 2, 2, 3), equals(2));
        expect(bisect(array, 3, 2, 3), equals(3));
        expect(bisect(array, 4, 2, 3), equals(3));
        expect(bisect(array, 5, 2, 3), equals(3));
        expect(bisect(array, 6, 2, 3), equals(3));
      });
      test('large arrays', () {
        var array = [],
            i = i30;
        array[i++] = {key: 1};
        array[i++] = {key: 2};
        array[i++] = {key: 3};
        array[i++] = {key: 4};
        array[i++] = {key: 5};
        expect(bisect(array, 0, i - 5, i), equals(i - 5));
        expect(bisect(array, 1, i - 5, i), equals(i - 4));
        expect(bisect(array, 2, i - 5, i), equals(i - 3));
        expect(bisect(array, 3, i - 5, i), equals(i - 2));
        expect(bisect(array, 4, i - 5, i), equals(i - 1));
        expect(bisect(array, 5, i - 5, i), equals(i - 0));
        expect(bisect(array, 6, i - 5, i), equals(i - 0));
      });
    });
  });
}