import 'package:unittest/unittest.dart';
import 'package:d3/interpolate/interpolate.dart' as libInterpolate;

class Size {
  String s;
  Size(this.s);
  toString() => s;
}

void main() {
  group('interpolateString', () {
    final Function interpolate = libInterpolate.interpolateString;
    test('interpolates matching numbers in both strings', () {
      expect(interpolate(' 10/20 30', '50/10 100 ')(.2), equals('18.0/18.0 44.0 ')); // FIXME: number
      expect(interpolate(' 10/20 30', '50/10 100 ')(.4), equals('26.0/16.0 58.0 '));
    });
    test('coerces objects to strings', () {
      expect(interpolate(new Size('2px'), new Size('12px'))(.4), equals('6.0px'));
    });
    test('preserves non-numbers in string b', () {
      expect(interpolate(' 10/20 30', '50/10 foo ')(.2), equals('18.0/18.0 foo '));
      expect(interpolate(' 10/20 30', '50/10 foo ')(.4), equals('26.0/16.0 foo '));
    });
    test('preserves non-matching numbers in string b', () {
      expect(interpolate(' 10/20 foo', '50/10 100 ')(.2), equals('18.0/18.0 100 '));
      expect(interpolate(' 10/20 bar', '50/10 100 ')(.4), equals('26.0/16.0 100 '));
    });
    /*test('preserves equal-value numbers in both strings', () {
      expect(interpolate(' 10/20 100 20', '50/10 100, 20 ')(.2), equals('18.0/18.0 100, 20 '));
      expect(interpolate(' 10/20 100 20', '50/10 100, 20 ')(.4), equals('26.0/16.0 100, 20 '));
    });*/
    test('interpolates decimal notation correctly', () {
      expect(interpolate('1.', '2.')(.5), equals('1.5'));
    });
    test('interpolates exponent notation correctly', () {
      expect(interpolate('1e+3', '1e+4')(.5), equals('5500.0'));
      expect(interpolate('1e-3', '1e-4')(.5), equals('0.00055'));
      expect(interpolate('1.e-3', '1.e-4')(.5), equals('0.00055'));
      expect(interpolate('-1.e-3', '-1.e-4')(.5), equals('-0.00055'));
      expect(interpolate('+1.e-3', '+1.e-4')(.5), equals('0.00055'));
      expect(interpolate('.1e-2', '.1e-3')(.5), equals('0.00055'));
    });
  });
}