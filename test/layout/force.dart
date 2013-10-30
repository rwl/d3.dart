import 'package:unittest/unittest.dart';

import '../../src/layout/layout.dart' as d4;

void main() {
  group('force', () {
    var force = load('layout/force').expression('d3.layout.force');
    group('default instance', () {
      var f = () {
        return force();
      };

      group('friction', () {
        test('defaults to .9', () {
          expect(f.friction(), equals(.9));
        });
        test('can be a number', () {
          f.friction(.5);
          expect(f.friction(), equals(.5));
        });
        test('coerces to a number', () {
          f.friction('.5');
          expect(f.friction(), same(.5));
        });
      });

      group('gravity', () {
        test('defaults to .1', () {
          expect(f.gravity(), equals(.1));
        });
        test('can be a number', () {
          f.gravity(.5);
          expect(f.gravity(), equals(.5));
        });
        test('coerces to a number', () {
          f.gravity('.5');
          expect(f.gravity(), same(.5));
        });
      });

      group('theta', () {
        test('defaults to .8', () {
          expect(f.theta(), equals(.8));
        });
        test('can be a number', () {
          f.theta(.5);
          expect(f.theta(), equals(.5));
        });
        test('coerces to a number', () {
          f.theta('.5');
          expect(f.theta(), same(.5));
        });
      });

      group('charge', () {
        test('defaults to -30', () {
          expect(f.charge(), equals(-30));
        });
        test('can be a number', () {
          f.charge(-40);
          expect(f.charge(), equals(-40));
        });
        test('can be a function', () { // TODO expose the computed value?
          f.charge(foo);
          expect(f.charge(), equals(foo));
        });
        test('coerces to a number', () {
          f.charge('-40');
          expect(f.charge(), same(-40));
        });
      });

      group('linkDistance', () {
        test('defaults to 20', () {
          expect(f.linkDistance(), equals(20));
        });
        test('can be a number', () {
          f.linkDistance(40);
          expect(f.linkDistance(), equals(40));
        });
        test('can be a function', () { // TODO expose the computed value?
          f.linkDistance(foo);
          expect(f.linkDistance(), equals(foo));
        });
        test('coerces to a number', () {
          f.linkDistance('40');
          expect(f.linkDistance(), same(40));
        });
      });

      group('linkStrength', () {
        test('defaults to 1', () {
          expect(f.linkStrength(), equals(1));
        });
        test('can be a number', () {
          f.linkStrength(.5);
          expect(f.linkStrength(), equals(.5));
        });
        test('can be a function', () { // TODO expose the computed value?
          f.linkStrength(foo);
          expect(f.linkStrength(), equals(foo));
        });
        test('coerces to a number', () {
          f.linkStrength('.5');
          expect(f.linkStrength(), same(.5));
        });
      });
    });
  });
}

foo(d) {
  return d.foo;
}