import 'package:unittest/unittest.dart';

import '../../src/event/event.dart' as d4;

void main() {
  group('dispatch', () {
    var dispatch = load('event/dispatch').expression('d3.dispatch');
    test('returns a map of dispatchers for each event type', () {
      expect(dispatch(), equals({}));
      var d = dispatch('foo');
      expect(d.containsKey('foo'), isTrue);
      expect(d.containsKey('bar'), isFalse);
      var d = dispatch('foo', 'bar');
      expect(d.containsKey('foo'), isTrue);
      expect(d.containsKey('bar'), isTrue);
    });
    test('added listeners receive subsequent events', () {
      var d = dispatch('foo'), events = 0;
      d.on('foo', () { ++events; });
      d.foo();
      expect(events, equals(1));
      d.foo();
      d.foo();
      expect(events, equals(3));
    });
    test('the listener is passed any arguments to dispatch', () {
      var d = dispatch('foo'), a = {}, b = {}, aa, bb;
      d.on('foo', (a, b) { aa = a; bb = b; });
      d.foo(a, b);
      expect(aa, equals(a));
      expect(bb, equals(b));
      d.foo(1, 'foo');
      expect(aa, equals(1));
      expect(bb, equals('foo'));
    });
    test('the listener\'s context is the same as dispatch\'s', () {
      var d = dispatch('foo'), a = {}, b = {}, that;
      d.on('foo', () { that = this; });
      d.foo.call(a);
      expect(that, equals(a));
      d.foo.call(b);
      expect(that, equals(b));
    });
    test('listeners are notified in the order they are added', () {
      var d = dispatch('foo'), a = {}, b = {}, those = [];
      A() { those.push(a); }
      B() { those.push(b); }
      d.on('foo.a', A).on('foo.b', B);
      d.foo();
      expect(those, equals([a, b]));
      those = [];
      d.on('foo.a', A); // move to the end
      d.foo();
      expect(those, equals([b, a]));
    });
    test('notifying listeners returns the dispatch object', () {
      var d = dispatch('foo');
      expect(d.foo(), equals(d));
    });
    test('adding a listener returns the dispatch object', () {
      var d = dispatch('foo');
      A() {}
      expect(d.on('foo', A), equals(d));
    });
    test('removed listeners do not receive subsequent events', () {
      var d = dispatch('foo'), a = {}, b = {}, those = [];
      A() { those.push(a); }
      B() { those.push(b); }
      d.on('foo.a', A).on('foo.b', B);
      d.foo();
      those = [];
      d.on('foo.a', null);
      d.foo();
      expect(those, equals([b]));
    });
    test('removing a shared listener only affects the intended event', () {
      var d = dispatch('foo', 'bar'), a = 0;
      A() { ++a; }
      d.on('foo', A).on('bar', A);
      d.foo();
      d.bar();
      expect(a, equals(2));
      d.on('foo', null);
      d.bar();
      expect(a, equals(3));
    });
    test('adding an existing listener has no effect', () {
      var d = dispatch('foo'), events = 0;
      A() { ++events; }
      d.on('foo.a', A);
      d.foo();
      d.on('foo.a', A).on('foo.a', A);
      d.foo();
      expect(events, equals(2));
    });
    test('removing a missing listener has no effect', () {
      var d = dispatch('foo'), events = 0;
      A() { ++events; }
      d.on('foo.a', null).on('foo', A).on('foo', null).on('foo', null);
      d.foo();
      expect(events, equals(0));
    });
    test('adding a listener does not affect the current event', () {
      var d = dispatch('foo'), a = {}, b = {}, those = [];
      A() { d.on('foo.b', B); those.push(a); }
      B() { those.push(b); }
      d.on('foo.a', A);
      d.foo();
      expect(those, equals([a]));
    });
    test('removing a listener does affect the current event', () {
      var d = dispatch('foo'), a = {}, b = {}, those = [];
      A() { d.on('foo.b', null); those.push(a); }
      B() { those.push(b); }
      d.on('foo.a', A).on('foo.b', B);
      d.foo();
      expect(those, equals([a]));
    });
    test('getting a listener returns the correct listener', () {
      var d = dispatch('foo');
      A() {}
      B() {}
      C() {}
      d.on('foo.a', A).on('foo.b', B).on('foo', C);
      expect(d.on('foo.a'), equals(A));
      expect(d.on('foo.b'), equals(B));
      expect(d.on('foo'), equals(C));
    });
    group('omitting the event type', () {
      test('returns undefined when retrieving a listener', () {
        var d = dispatch('foo');
        expect(d.on('.a'), isUndefined);
      });
      test('null removes all named event listeners', () {
        var d = dispatch('foo', 'bar'), a = {}, b = {}, c = {}, those = [];
        A() { those.push(a); }
        B() { those.push(b); }
        C() { those.push(c); }
        d.on('foo.a', A).on('bar.a', B).on('foo', C).on('.a', null);
        d.foo();
        d.bar();
        expect(those, equals([c]));
      });
      test('no-op when setting a listener', () {
        var d = dispatch('foo', 'bar'), a = {}, b = {}, those = [];
        A() { those.push(a); }
        B() { those.push(b); }
        d
            .on('.a', A)
            .on('foo.a', B)
            .on('bar', B);
        d.foo();
        d.bar();
        expect(those, equals([b, b]));
        expect(d.on('.a'), isUndefined);
      });
    });
  });
}