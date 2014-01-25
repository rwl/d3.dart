import 'package:unittest/unittest.dart';
import 'package:d3/interpolate/interpolate.dart' as libInterpolate;

void main() {
  group('interpolateString', () {
    final Function interpolate = libInterpolate.interpolateString;
    test('interpolates matching numbers in both strings', () {
      expect(interpolate(' 10/20 30', '50/10 100 ')(.2), equals('18.0/18.0 44.0 ')); // FIXME: number
      expect(interpolate(' 10/20 30', '50/10 100 ')(.4), equals('26.0/16.0 58.0 '));
    });
    /*test('coerces objects to strings', () {
      expect(interpolate({toString: () { return '2px'; }}, {toString: () { return '12px'; }})(.4), same('6px'));
    });
    test('preserves non-numbers in string b', () {
      expect(interpolate(' 10/20 30', '50/10 foo ')(.2), same('18/18 foo '));
      expect(interpolate(' 10/20 30', '50/10 foo ')(.4), same('26/16 foo '));
    });
    test('preserves non-matching numbers in string b', () {
      expect(interpolate(' 10/20 foo', '50/10 100 ')(.2), same('18/18 100 '));
      expect(interpolate(' 10/20 bar', '50/10 100 ')(.4), same('26/16 100 '));
    });
    test('preserves equal-value numbers in both strings', () {
      expect(interpolate(' 10/20 100 20', '50/10 100, 20 ')(.2), same('18/18 100, 20 '));
      expect(interpolate(' 10/20 100 20', '50/10 100, 20 ')(.4), same('26/16 100, 20 '));
    });
    test('interpolates decimal notation correctly', () {
      expect(interpolate('1.', '2.')(.5), same('1.5'));
    });
    test('interpolates exponent notation correctly', () {
      expect(interpolate('1e+3', '1e+4')(.5), same('5500'));
      expect(interpolate('1e-3', '1e-4')(.5), same('0.00055'));
      expect(interpolate('1.e-3', '1.e-4')(.5), same('0.00055'));
      expect(interpolate('-1.e-3', '-1.e-4')(.5), same('-0.00055'));
      expect(interpolate('+1.e-3', '+1.e-4')(.5), same('0.00055'));
      expect(interpolate('.1e-2', '.1e-3')(.5), same('0.00055'));
    });*/
  });
}