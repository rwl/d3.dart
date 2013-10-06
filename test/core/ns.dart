import 'package:unittest/unittest.dart';

import '../../src/core/core.dart' as d4;

void main() {
  group('ns', () {
    var ns = load('core/ns').expression('d3.ns');
    group('prefix', () {
      var prefix = ns.prefix;
      test('svg is http://www.w3.org/2000/svg', () {
        expect(prefix.svg, equals('http://www.w3.org/2000/svg'));
      });
      test('xhtml is http://www.w3.org/1999/xhtml', () {
        expect(prefix.xhtml, equals('http://www.w3.org/1999/xhtml'));
      });
      test('xlink is http://www.w3.org/1999/xlink', () {
        expect(prefix.xlink, equals('http://www.w3.org/1999/xlink'));
      });
      test('xml is http://www.w3.org/XML/1998/namespace', () {
        expect(prefix.xml, equals('http://www.w3.org/XML/1998/namespace'));
      });
      test('xmlns is http://www.w3.org/2000/xmlns/', () {
        expect(prefix.xmlns, equals('http://www.w3.org/2000/xmlns/'));
      });
    });
    group('qualify', () {
      var qualify = ns.qualify;
      test('local name returns name', () {
        expect(qualify('local'), equals('local'));
      });
      test('known qualified name returns space and local', () {
        var name = qualify('svg:path');
        expect(name.space, equals('http://www.w3.org/2000/svg'));
        expect(name.local, equals('path'));
      });
      test('unknown qualified name returns name', () {
        expect(qualify('foo:bar'), equals('bar'));
      });
      test('known local name returns space and local', () {
        var name = qualify('svg');
        expect(name.space, equals('http://www.w3.org/2000/svg'));
        expect(name.local, equals('svg'));
      });
      test('names that collide with built-ins are ignored', () {
        expect(qualify('hasOwnProperty:test'), equals('test'));
      });
    });
  });
}
