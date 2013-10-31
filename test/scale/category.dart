import 'package:unittest/unittest.dart';

import '../../src/scale/scale.dart' as d4;

void main() {
  group('category', () {
    var category = load('scale/category').expression('d3.scale'); 
    test('category10', category('category10', 10));
    test('category20', category('category20', 20));
    test('category20b', category('category20b', 20));
    test('category20c', category('category20c', 20));
  });
}

category(String category, int n) {
  return () {
    test('is an ordinal scale', () {
      var x = scale[category](), colors = x.range();
      expect(x.domain().length, equals(0));
      expect(x.range().length, equals(n));
      expect(x(1), equals(colors[0]));
      expect(x(2), equals(colors[1]));
      expect(x(1), equals(colors[0]));
      var y = x.copy();
      expect(y.domain(), equals(x.domain()));
      expect(y.range(), equals(x.range()));
      x.domain(_.range(n));
      for (var i = 0; i < n; ++i) expect(x(i + n), equals(x(i)));
      expect(y(1), equals(colors[0]));
      expect(y(2), equals(colors[1]));
    });
    test('each instance is isolated', () {
      var a = scale[category](), b = scale[category](), colors = a.range();
      expect(a(1), colors[0]);
      expect(b(2), colors[0]);
      expect(b(1), colors[1]);
      expect(a(1), colors[0]);
    });
    test('contains the expected number of values in the range', () {
      var x = scale[category]();
      expect(x.range().length, equals(n));
    });
    test('each range value is distinct', () {
      var m = {}, count = 0, x = scale[category]();
      x.range().forEach((v) {
        if (!(m.containsKey(v))) {
          m[v] = ++count;
        }
      });
      expect(count, x.range().length);
    });
    test('each range value is a hexadecimal color', () {
      var x = scale[category]();
      x.range().forEach((v) {
        expect(v, '#[0-9a-f]{6}', match);
        v = _.rgb(v);
        expect(isNaN(v.r), isFalse);
        expect(isNaN(v.g), isFalse);
        expect(isNaN(v.b), isFalse);
      });
    });
    test('no range values are very dark or very light', () {
      var x = scale[category]();
      x.range().forEach((v) {
        var c = _.hsl(v);
        expect(c.l >= .34, isTrue, 'expected ' + v + ' to be lighter (l = ' + c.l + ')');
        expect(c.l <= .89, isTrue, 'expected ' + v + ' to be darker (l = ' + c.l + ')');
      });
    });
  };
}