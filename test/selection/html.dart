import 'package:unittest/unittest.dart';

import '../../src/selection/selection.dart' as d4;

void main() {
  group('select(body)', () {
    group('on a simple page', () {
      Selection body = d4.select('body');
      test('sets the inner HTML as a string', () {
        body.html('<h1>Hello, world!</h1>');
        expect(body.node().firstChild.tagName, equals('H1'));
        expect(body.node().firstChild.textContent, equals('Hello, world!'));
      });
      test('sets the inner HTML as a number', () {
        body.html(42);
        expect(body.node().innerHTML, equals('42'));
        expect(body.node().firstChild.nodeType, equals(3));
      });
      test('sets the inner HTML as a function', () {
        body.data(['Subject']).html((d, i) { return '<b>' + d + '</b><i>' + i + '</i>'; });
        expect(body.node().firstChild.tagName, equals('B'));
        expect(body.node().firstChild.textContent, equals('Subject'));
        expect(body.node().lastChild.tagName, equals('I'));
        expect(body.node().lastChild.textContent, equals('0'));
      });
      test('clears the inner HTML as null', () {
        body.html(null);
        expect(body.node().innerHTML, equals(''));
        expect(body.node().firstChild, isNull);
      });
      test('clears the inner HTML as undefined', () {
        body.html(undefined);
        expect(body.node().innerHTML, equals(''));
        expect(body.node().firstChild, isNull);
      });
      test('clears the inner HTML as the empty string', () {
        body.html('');
        expect(body.node().innerHTML, equals(''));
        expect(body.node().firstChild, isNull);
      });
      test('clears the inner HTML as a function returning the empty string', () {
        body.text(() { return ''; });
        expect(body.node().innerHTML, equals(''));
        expect(body.node().firstChild, isNull);
      });
      test('clears the inner HTML as a function returning null', () {
        body.text(() { return null; });
        expect(body.node().innerHTML, equals(''));
        expect(body.node().firstChild, isNull);
      });
      test('clears the inner HTML as a function returning undefined', () {
        body.text(() { return undefined; });
        expect(body.node().innerHTML, equals(''));
        expect(body.node().firstChild, isNull);
      });
      test('returns the current selection', () {
        expect(body.html('foo'), same(body));
      });
      test('ignores null nodes', () {
        var node = body.node();
        body[0][0] = null;
        node.innerHTML = '<h1>foo</h1>';
        body.html('bar');
        expect(node.textContent, equals('foo'));
      });
    });
  });

  group('selectAll(div)', () {
    var d3 = load('selection/empty').document();
    group('on a simple page', () {
      var div = d3.select('body').selectAll('div').data([0, 1]).enter().append('div');
      test('sets the inner HTML as a string', () {
        div.html('<h1>Hello, world!</h1>');
        expect(div[0][0].firstChild.tagName, equals('H1'));
        expect(div[0][0].firstChild.textContent, equals('Hello, world!'));
        expect(div[0][1].firstChild.tagName, equals('H1'));
        expect(div[0][1].firstChild.textContent, equals('Hello, world!'));
      });
      test('sets the inner HTML as a number', () {
        div.html(42);
        expect(div[0][0].innerHTML, equals('42'));
        expect(div[0][0].firstChild.nodeType, equals(3));
      });
      test('sets the inner HTML as a function', () {
        div.data(['foo', 'bar']).html((d, i) { return '<b>' + d + '</b><i>' + i + '</i>'; });
        expect(div[0][0].firstChild.tagName, equals('B'));
        expect(div[0][0].firstChild.textContent, equals('foo'));
        expect(div[0][0].lastChild.tagName, equals('I'));
        expect(div[0][0].lastChild.textContent, equals('0'));
        expect(div[0][1].firstChild.tagName, equals('B'));
        expect(div[0][1].firstChild.textContent, equals('bar'));
        expect(div[0][1].lastChild.tagName, equals('I'));
        expect(div[0][1].lastChild.textContent, equals('1'));
      });
      test('clears the inner HTML as null', () {
        div.html(null);
        expect(div[0][0].innerHTML, equals(''));
        expect(div[0][0].firstChild, isNull);
        expect(div[0][1].innerHTML, equals(''));
        expect(div[0][1].firstChild, isNull);
      });
      test('clears the inner HTML as a function', () {
        div.html(() { return ''; });
        expect(div[0][0].innerHTML, equals(''));
        expect(div[0][0].firstChild, isNull);
        expect(div[0][1].innerHTML, equals(''));
        expect(div[0][1].firstChild, isNull);
      });
      test('returns the current selection', () {
        expect(div.html('foo'), same(div));
      });
      test('ignores null nodes', () {
        var node = div[0][0];
        div[0][0] = null;
        node.innerHTML = '<h1>foo</h1>';
        div.html('bar');
        expect(node.textContent, equals('foo'));
        expect(div[0][1].textContent, equals('bar'));
      });
    });
  });
}
