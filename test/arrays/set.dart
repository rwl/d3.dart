import 'package:unittest/unittest.dart';

import '../../src/arrays/arrays.dart' as d4;

void main() {
  group('set', () {
    var set = load('arrays/set').expression('d3.set');
    group('constructor', () {
      test('set() returns an empty set', () {
        var s = set();
        expect(s.values(), equals([]));
      });
      test('set(null) returns an empty set', () {
        var s = set(null);
        expect(s.values(), equals([]));
      });
      test('set(array) adds array entries', () {
        var s = set(['foo']);
        expect(s.has('foo'), isTrue);
        var s = set(['foo', 'bar']);
        expect(s.has('foo'), isTrue);
        expect(s.has('bar'), isTrue);
      });
    });
    group('forEach', () {
      test('empty sets have an empty values array', () {
        var s = set();
        expect(s.values(), equals([]));
        s.add('foo');
        expect(s.values(), equals(['foo']));
        s.remove('foo');
        expect(s.values(), equals([]));
      });
      test('values are returned in arbitrary order', () {
        var s = set(['foo', 'bar']);
        expect(s.values().sort(_.ascending), equals(['bar', 'foo']));
        var s = set(['bar', 'foo']);
        expect(s.values().sort(_.ascending), equals(['bar', 'foo']));
      });
      test('observes changes via add and remove', () {
        var s = set(['foo', 'bar']);
        expect(s.values().sort(_.ascending), equals(['bar', 'foo']));
        s.remove('foo');
        expect(s.values(), equals(['bar']));
        s.add('bar');
        expect(s.values(), equals(['bar']));
        s.add('foo');
        expect(s.values().sort(_.ascending), equals(['bar', 'foo']));
        s.remove('bar');
        expect(s.values(), equals(['foo']));
        s.remove('foo');
        expect(s.values(), equals([]));
        s.remove('foo');
        expect(s.values(), equals([]));
      });
    });
    group('values', () {
      test('returns an array of string values', () {
        var s = set(['foo', 'bar']);
        expect(s.values().sort(), equals(['bar', 'foo']));
      });
    });
    group('has', () {
      test('empty sets do not have object built-ins', () {
        var s = set();
        expect(s.has('__proto__'), isFalse);
        expect(s.has('hasOwnProperty'), isFalse);
      });
      test('coerces values to strings', () {
        var s = set(['42', 'null', 'undefined']);
        expect(s.has(42), isTrue);
        expect(s.has(null), isTrue);
        expect(s.has(null/*undefined*/), isTrue);
      });
      test('observes changes via add and remove', () {
        var s = set(['foo']);
        expect(s.has('foo'), isTrue);
        s.add('foo');
        expect(s.has('foo'), isTrue);
        s.remove('foo');
        expect(s.has('foo'), isFalse);
        s.add('foo');
        expect(s.has('foo'), isTrue);
      });
      test('returns undefined for missing values', () {
        var s = set(['foo']);
        expect(s.has('bar'), isFalse);
      });
    });
    group('add', () {
      test('returns the set value', () {
        var s = set();
        expect(s.add('foo'), equals('foo'));
      });
      test('can add values using built-in names', () {
        var s = set();
        s.add('__proto__');
        expect(s.has('__proto__'), isTrue);
      });
      test('coerces values to strings', () {
        var s = set();
        s.add(42);
        expect(s.has(42), isTrue);
        s.add(null);
        expect(s.has(null), isTrue);
        s.add(null/*undefined*/);
        expect(s.has(null/*undefined*/), isTrue);
        expect(s.values().sort(), equals(['42', 'null', 'undefined']));
      });
      test('can add null, undefined or empty string values', () {
        var s = set();
        s.add('');
        s.add('null');
        s.add('undefined');
        expect(s.has(''), isTrue);
        expect(s.has('null'), isTrue);
        expect(s.has('undefined'), isTrue);
      });
    });
    group('remove', () {
      test('returns true if the value was removed', () {
        var s = set(['foo']);
        expect(s.remove('foo'), isTrue);
      });
      test('returns false if the value is not an element', () {
        var s = set();
        expect(s.remove('foo'), isFalse);
      });
    });
  });
}