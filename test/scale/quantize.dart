import 'package:unittest/unittest.dart';

import '../../src/scale/scale.dart' as d4;

void main() {
  group('quantize', () {
    var quantize = load('scale/quantize').expression('d3.scale.quantize');
    test('has the default domain [0, 1]', () {
      var x = quantize();
      expect(x.domain(), equals([0, 1]);
      expect(x(.25), equals(0));
    });
    test('has the default range [0, 1]', () {
      var x = quantize();
      expect(x.range(), equals([0, 1]));
      expect(x(.75), equals(1));
    });
    test('maps a number to a discrete value in the range', () {
      var x = quantize().range([0, 1, 2]);
      expect(x(0), equals(0));
      expect(x(.2), equals(0));
      expect(x(.4), equals(1));
      expect(x(.6), equals(1));
      expect(x(.8), equals(2));
      expect(x(1), equals(2));
    });
    test('coerces domain to numbers', () {
      var x = quantize().domain(['0', '100']);
      expect(x.domain()[0], same(0));
      expect(x.domain()[1], same(100));
    });
    test('only considers the extent of the domain', () {
      var x = quantize().domain([-1, 0, 100]);
      expect(x.domain(), equals([-1, 100]));
    });
    test('clamps input values to the domain', () {
      var a = {}, b = {}, c = {}, x = quantize().range([a, b, c]);
      expect(x(-.5), equals(a));
      expect(x(1.5), equals(c));
    });
    test('range cardinality determines the degree of quantization', () {
      var x = quantize();
      expect(x.range(_.range(0, 1.001, .001))(1/3), inDelta(.333, 1e-6));
      expect(x.range(_.range(0, 1.01, .01))(1/3), inDelta(.33, 1e-6));
      expect(x.range(_.range(0, 1.1, .1))(1/3), inDelta(.3, 1e-6));
      expect(x.range(_.range(0, 1.2, .2))(1/3), inDelta(.4, 1e-6));
      expect(x.range(_.range(0, 1.25, .25))(1/3), inDelta(.25, 1e-6));
      expect(x.range(_.range(0, 1.5, .5))(1/3), inDelta(.5, 1e-6));
      expect(x.range(_.range(1))(1/3), inDelta(0, 1e-6));
    });
    test('range values are arbitrary', () {
      var a = {}, b = {}, c = {}, x = quantize().range([a, b, c]);
      expect(x(0), equals(a));
      expect(x(.2), equals(a));
      expect(x(.4), equals(b));
      expect(x(.6), equals(b));
      expect(x(.8), equals(c));
      expect(x(1), equals(c));
    });
    group('invertExtent', () {
      test('maps a value in the range to a domain extent', () {
        var x = quantize().range([0, 1, 2, 3]);
        expect(x.invertExtent(0), equals([0, .25]));
        expect(x.invertExtent(1), equals([.25, .5]));
        expect(x.invertExtent(2), equals([.5, .75]));
        expect(x.invertExtent(3), equals([.75, 1]));
      });
      test('allows arbitrary range values', () {
        var a = {}, b = {}, x = quantize().range([a, b]);
        expect(x.invertExtent(a), equals([0, .5]));
        expect(x.invertExtent(b), equals([.5, 1]));
      });
      test('returns [NaN, NaN] when the given value is not in the range', () {
        var x = quantize();
        expect(x.invertExtent(-1).every(isNaN), ok);
        expect(x.invertExtent(.5).every(isNaN), ok);
        expect(x.invertExtent(2).every(isNaN), ok);
        expect(x.invertExtent('a').every(isNaN), ok);
      });
      test('returns the first match if duplicate values exist in the range', () {
        var x = quantize().range([0, 1, 2, 0]);
        expect(x.invertExtent(0), equals([0, .25]));
        expect(x.invertExtent(1), equals([.25, .5]));
      });
    });
  });
}
