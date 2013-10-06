import 'package:unittest/unittest.dart';

import '../assert.dart';
import '../../src/color/color.dart' as d4;

void main() {
  group('lab', () {
    var lab = load('color/lab').expression('d3.lab');
    test('converts string channel values to numbers', () {
      expect(lab('50', '-4', '-32'), labEquals(50, -4, -32));
    });
    test('converts null channel values to zero', () {
      expect(lab(null, null, null), labEquals(0, 0, 0));
    });
    test('exposes l, a and b properties', () {
      var color = lab(50, -4, -32);
      expect(color.l, equals(50));
      expect(color.a, equals(-4));
      expect(color.b, equals(-32));
    });
    test('changing l, a or b affects the string format', () {
      var color = lab(50, -4, -32);
      expect(color + '', equals('#3f7cad'));
      color.l++;
      expect(color + '', equals('#427eb0'));
      color.a++;
      expect(color + '', equals('#467eb0'));
      color.b++;
      expect(color + '', equals('#487eae'));
    });
    test('parses hexadecimal shorthand format (e.g., \'#abc\')', () {
      expect(lab('#abc'), labEquals(75.10497524893663, -2.292114632248876, -10.528266458853786));
    });
    test('parses hexadecimal format (e.g., \'#abcdef\')', () {
      expect(lab('#abcdef'), labEquals(81.04386565274363, -3.6627002800885267, -20.442705201854984));
    });
    test('parses HSL format (e.g., \'hsl(210, 64%, 13%)\')', () {
      expect(lab('hsl(210, 64.7058%, 13.33333%)'), labEquals(12.65624852526134, 0.12256520883417721, -16.833209795877284));
    });
    test('parses color names (e.g., \'moccasin\')', () {
      expect(lab('moccasin'), labEquals(91.72317744746022, 2.4393469358685027, 26.359832514614844));
    });
    test('parses and converts RGB format (e.g., \'rgb(102, 102, 0)\')', () {
      expect(lab('rgb(102, 102, 0)'), labEquals(41.73251953866431, -10.998411255098816, 48.21006600604577));
    });
    test('can convert from RGB', () {
      expect(lab(_.rgb(12, 34, 56)), labEquals(12.65624852526134, 0.12256520883417721, -16.833209795877284));
    });
    test('can convert from HSL', () {
      expect(lab(lab(20, .8, .3)), labEquals(20, 0.8, 0.3));
    });
    test('can convert to RGB', () {
      expect(lab('steelblue').rgb(), rgbEquals(70, 130, 180));
    });
    test('can derive a brighter color', () {
      expect(lab('steelblue').brighter(), labEquals(70.46551718768575, -4.0774710123572255, -32.19186122981343));
      expect(lab('steelblue').brighter(.5), labEquals(61.46551718768575, -4.0774710123572255, -32.19186122981343));
    });
    test('can derive a darker color', () {
      expect(lab('lightsteelblue').darker(), labEquals(60.45157936968134, -1.2815839134120433, -15.210996213841522));
      expect(lab('lightsteelblue').darker(.5), labEquals(69.45157936968134, -1.2815839134120433, -15.210996213841522));
    });
    test('string coercion returns RGB format', () {
      expect(lab('hsl(60, 100%, 20%)') + '', same('#666600'));
      expect(lab(lab(60, -4, -32)) + '', same('#5d95c8'));
    });
    test('roundtrip to HSL is idempotent', () {
      expect(_.hsl(lab('steelblue')), equals(_.hsl('steelblue')));
    });
    test('roundtrip to RGB is idempotent', () {
      expect(_.rgb(lab('steelblue')), equals(_.rgb('steelblue')));
    });
    test('roundtrip to HCL is idempotent', () {
      expect(_.hcl(lab('steelblue')), equals(_.hcl('steelblue')));
    });
  });
}
