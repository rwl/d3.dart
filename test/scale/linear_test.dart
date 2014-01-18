import 'package:unittest/unittest.dart';
import 'package:d3/scale/scale.dart' as scale;

void main() {
  group('linear', () {
    group('domain', () {
      test('defaults to [0, 1]', () {
        var x = scale.linear();
        expect(x.domain(), equals([0, 1]));
        expect(x(.5), closeTo(.5, 1e-6));
      });
    });

    group('range', () {
      test('defaults to [0, 1]', () {
        var x = scale.linear();
        expect(x.range(), equals([0, 1]));
        expect(x.invert(.5), closeTo(.5, 1e-6));
      });
    });
  });
}