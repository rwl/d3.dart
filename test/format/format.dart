import 'package:unittest/unittest.dart';

import '../../src/format/format.dart' as d4;

void main() {
  group('format', () {
    var format = load('format/format').expression('d3.format'));
    test('returns a string', () {
      expect(format('d')(0), new isInstanceOf<String>());
    });
    test('can zero fill', () {
      var f = format('08d');
      expect(f(0), same('00000000'));
      expect(f(42), same('00000042'));
      expect(f(42000000), same('42000000'));
      expect(f(420000000), same('420000000'));
      expect(f(-4), same('-0000004'));
      expect(f(-42), same('-0000042'));
      expect(f(-4200000), same('-4200000'));
      expect(f(-42000000), same('-42000000'));
    });
    test('can space fill', () {
      var f = format('8d');
      expect(f(0), same('       0'));
      expect(f(42), same('      42'));
      expect(f(42000000), same('42000000'));
      expect(f(420000000), same('420000000'));
      expect(f(-4), same('      -4'));
      expect(f(-42), same('     -42'));
      expect(f(-4200000), same('-4200000'));
      expect(f(-42000000), same('-42000000'));
    });
    test('can output fixed-point notation', () {
      expect(format('.1f')(0.49), same('0.5'));
      expect(format('.2f')(0.449), same('0.45'));
      expect(format('.3f')(0.4449), same('0.445'));
      expect(format('.5f')(0.444449), same('0.44445'));
      expect(format('.1f')(100), same('100.0'));
      expect(format('.2f')(100), same('100.00'));
      expect(format('.3f')(100), same('100.000'));
      expect(format('.5f')(100), same('100.00000'));
    });
    test('can output general notation', () {
      expect(format('.1g')(0.049), same('0.05'));
      expect(format('.1g')(0.49), same('0.5'));
      expect(format('.2g')(0.449), same('0.45'));
      expect(format('.3g')(0.4449), same('0.445'));
      expect(format('.5g')(0.444449), same('0.44445'));
      expect(format('.1g')(100), same('1e+2'));
      expect(format('.2g')(100), same('1.0e+2'));
      expect(format('.3g')(100), same('100'));
      expect(format('.5g')(100), same('100.00'));
      expect(format('.5g')(100.2), same('100.20'));
      expect(format('.2g')(0.002), same('0.0020'));
    });
    test('can output exponent notation ', () {
      var f = format('e');
      expect(f(0), same('0e+0'));
      expect(f(42), same('4.2e+1'));
      expect(f(42000000), same('4.2e+7'));
      expect(f(420000000), same('4.2e+8'));
      expect(f(-4), same('-4e+0'));
      expect(f(-42), same('-4.2e+1'));
      expect(f(-4200000), same('-4.2e+6'));
      expect(f(-42000000), same('-4.2e+7'));
    });
    test('can output SI prefix notation', () {
      var f = format('s');
      expect(f(0), same('0'));
      expect(f(1), same('1'));
      expect(f(10), same('10'));
      expect(f(100), same('100'));
      expect(f(999.5), same('999.5'));
      expect(f(999500), same('999.5k'));
      expect(f(1000), same('1k'));
      expect(f(1400), same('1.4k'));
      expect(f(1500.5), same('1.5005k'));
      expect(f(.000001), same('1µ'));
    });
    test('can output SI prefix notation with appropriate rounding', () {
      var f = format('.3s');
      expect(f(0), same('0.00'));
      expect(f(1), same('1.00'));
      expect(f(10), same('10.0'));
      expect(f(100), same('100'));
      expect(f(999.5), same('1.00k'));
      expect(f(999500), same('1.00M'));
      expect(f(1000), same('1.00k'));
      expect(f(1500.5), same('1.50k'));
      expect(f(145500000), same('146M'));
      expect(f(145999999.999999347), same('146M'));
      expect(f(1e26), same('100Y'));
      expect(f(.000001), same('1.00µ'));
      expect(f(.009995), same('0.0100'));
      var f = format('.4s');
      expect(f(999.5), same('999.5'));
      expect(f(999500), same('999.5k'));
      expect(f(.009995), same('9.995m'));
    });
    test('can output a currency', () {
      var f = format('\$');
      expect(f(0), same('\$0'));
      expect(f(.042), same('\$0.042'));
      expect(f(.42), same('\$0.42'));
      expect(f(4.2), same('\$4.2'));
      expect(f(-.042), same('-\$0.042'));
      expect(f(-.42), same('-\$0.42'));
      expect(f(-4.2), same('-\$4.2'));
    });
    test('can output a currency with comma-grouping and sign', () {
      var f = format('+\$,.2f');
      expect(f(0), same('+\$0.00'));
      expect(f(0.429), same('+\$0.43'));
      expect(f(-0.429), same('-\$0.43'));
      expect(f(-1), same('-\$1.00'));
      expect(f(1e4), same('+\$10,000.00'));
    });
    test('can output a currency with si-prefix notation', () {
      var f = format('\$.2s');
      expect(f(0), same('\$0.0'));
      expect(f(2.5e5), same('\$250k'));
      expect(f(-2.5e8), same('-\$250M'));
      expect(f(2.5e11), same('\$250G'));
    });
    test('can output a percentage', () {
      var f = format('%');
      expect(f(0), same('0%'));
      expect(f(.042), same('4%'));
      expect(f(.42), same('42%'));
      expect(f(4.2), same('420%'));
      expect(f(-.042), same('-4%'));
      expect(f(-.42), same('-42%'));
      expect(f(-4.2), same('-420%'));
    });
    test('can output a percentage with rounding and sign', () {
      var f = format('+.2p');
      expect(f(.00123), same('+0.12%'));
      expect(f(.0123), same('+1.2%'));
      expect(f(.123), same('+12%'));
      expect(f(1.23), same('+120%'));
      expect(f(-.00123), same('-0.12%'));
      expect(f(-.0123), same('-1.2%'));
      expect(f(-.123), same('-12%'));
      expect(f(-1.23), same('-120%'));
    });
    test('can round to significant digits', () {
      expect(format('.2r')(0), same('0.0'));
      expect(format('.1r')(0.049), same('0.05'));
      expect(format('.1r')(-0.049), same('-0.05'));
      expect(format('.1r')(0.49), same('0.5'));
      expect(format('.1r')(-0.49), same('-0.5'));
      expect(format('.2r')(0.449), same('0.45'));
      expect(format('.3r')(0.4449), same('0.445'));
      expect(format('.3r')(1.00), same('1.00'));
      expect(format('.3r')(0.9995), same('1.00'));
      expect(format('.5r')(0.444449), same('0.44445'));
      expect(format('r')(123.45), same('123.45'));
      expect(format('.1r')(123.45), same('100'));
      expect(format('.2r')(123.45), same('120'));
      expect(format('.3r')(123.45), same('123'));
      expect(format('.4r')(123.45), same('123.5'));
      expect(format('.5r')(123.45), same('123.45'));
      expect(format('.6r')(123.45), same('123.450'));
      expect(format('.1r')(.9), same('0.9'));
      expect(format('.1r')(.09), same('0.09'));
      expect(format('.1r')(.949), same('0.9'));
      expect(format('.1r')(.0949), same('0.09'));
      expect(format('.10r')(.9999999999), same('0.9999999999'));
      expect(format('.15r')(.999999999999999), same('0.999999999999999'));
    });
    test('can round very small numbers', () {
      var f = format('.2r');
      expect(f(1e-22), same('0.00000000000000000000'));
    });
    test('can group thousands', () {
      var f = format(',d');
      expect(f(0), same('0'));
      expect(f(42), same('42'));
      expect(f(42000000), same('42,000,000'));
      expect(f(420000000), same('420,000,000'));
      expect(f(-4), same('-4'));
      expect(f(-42), same('-42'));
      expect(f(-4200000), same('-4,200,000'));
      expect(f(-42000000), same('-42,000,000'));
    });
    test('can group thousands and zero fill', () {
      expect(format('01,d')(0), same('0'));
      expect(format('01,d')(0), same('0'));
      expect(format('02,d')(0), same('00'));
      expect(format('03,d')(0), same('000'));
      expect(format('05,d')(0), same('0,000'));
      expect(format('08,d')(0), same('0,000,000'));
      expect(format('013,d')(0), same('0,000,000,000'));
      expect(format('021,d')(0), same('0,000,000,000,000,000'));
      expect(format('013,d')(-42000000), same('-0,042,000,000'));
    });
    test('can group thousands and zero fill with overflow', () {
      expect(format('01,d')(1), same('1'));
      expect(format('01,d')(1), same('1'));
      expect(format('02,d')(12), same('12'));
      expect(format('03,d')(123), same('123'));
      expect(format('05,d')(12345), same('12,345'));
      expect(format('08,d')(12345678), same('12,345,678'));
      expect(format('013,d')(1234567890123), same('1,234,567,890,123'));
    });
    test('can group thousands and space fill', () {
      expect(format('1,d')(0), same('0'));
      expect(format('1,d')(0), same('0'));
      expect(format('2,d')(0), same(' 0'));
      expect(format('3,d')(0), same('  0'));
      expect(format('5,d')(0), same('    0'));
      expect(format('8,d')(0), same('       0'));
      expect(format('13,d')(0), same('            0'));
      expect(format('21,d')(0), same('                    0'));
    });
    test('can group thousands and space fill with overflow', () {
      expect(format('1,d')(1), same('1'));
      expect(format('1,d')(1), same('1'));
      expect(format('2,d')(12), same('12'));
      expect(format('3,d')(123), same('123'));
      expect(format('5,d')(12345), same('12,345'));
      expect(format('8,d')(12345678), same('12,345,678'));
      expect(format('13,d')(1234567890123), same('1,234,567,890,123'));
    });
    test('can group thousands with general notation', () {
      var f = format(',g');
      expect(f(0), same('0'));
      expect(f(42), same('42'));
      expect(f(42000000), same('42,000,000'));
      expect(f(420000000), same('420,000,000'));
      expect(f(-4), same('-4'));
      expect(f(-42), same('-42'));
      expect(f(-4200000), same('-4,200,000'));
      expect(f(-42000000), same('-42,000,000'));
    });
    test('can group thousands, space fill, and round to significant digits', () {
      expect(format('10,.1f')(123456.49), same(' 123,456.5'));
      expect(format('10,.2f')(1234567.449), same('1,234,567.45'));
      expect(format('10,.3f')(12345678.4449), same('12,345,678.445'));
      expect(format('10,.5f')(123456789.444449), same('123,456,789.44445'));
      expect(format('10,.1f')(123456), same(' 123,456.0'));
      expect(format('10,.2f')(1234567), same('1,234,567.00'));
      expect(format('10,.3f')(12345678), same('12,345,678.000'));
      expect(format('10,.5f')(123456789), same('123,456,789.00000'));
    });
    test('can display integers in fixed-point notation', () {
      expect(format('f')(42), same('42'));
    });
    test('will not display non-integers in integer format', () {
      expect(format('d')(4.2), same(''));
    });
    test('unicode character', () {
      expect(format('c')(9731), same('☃'));
    });
    test('binary', () {
      expect(format('b')(10), same('1010'));
    });
    test('binary with prefix', () {
      expect(format('#b')(10), same('0b1010'));
    });
    test('octal', () {
      expect(format('o')(10), same('12'));
    });
    test('octal with prefix', () {
      expect(format('#o')(10), same('0o12'));
    });
    test('hexadecimal (lowercase)', () {
      expect(format('x')(3735928559), same('deadbeef'));
    });
    test('hexadecimal (lowercase) with prefix', () {
      expect(format('#x')(3735928559), same('0xdeadbeef'));
    });
    test('hexadecimal (uppercase)', () {
      expect(format('X')(3735928559), same('DEADBEEF'));
    });
    test('hexadecimal (uppercase) with prefix', () {
      expect(format('#X')(3735928559), same('0xDEADBEEF'));
    });
    test('fill respects prefix', () {
      expect(format('#20x')(3735928559), same('          0xdeadbeef'));
    });
    test('align left', () {
      expect(format('<1,d')(0), same('0'));
      expect(format('<1,d')(0), same('0'));
      expect(format('<2,d')(0), same('0 '));
      expect(format('<3,d')(0), same('0  '));
      expect(format('<5,d')(0), same('0    '));
      expect(format('<8,d')(0), same('0       '));
      expect(format('<13,d')(0), same('0            '));
      expect(format('<21,d')(0), same('0                    '));
    });
    test('align right', () {
      expect(format('>1,d')(0), same('0'));
      expect(format('>1,d')(0), same('0'));
      expect(format('>2,d')(0), same(' 0'));
      expect(format('>3,d')(0), same('  0'));
      expect(format('>5,d')(0), same('    0'));
      expect(format('>8,d')(0), same('       0'));
      expect(format('>13,d')(0), same('            0'));
      expect(format('>21,d')(0), same('                    0'));
    });
    test('align center', () {
      expect(format('^1,d')(0), same('0'));
      expect(format('^1,d')(0), same('0'));
      expect(format('^2,d')(0), same(' 0'));
      expect(format('^3,d')(0), same(' 0 '));
      expect(format('^5,d')(0), same('  0  '));
      expect(format('^8,d')(0), same('    0   '));
      expect(format('^13,d')(0), same('      0      '));
      expect(format('^21,d')(0), same('          0          '));
    });
    test('pad after sign', () {
      expect(format('=+1,d')(0), same('+0'));
      expect(format('=+1,d')(0), same('+0'));
      expect(format('=+2,d')(0), same('+0'));
      expect(format('=+3,d')(0), same('+ 0'));
      expect(format('=+5,d')(0), same('+   0'));
      expect(format('=+8,d')(0), same('+      0'));
      expect(format('=+13,d')(0), same('+           0'));
      expect(format('=+21,d')(0), same('+                   0'));
    });
    test('a space can denote positive numbers', () {
      expect(format(' 1,d')(-1), same('-1'));
      expect(format(' 1,d')(0), same(' 0'));
      expect(format(' 2,d')(0), same(' 0'));
      expect(format(' 3,d')(0), same('  0'));
      expect(format(' 5,d')(0), same('    0'));
      expect(format(' 8,d')(0), same('       0'));
      expect(format(' 13,d')(0), same('            0'));
      expect(format(' 21,d')(0), same('                    0'));
    });
    test('can format negative zero', () {
      expect(format('1d')(-0), same('-0'));
      expect(format('1f')(-0), same('-0'));
    });
    test('supports \'n\' as an alias for \',g\'', () {
      var f = format('n');
      expect(f(.0042), same('0.0042'));
      expect(f(.42), same('0.42'));
      expect(f(0), same('0'));
      expect(f(42), same('42'));
      expect(f(42000000), same('42,000,000'));
      expect(f(420000000), same('420,000,000'));
      expect(f(-4), same('-4'));
      expect(f(-42), same('-42'));
      expect(f(-4200000), same('-4,200,000'));
      expect(f(-42000000), same('-42,000,000'));
    });
    test('unreasonable precision values are clamped to reasonable values', () {
      expect(format('.30f')(0), same('0.00000000000000000000'));
      expect(format('.0g')(1), same('1'));
      expect(format(',.-1f')(12345), same('12,345'));
      expect(format('+,.-1%')(123.45), same('+12,345%'));
    });
  });
}
