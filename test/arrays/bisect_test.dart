import 'package:unittest/unittest.dart';
import 'package:d3/arrays/arrays.dart';

const i30 = 1 << 30;

void main() {
  group('bisectLeft', () {
    test('finds the index of an exact match', () {
      List array = [1, 2, 3];
      expect(bisectLeft(array, 1), equals(0));
      expect(bisectLeft(array, 2), equals(1));
      expect(bisectLeft(array, 3), equals(2));
    });
    test('finds the index of the first match', () {
      var array = [1, 2, 2, 3];
      expect(bisectLeft(array, 1), equals(0));
      expect(bisectLeft(array, 2), equals(1));
      expect(bisectLeft(array, 3), equals(3));
    });
    test('finds the insertion point of a non-exact match', () {
      var array = [1, 2, 3];
      expect(bisectLeft(array, 0.5), equals(0));
      expect(bisectLeft(array, 1.5), equals(1));
      expect(bisectLeft(array, 2.5), equals(2));
      expect(bisectLeft(array, 3.5), equals(3));
    });
    /*test('has undefined behavior if the search value is unorderable', () {
      var array = [1, 2, 3];
      bisectLeft(array, new DateTime(double.NAN)); // who knows what this will return!
      bisectLeft(array, null);
      bisectLeft(array, double.NaN);
    });*/
    test('observes the optional lower bound', () {
      var array = [1, 2, 3, 4, 5];
      expect(bisectLeft(array, 0, lo: 2), equals(2));
      expect(bisectLeft(array, 1, lo: 2), equals(2));
      expect(bisectLeft(array, 2, lo: 2), equals(2));
      expect(bisectLeft(array, 3, lo: 2), equals(2));
      expect(bisectLeft(array, 4, lo: 2), equals(3));
      expect(bisectLeft(array, 5, lo: 2), equals(4));
      expect(bisectLeft(array, 6, lo: 2), equals(5));
    });
    test('observes the optional bounds', () {
      var array = [1, 2, 3, 4, 5];
      expect(bisectLeft(array, 0, lo: 2, hi: 3), equals(2));
      expect(bisectLeft(array, 1, lo: 2, hi: 3), equals(2));
      expect(bisectLeft(array, 2, lo: 2, hi: 3), equals(2));
      expect(bisectLeft(array, 3, lo: 2, hi: 3), equals(2));
      expect(bisectLeft(array, 4, lo: 2, hi: 3), equals(3));
      expect(bisectLeft(array, 5, lo: 2, hi: 3), equals(3));
      expect(bisectLeft(array, 6, lo: 2, hi: 3), equals(3));
    });
    /*test('large arrays', () {
      List<int> array = new List(i30 + 5);
      int i = i30;
      array[i++] = 1;
      array[i++] = 2;
      array[i++] = 3;
      array[i++] = 4;
      array[i++] = 5;
      expect(bisectLeft(array, 0, lo: i - 5, hi: i), equals(i - 5));
      expect(bisectLeft(array, 1, lo: i - 5, hi: i), equals(i - 5));
      expect(bisectLeft(array, 2, lo: i - 5, hi: i), equals(i - 4));
      expect(bisectLeft(array, 3, lo: i - 5, hi: i), equals(i - 3));
      expect(bisectLeft(array, 4, lo: i - 5, hi: i), equals(i - 2));
      expect(bisectLeft(array, 5, lo: i - 5, hi: i), equals(i - 1));
      expect(bisectLeft(array, 6, lo: i - 5, hi: i), equals(i - 0));
    });*/
    });
  group('bisect', () {
//    var bisect = load('arrays/bisect').expression('d3.bisect');
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
      expect(bisect(array, 0, lo: 2), equals(2));
      expect(bisect(array, 1, lo: 2), equals(2));
      expect(bisect(array, 2, lo: 2), equals(2));
      expect(bisect(array, 3, lo: 2), equals(3));
      expect(bisect(array, 4, lo: 2), equals(4));
      expect(bisect(array, 5, lo: 2), equals(5));
      expect(bisect(array, 6, lo: 2), equals(5));
    });
    test('observes the optional bounds', () {
      var array = [1, 2, 3, 4, 5];
      expect(bisect(array, 0, lo: 2, hi: 3), equals(2));
      expect(bisect(array, 1, lo: 2, hi: 3), equals(2));
      expect(bisect(array, 2, lo: 2, hi: 3), equals(2));
      expect(bisect(array, 3, lo: 2, hi: 3), equals(3));
      expect(bisect(array, 4, lo: 2, hi: 3), equals(3));
      expect(bisect(array, 5, lo: 2, hi: 3), equals(3));
      expect(bisect(array, 6, lo: 2, hi: 3), equals(3));
    });
    /*test('large arrays', () {
      List<int> array = new List(i30 + 5);
      int i = i30;
      array[i++] = 1;
      array[i++] = 2;
      array[i++] = 3;
      array[i++] = 4;
      array[i++] = 5;
      expect(bisect(array, 0, lo: i - 5, hi: i), equals(i - 5));
      expect(bisect(array, 1, lo: i - 5, hi: i), equals(i - 4));
      expect(bisect(array, 2, lo: i - 5, hi: i), equals(i - 3));
      expect(bisect(array, 3, lo: i - 5, hi: i), equals(i - 2));
      expect(bisect(array, 4, lo: i - 5, hi: i), equals(i - 1));
      expect(bisect(array, 5, lo: i - 5, hi: i), equals(i - 0));
      expect(bisect(array, 6, lo: i - 5, hi: i), equals(i - 0));
    });*/
  });
  group('bisector(key)', () {
    group('left', () {
      Function f = (List a, Map d, int mid) { return d['key']; };
      test('finds the index of an exact match', () {
        List<Map> array = [{'key': 1}, {'key': 2}, {'key': 3}];
        expect(bisectLeft(array, 1, f: f), equals(0));
        expect(bisectLeft(array, 2, f: f), equals(1));
        expect(bisectLeft(array, 3, f: f), equals(2));
      });
      test('finds the index of the first match', () {
        List<Map> array = [{'key': 1}, {'key': 2}, {'key': 2}, {'key': 3}];
        expect(bisectLeft(array, 1, f: f), equals(0));
        expect(bisectLeft(array, 2, f: f), equals(1));
        expect(bisectLeft(array, 3, f: f), equals(3));
      });
      test('finds the insertion point of a non-exact match', () {
        List<Map> array = [{'key': 1}, {'key': 2}, {'key': 3}];
        expect(bisectLeft(array, 0.5, f: f), equals(0));
        expect(bisectLeft(array, 1.5, f: f), equals(1));
        expect(bisectLeft(array, 2.5, f: f), equals(2));
        expect(bisectLeft(array, 3.5, f: f), equals(3));
      });
      test('observes the optional lower bound', () {
        List<Map> array = [{'key': 1}, {'key': 2}, {'key': 3}, {'key': 4}, {'key': 5}];
        expect(bisectLeft(array, 0, lo: 2, f: f), equals(2));
        expect(bisectLeft(array, 1, lo: 2, f: f), equals(2));
        expect(bisectLeft(array, 2, lo: 2, f: f), equals(2));
        expect(bisectLeft(array, 3, lo: 2, f: f), equals(2));
        expect(bisectLeft(array, 4, lo: 2, f: f), equals(3));
        expect(bisectLeft(array, 5, lo: 2, f: f), equals(4));
        expect(bisectLeft(array, 6, lo: 2, f: f), equals(5));
      });
      test('observes the optional bounds', () {
        List<Map> array = [{'key': 1}, {'key': 2}, {'key': 3}, {'key': 4}, {'key': 5}];
        expect(bisectLeft(array, 0, lo: 2, hi: 3, f: f), equals(2));
        expect(bisectLeft(array, 1, lo: 2, hi: 3, f: f), equals(2));
        expect(bisectLeft(array, 2, lo: 2, hi: 3, f: f), equals(2));
        expect(bisectLeft(array, 3, lo: 2, hi: 3, f: f), equals(2));
        expect(bisectLeft(array, 4, lo: 2, hi: 3, f: f), equals(3));
        expect(bisectLeft(array, 5, lo: 2, hi: 3, f: f), equals(3));
        expect(bisectLeft(array, 6, lo: 2, hi: 3, f: f), equals(3));
      });
      /*test('large arrays', () {
        List<Map> array = new List<Map>(i30 + 5);
        int i = i30;
        array[i++] = {'key': 1};
        array[i++] = {'key': 2};
        array[i++] = {'key': 3};
        array[i++] = {'key': 4};
        array[i++] = {'key': 5};
        expect(bisectLeft(array, 0, lo: i - 5, hi: i, f: f), equals(i - 5));
        expect(bisectLeft(array, 1, lo: i - 5, hi: i, f: f), equals(i - 5));
        expect(bisectLeft(array, 2, lo: i - 5, hi: i, f: f), equals(i - 4));
        expect(bisectLeft(array, 3, lo: i - 5, hi: i, f: f), equals(i - 3));
        expect(bisectLeft(array, 4, lo: i - 5, hi: i, f: f), equals(i - 2));
        expect(bisectLeft(array, 5, lo: i - 5, hi: i, f: f), equals(i - 1));
        expect(bisectLeft(array, 6, lo: i - 5, hi: i, f: f), equals(i - 0));
      });*/
    });
    group('right', () {
      Function f = (List a, Map d, int mid) { return d['key']; };
      test('finds the index after an exact match', () {
        List<Map> array = [{'key': 1}, {'key': 2}, {'key': 3}];
        expect(bisect(array, 1, f: f), equals(1));
        expect(bisect(array, 2, f: f), equals(2));
        expect(bisect(array, 3, f: f), equals(3));
      });
      test('finds the index after the last match', () {
        List<Map> array = [{'key': 1}, {'key': 2}, {'key': 2}, {'key': 3}];
        expect(bisect(array, 1, f: f), equals(1));
        expect(bisect(array, 2, f: f), equals(3));
        expect(bisect(array, 3, f: f), equals(4));
      });
      test('finds the insertion point of a non-exact match', () {
        List<Map> array = [{'key': 1}, {'key': 2}, {'key': 3}];
        expect(bisect(array, 0.5, f: f), equals(0));
        expect(bisect(array, 1.5, f: f), equals(1));
        expect(bisect(array, 2.5, f: f), equals(2));
        expect(bisect(array, 3.5, f: f), equals(3));
      });
      test('observes the optional lower bound', () {
        List<Map> array = [{'key': 1}, {'key': 2}, {'key': 3}, {'key': 4}, {'key': 5}];
        expect(bisect(array, 0, lo: 2, f: f), equals(2));
        expect(bisect(array, 1, lo: 2, f: f), equals(2));
        expect(bisect(array, 2, lo: 2, f: f), equals(2));
        expect(bisect(array, 3, lo: 2, f: f), equals(3));
        expect(bisect(array, 4, lo: 2, f: f), equals(4));
        expect(bisect(array, 5, lo: 2, f: f), equals(5));
        expect(bisect(array, 6, lo: 2, f: f), equals(5));
      });
      test('observes the optional bounds', () {
        List<Map> array = [{'key': 1}, {'key': 2}, {'key': 3}, {'key': 4}, {'key': 5}];
        expect(bisect(array, 0, lo: 2, hi: 3, f: f), equals(2));
        expect(bisect(array, 1, lo: 2, hi: 3, f: f), equals(2));
        expect(bisect(array, 2, lo: 2, hi: 3, f: f), equals(2));
        expect(bisect(array, 3, lo: 2, hi: 3, f: f), equals(3));
        expect(bisect(array, 4, lo: 2, hi: 3, f: f), equals(3));
        expect(bisect(array, 5, lo: 2, hi: 3, f: f), equals(3));
        expect(bisect(array, 6, lo: 2, hi: 3, f: f), equals(3));
      });
      /*test('large arrays', () {
        List<Map> array = new List(i30 + 5);
        int i = i30;
        array[i++] = {'key': 1};
        array[i++] = {'key': 2};
        array[i++] = {'key': 3};
        array[i++] = {'key': 4};
        array[i++] = {'key': 5};
        expect(bisect(array, 0, lo: i - 5, hi: i, f: f), equals(i - 5));
        expect(bisect(array, 1, lo: i - 5, hi: i, f: f), equals(i - 4));
        expect(bisect(array, 2, lo: i - 5, hi: i, f: f), equals(i - 3));
        expect(bisect(array, 3, lo: i - 5, hi: i, f: f), equals(i - 2));
        expect(bisect(array, 4, lo: i - 5, hi: i, f: f), equals(i - 1));
        expect(bisect(array, 5, lo: i - 5, hi: i, f: f), equals(i - 0));
        expect(bisect(array, 6, lo: i - 5, hi: i, f: f), equals(i - 0));
      });*/
    });
  });
}