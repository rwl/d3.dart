import 'package:unittest/unittest.dart';

import '../../src/selection/selection.dart' as d4;

void main() {
  group('on select(body)', () {
    group('on an initially-empty page', () {
      Selection body = d4.select('body');
      test('sets the text content as a string', () {
        body.text('Hello, world!');
        expect(body.node().textContent, equals('Hello, world!'));
      });
      test('sets the text content as a number', () {
        body.text(42);
        expect(body.node().textContent, equals('42'));
      });
      test('sets the text content as a function', () {
        body.data(['Subject']).text((d, i) { return 'Hello, ' + d + ' ' + i + '!'; });
        expect(body.node().textContent, equals('Hello, Subject 0!'));
      });
      test('escapes html content to text', () {
        body.text('<h1>Hello, world!</h1>');
        expect(body.node().textContent, equals('<h1>Hello, world!</h1>'));
        expect(body.node().firstChild.nodeType, equals(3));
      });
      test('clears the text content as null', () {
        body.text(null);
        expect(body.node().textContent, equals(''));
      });
      test('clears the text content as undefined', () {
        body.text(undefined);
        expect(body.node().textContent, equals(''));
      });
      test('clears the text content as a function returning null', () {
        body.text(() { return null; });
        expect(body.node().textContent, equals(''));
      });
      test('clears the text content as a function returning undefined', () {
        body.text(() { return undefined; });
        expect(body.node().textContent, equals(''));
      });
      test('returns the current selection', () {
        expect(body.text('hello'), same(body));
      });
      test('ignores null nodes', () {
        var node = body.node();
        node.textContent = 'foo';
        body[0][0] = null;
        body.text('bar');
        expect(node.textContent, equals('foo'));
      });
    });
  });

  group('on selectAll(div)', () {
    var d3 = load('selection/selection').document();
    group('on a page with a few divs', () {
      var div = d3.select('body').selectAll('div').data([0, 1]).enter().append('div');
      test('sets the text content as a string', () {
        div.text('Hello, world!');
        expect(div[0][0].textContent, equals('Hello, world!'));
        expect(div[0][1].textContent, equals('Hello, world!'));
      });
      test('sets the text content as a number', () {
        div.text(42);
        expect(div[0][0].textContent, equals('42'));
        expect(div[0][1].textContent, equals('42'));
      });
      test('sets the text content as a function', () {
        div.data(['foo', 'bar']).text((d, i) {
          return 'Hello, ' + d + ' ' + i + '!';
        });
        expect(div[0][0].textContent, equals('Hello, foo 0!'));
        expect(div[0][1].textContent, equals('Hello, bar 1!'));
      });
      test('escapes html content to text', () {
        div.text('<h1>Hello, world!</h1>');
        expect(div[0][0].textContent, equals('<h1>Hello, world!</h1>'));
        expect(div[0][1].textContent, equals('<h1>Hello, world!</h1>'));
        expect(div[0][0].firstChild.nodeType, equals(3));
        expect(div[0][1].firstChild.nodeType, equals(3));
      });
      test('clears the text content as null', () {
        div.text(null);
        expect(div[0][0].textContent, equals(''));
        expect(div[0][1].textContent, equals(''));
      });
      test('clears the text content as a function', () {
        div.text(() { return null; });
        expect(div[0][0].textContent, equals(''));
        expect(div[0][1].textContent, equals(''));
      });
      test('returns the current selection', () {
        expect(div.text('hello'), same(div));
      });
      test('ignores null nodes', () {
        var node = div[0][0];
        node.textContent = 'foo';
        div[0][0] = null;
        div.text('bar');
        expect(node.textContent, equals('foo'));
        expect(div[0][1].textContent, equals('bar'));
      });
    });
  });
}
