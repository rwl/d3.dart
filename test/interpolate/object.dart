import 'package:unittest/unittest.dart';

import '../../src/interpolate/interpolate.dart' as d4;

void main() {
  group('interpolateObject', () {
    var interpolate = load('interpolate/object').expression('d3.interpolateObject');
    test('interpolates defined properties', () {
      expect(interpolate({a: 2, b: 12}, {a: 4, b: 24})(.5), equals({a: 3, b: 18}));
    });
    test('interpolates inherited properties', () {
      a(a) { this.a = a; }
      a.prototype.b = 12;
      expect(interpolate(new a(2), new a(4))(.5), equals({a: 3, b: 12}));
    });
    test('interpolates color properties as rgb', () {
      expect(interpolate({background: 'red'}, {background: 'green'})(.5), equals({background: '#804000'}));
      expect(interpolate({fill: 'red'}, {fill: 'green'})(.5), equals({fill: '#804000'}));
      expect(interpolate({stroke: 'red'}, {stroke: 'green'})(.5), equals({stroke: '#804000'}));
      expect(interpolate({color: 'red'}, {color: 'green'})(.5), equals({color: '#804000'}));
    });
    test('interpolates nested objects and arrays', () {
      expect(interpolate({foo: [2, 12]}, {foo: [4, 24]})(.5), equals({foo: [3, 18]}));
      expect(interpolate({foo: {bar: [2, 12]}}, {foo: {bar: [4, 24]}})(.5), equals({foo: {bar: [3, 18]}}));
    });
    test('merges non-shared properties', () {
      expect(interpolate({foo: 2}, {foo: 4, bar: 12})(.5), equals({foo: 3, bar: 12}));
      expect(interpolate({foo: 2, bar: 12}, {foo: 4})(.5), equals({foo: 3, bar: 12}));
    });
  });
}
