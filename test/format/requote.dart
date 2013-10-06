import 'package:unittest/unittest.dart';

import '../../src/format/format.dart' as d4;

void main() {
  group('requote', () {
    var requote = load('format/requote').expression('d3.requote');
    test('quotes backslashes', () {
      expect(requote('\\'), equals('\\\\'));
    });
    test('quotes carets', () {
      expect(requote('^'), equals('\\^'));
    });
    test('quotes dollar signs', () {
      expect(requote('\$'), equals('\\\$'));
    });
    test('quotes stars', () {
      expect(requote('*'), equals('\\*'));
    });
    test('quotes plusses', () {
      expect(requote('+'), equals('\\+'));
    });
    test('quotes question marks', () {
      expect(requote('?'), equals('\\?'));
    });
    test('quotes periods', () {
      expect(requote('.'), equals('\\.'));
    });
    test('quotes parentheses', () {
      expect(requote('('), equals('\\('));
      expect(requote(')'), equals('\\)'));
    });
    test('quotes pipes', () {
      expect(requote('|'), equals('\\|'));
    });
    test('quotes curly braces', () {
      expect(requote('{'), equals('\\{'));
      expect(requote('}'), equals('\\}'));
    });
    test('quotes square brackets', () {
      expect(requote('['), equals('\\['));
      expect(requote(']'), equals('\\]'));
    });
  });
}
