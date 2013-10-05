import 'package:unittest/unittest.dart';

import '../../src/arrays/arrays.dart' as d4;

void main() {
  group('map', () {
    var map = load('arrays/map').expression('d3.map');
    group('constructor', () {
      test('map() returns an empty map', () {
        var m = map();
        expect(m.keys(), equals([]));
      });
      test('map(null) returns an empty map', () {
        var m = map(null);
        expect(m.keys(), equals([]));
      });
      test('map(object) copies enumerable keys', () {
        var m = map({foo: 42});
        expect(m.has('foo'), isTrue);
        expect(m.get('foo'), equals(42));
        var mm = map(Object.create(null, {foo: {value: 42, enumerable: true}}));
        expect(mm.has('foo'), isTrue);
        expect(mm.get('foo'), equals(42));
      });
      test('map(object) copies inherited keys', () {
        Foo() {}
        Foo.prototype.foo = 42;
        var m = map(Object.create({foo: 42}));
        expect(m.has('foo'), isTrue);
        expect(m.get('foo'), equals(42));
        var mm = map(new Foo());
        expect(mm.has('foo'), isTrue);
        expect(mm.get('foo'), equals(42));
      });
      test('map(object) does not copy non-enumerable keys', () {
        var m = map({__proto__: 42}); // because __proto__ isn't enumerable
        expect(m.has('__proto__'), isFalse);
        expect(m.get('__proto__'), isUndefined);
        var mm = map(Object.create(null, {foo: {value: 42, enumerable: false}}));
        expect(mm.has('foo'), isFalse);
        expect(mm.get('foo'), isUndefined);
      });
      test('map(map) copies the given map', () {
        var a = map({foo: 42}), b = map(a);
        expect(b.has('foo'), isTrue);
        expect(b.get('foo'), equals(42));
        a.set('bar', true);
        expect(b.has('bar'), isFalse);
      });
    });
    group('forEach', () {
      test('empty maps have an empty keys array', () {
        var m = map();
        expect(m.entries(), equals([]));
        m.set('foo', 'bar');
        expect(m.entries(), equals([{key: 'foo', value: 'bar'}]));
        m.remove('foo');
        expect(m.entries(), equals([]));
      });
      test('keys are returned in arbitrary order', () {
        var m = map({foo: 1, bar: '42'});
        expect(m.entries().sort(ascendingByKey), equals([{key: 'bar', value: '42'}, {key: 'foo', value: 1}]));
        var mm = map({bar: '42', foo: 1});
        expect(mm.entries().sort(ascendingByKey), equals([{key: 'bar', value: '42'}, {key: 'foo', value: 1}]));
      });
      test('observes changes via set and remove', () {
        var m = map({foo: 1, bar: '42'});
        expect(m.entries().sort(ascendingByKey), equals([{key: 'bar', value: '42'}, {key: 'foo', value: 1}]));
        m.remove('foo');
        expect(m.entries(), equals([{key: 'bar', value: '42'}]));
        m.set('bar', 'bar');
        expect(m.entries(), equals([{key: 'bar', value: 'bar'}]));
        m.set('foo', 'foo');
        expect(m.entries().sort(ascendingByKey), equals([{key: 'bar', value: 'bar'}, {key: 'foo', value: 'foo'}]));
        m.remove('bar');
        expect(m.entries(), equals([{key: 'foo', value: 'foo'}]));
        m.remove('foo');
        expect(m.entries(), equals([]));
        m.remove('foo');
        expect(m.entries(), equals([]));
      });
    });
    group('keys', () {
      test('returns an array of string keys', () {
        var m = map({foo: 1, bar: '42'});
        expect(m.keys().sort(), equals(['bar', 'foo']));
      });
    });
    group('values', () {
      test('returns an array of arbitrary values', () {
        var m = map({foo: 1, bar: '42'});
        expect(m.values().sort(), equals([1, '42']));
      });
    });
    group('entries', () {
      test('returns an array of key-value objects', () {
        var m = map({foo: 1, bar: '42'});
        expect(m.entries().sort(ascendingByKey),
            equals([{key: 'bar', value: '42'}, {key: 'foo', value: 1}]));
      });
    });
    group('has', () {
      test('empty maps do not have object built-ins', () {
        var m = map();
        expect(m.has('__proto__'), isFalse);
        expect(m.has('hasOwnProperty'), isFalse);
      });
      test('can has keys using built-in names', () {
        var m = map();
        m.set('__proto__', 42);
        expect(m.has('__proto__'), isTrue);
      });
      test('can has keys with null or undefined properties', () {
        var m = map();
        m.set('', '');
        m.set('null', null);
        m.set('undefined', null/*undefined*/);
        expect(m.has(''), isTrue);
        expect(m.has('null'), isTrue);
        expect(m.has('undefined'), isTrue);
      });
      test('coerces keys to strings', () {
        var m = map({'42': 'foo', 'null': 1, 'undefined': 2});
        expect(m.has(42), isTrue);
        expect(m.has(null), isTrue);
        expect(m.has(null/*undefined*/), isTrue);
      });
      test('returns the latest value', () {
        var m = map({foo: 42});
        expect(m.has('foo'), isTrue);
        m.set('foo', 43);
        expect(m.has('foo'), isTrue);
        m.remove('foo');
        expect(m.has('foo'), isFalse);
        m.set('foo', 'bar');
        expect(m.has('foo'), isTrue);
      });
      test('returns undefined for missing keys', () {
        var m = map({foo: 42});
        expect(m.has('bar'), isFalse);
      });
    });
    group('get', () {
      test('empty maps do not have object built-ins', () {
        var m = map();
        expect(m.get('__proto__'), isUndefined);
        expect(m.get('hasOwnProperty'), isUndefined);
      });
      test('can get keys using built-in names', () {
        var m = map();
        m.set('__proto__', 42);
        expect(m.get('__proto__'), equals(42));
      });
      test('coerces keys to strings', () {
        var m = map({'42': 1, 'null': 2, 'undefined': 3});
        expect(m.get(42), equals(1));
        expect(m.get(null), equals(2));
        expect(m.get(null/*undefined*/), equals(3));
      });
      test('returns the latest value', () {
        var m = map({foo: 42});
        expect(m.get('foo'), equals(42));
        m.set('foo', 43);
        expect(m.get('foo'), equals(43));
        m.remove('foo');
        expect(m.get('foo'), isUndefined);
        m.set('foo', 'bar');
        expect(m.get('foo'), equals('bar'));
      });
      test('returns undefined for missing keys', () {
        var m = map({foo: 42});
        expect(m.get('bar'), isUndefined);
      });
    });
    group('set', () {
      test('returns the set value', () {
        var m = map();
        expect(m.set('foo', 42), equals(42));
      });
      test('can set keys using built-in names', () {
        var m = map();
        m.set('__proto__', 42);
        expect(m.get('__proto__'), equals(42));
      });
      test('coerces keys to strings', () {
        var m = map();
        m.set(42, 1);
        expect(m.get(42), equals(1));
        m.set(null, 2);
        expect(m.get(null), equals(2));
        m.set(null/*undefined*/, 3);
        expect(m.get(null/*undefined*/), equals(3));
        expect(m.keys().sort(), equals(['42', 'null', 'undefined']));
      });
      test('can replace values', () {
        var m = map({foo: 42});
        expect(m.get('foo'), equals(42));
        m.set('foo', 43);
        expect(m.get('foo'), equals(43));
        m.set('foo', 'bar');
        expect(m.get('foo'), equals('bar'));
      });
      test('can set null, undefined or empty string values', () {
        var m = map();
        m.set('', '');
        m.set('null', null);
        m.set('undefined', null/*undefined*/);
        expect(m.get(''), equals(''));
        expect(m.get('null'), isNull);
        expect(m.get('undefined'), isUndefined);
      });
    }
  }
}