import 'package:unittest/unittest.dart';

import '../../src/math/math.dart' as d4;

void main() {
  group('random', () {
    var random = load('math/random').expression('d3.math.random'); 
    group('normal', () {
      var r = () {
        return random.normal();
      };
      test('returns a number', () {
        expect(r(), typeOf('number'));
      });
    });
    group('logNormal', () {
      var r = () {
        return random.logNormal();
      };
      test('returns a number', () {
        expect(r(), typeOf('number'));
      });
    });
    group('irwinHall', () {
      var r = () {
        return random.irwinHall(10);
      };
      test('returns a number', () {
        expect(r(), typeOf('number'));
      });
    });
  });
}
