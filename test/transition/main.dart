import 'package:unittest/unittest.dart';

void main() {
  group('transition', () {
    var d3 = load('transition/transition').document();
    test('selects the document element', () {
      var transition = d3.transition();
      expect(transition.length, equals(1));
      expect(transition[0].length, equals(1));
      expect(transition[0][0].nodeType, equals(1));
      expect(transition[0][0].tagName, equals('HTML'));
    });
    test('is an instanceof d3.transition', () {
      expect(d3.transition() instanceof d3.transition, isTrue);
    });
    test('subselections are also instanceof d3.transition', () {
      var transition = d3.transition();
      expect(transition.select('body') instanceof d3.transition, isTrue);
      expect(transition.selectAll('body') instanceof d3.transition, isTrue);
    });
    test('transition prototype can be extended', () {
      var transition = d3.transition(), vv = [];
      d3.transition.prototype.foo = (v) { vv.push(v); return this; };
      transition.select('body').foo(42);
      expect(vv, equals([42]));
      delete d3.transition.prototype.foo;
    });
  });

  // Subtransitions
  group('transition', () {
    var d3 = load('transition/transition').document();
    test('select', require('./transition-test-select'));
    test('selectAll', require('./transition-test-selectAll'));
    test('transition', require('./transition-test-transition'));
    test('filter', require('./transition-test-filter'));
  });

  // Content
  group('transition', () {
    topic: load('transition/transition').document();
    test('attr', require('./transition-test-attr'));
    test('attrTween', require('./transition-test-attrTween'));
    test('style', require('./transition-test-style'));
    test('styleTween', require('./transition-test-styleTween'));
    test('text', require('./transition-test-text'));
    test('remove', require('./transition-test-remove'));
  });

  // Animation
  group('transition', () {
    var d3 = load('transition/transition').document();
    test('delay', require('./transition-test-delay'));
    test('duration', require('./transition-test-duration')):
  });

  // Control
  group('transition', () {
    var d3 = load('transition/transition').document();
    test('each', require('./transition-test-each'));
    test('call', require('./transition-test-call'));
    test('tween', require('./transition-test-tween'));
    test('id', require('./transition-test-id'));
    test('time', require('./transition-test-time'));
  });

  // Inspection
  group('transition', () {
    var d3 = load('transition/transition').document();
    test('size', require('./transition-test-size'));
    test('node', require('./transition-test-node'));
  });
}
