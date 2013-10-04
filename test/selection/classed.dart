import 'package:unittest/unittest.dart';

import '../../src/selection/selection.dart' as d4;


void main() {
  group('select(body)', () {
    group('on a simple page', () {
      Selection body = d4.select('body');
      test('adds a missing class as true', () {
        body.attr('class', null);
        body.classed('foo', true);
        expect(body.node().className, equals('foo'));
        body.classed('bar', true);
        expect(body.node().className, equals('foo bar'));
      });
      test('removes an existing class as false', () {
        body.attr('class', 'bar foo');
        body.classed('foo', false);
        expect(body.node().className, equals('bar'));
        body.classed('bar', false);
        expect(body.node().className, equals(''));
      });
      test('preserves an existing class as true', () {
        body.attr('class', 'bar foo');
        body.classed('foo', true);
        expect(body.node().className, equals('bar foo'));
        body.classed('bar', true);
        expect(body.node().className, equals('bar foo'));
      });
      test('preserves a missing class as false', () {
        body.attr('class', 'baz');
        body.classed('foo', false);
        expect(body.node().className, equals('baz'));
        body.attr('class', null);
        body.classed('bar', false);
        expect(body.node().className, equals(''));
      });
      test('gets an existing class', () {
        body.attr('class', ' foo\tbar  baz');
        expect(body.classed('foo'), isTrue);
        expect(body.classed('bar'), isTrue);
        expect(body.classed('baz'), isTrue);
      });
      test('does not get a missing class', () {
        body.attr('class', ' foo\tbar  baz');
        expect(body.classed('foob'), isFalse);
        expect(body.classed('bare'), isFalse);
        expect(body.classed('rbaz'), isFalse);
      });
      test('accepts a name with whitespace, collapsing it', () {
        body.attr('class', null);
        body.classed(' foo\t', true);
        expect(body.node().className, equals('foo'));
        body.classed('\tfoo  ', false);
        expect(body.node().className, equals(''));
      });
      test('accepts a name with multiple classes separated by whitespace', () {
        body.attr('class', null);
        body.classed('foo bar', true);
        expect(body.node().className, equals('foo bar'));
        expect(body.classed('foo bar'), isTrue);
        expect(body.classed('bar foo'), isTrue);
        expect(body.classed('foo bar baz'), isFalse);
        expect(body.classed('foob bar'), isFalse);
        body.classed('bar foo', false);
        expect(body.node().className, equals(''));
      });
      test('accepts a silly class name with unsafe characters', () {
        body.attr('class', null);
        body.classed('foo.bar', true);
        expect(body.node().className, equals('foo.bar'));
        expect(body.classed('foo.bar'), isTrue);
        expect(body.classed('foo'), isFalse);
        expect(body.classed('bar'), isFalse);
        body.classed('bar.foo', false);
        expect(body.node().className, equals('foo.bar'));
        body.classed('foo.bar', false);
        expect(body.node().className, equals(''));
      });
      test('accepts a name with duplicate classes, ignoring them', () {
        body.attr('class', null);
        body.classed(' foo\tfoo  ', true);
        expect(body.node().className, equals('foo'));
        body.classed('\tfoo  foo ', false);
        expect(body.node().className, equals(''));
      });
      test('accepts a value function returning true or false', () {
        body.attr('class', null);
        body.classed('foo', () { return true; });
        expect(body.node().className, equals('foo'));
        body.classed('foo bar', () { return true; });
        expect(body.node().className, equals('foo bar'));
        body.classed('foo', () { return false; });
        expect(body.node().className, equals('bar'));
      });
      test('accepts a name object containing true or false', () {
        body.attr('class', null);
        body.classed({foo: true});
        expect(body.node().className, equals('foo'));
        body.classed({bar: true, foo: false});
        expect(body.node().className, equals('bar'));
      });
      test('accepts a name object containing a function returning true or false', () {
        body.attr('class', null);
        body.classed({foo: () { return true; }});
        expect(body.node().className, equals('foo'));
      });
      test('accepts a name object containing a mix of functions and non-functions', () {
        body.attr('class', 'foo');
        body.classed({foo: false, bar: () { return true; }});
        expect(body.node().className, equals('bar'));
      });
      test('the value may be truthy or falsey', () {
        body.attr('class', 'foo');
        body.classed({foo: null, bar: () { return 1; }});
        expect(body.node().className, equals('bar'));
      });
      test('keys in the name object may contain whitespace', () {
        body.attr('class', null);
        body.classed({' foo\t': () { return true; }});
        expect(body.node().className, equals('foo'));
        body.attr('class', null);
      });
      test('keys in the name object may reference multiple classes', () {
        body.attr('class', null);
        body.classed({'foo bar': () { return true; }});
        expect(body.node().className, equals('foo bar'));
        body.attr('class', null);
      });
      test('keys in the name object may contain duplicates', () {
        body.attr('class', null);
        body.classed({'foo foo': () { return true; }});
        expect(body.node().className, equals('foo'));
        body.attr('class', null);
      });
      test('value functions are only evaluated once when used for multiple classes', () {
        var count = 0;
        body.attr('class', null);
        body.classed({'foo bar': () { return ++count; }});
        expect(body.node().className, equals('foo bar'));
        expect(count, equals(1));
      });
      test('returns the current selection', () {
        expect(body.classed('foo', true), same(body));
      });
    });
  });

  group('selectAll(div)', () {
    var d3 = load('selection/classed').document();
    group('on a simple page', () {
      var div =  d3.select('body').selectAll('div').data([0, 1]).enter().append('div');
      test('adds a missing class as true', () {
        div.attr('class', null);
        div.classed('foo', true);
        expect(div[0][0].className, equals('foo'));
        expect(div[0][1].className, equals('foo'));
        div.classed('bar', true);
        expect(div[0][0].className, equals('foo bar'));
        expect(div[0][1].className, equals('foo bar'));
      });
      test('adds a missing class as a function', () {
        div.data([0, 1]).attr('class', null);
        div.classed('foo', (d, i) { return d == 0; });
        expect(div[0][0].className, equals('foo'));
        expect(div[0][1].className, equals(''));
        div.classed('bar', (d, i) { return i == 1; });
        expect(div[0][0].className, equals('foo'));
        expect(div[0][1].className, equals('bar'));
      });
      test('removes an existing class as false', () {
        div.attr('class', 'bar foo');
        div.classed('foo', false);
        expect(div[0][0].className, equals('bar'));
        expect(div[0][1].className, equals('bar'));
        div.classed('bar', false);
        expect(div[0][0].className, equals(''));
        expect(div[0][1].className, equals(''));
      });
      test('removes an existing class as a function', () {
        div.data([0, 1]).attr('class', 'bar foo');
        div.classed('foo', (d, i) { return d == 0; });
        expect(div[0][0].className, equals('bar foo'));
        expect(div[0][1].className, equals('bar'));
        div.classed('bar', (d, i) { return i == 1; });
        expect(div[0][0].className, equals('foo'));
        expect(div[0][1].className, equals('bar'));
        div.classed('foo', () { return false; });
        expect(div[0][0].className, equals(''));
        expect(div[0][1].className, equals('bar'));
        div.classed('bar', () { return false; });
        expect(div[0][0].className, equals(''));
        expect(div[0][1].className, equals(''));
      });
      test('preserves an existing class as true', () {
        div.attr('class', 'bar foo');
        div.classed('foo', true);
        expect(div[0][0].className, equals('bar foo'));
        expect(div[0][1].className, equals('bar foo'));
        div.classed('bar', true);
        expect(div[0][0].className, equals('bar foo'));
        expect(div[0][1].className, equals('bar foo'));
      });
      test('preserves an existing class as a function', () {
        div.attr('class', 'bar foo');
        div.classed('foo', () { return true; });
        expect(div[0][0].className, equals('bar foo'));
        expect(div[0][1].className, equals('bar foo'));
        div.classed('bar', () { return true; });
        expect(div[0][0].className, equals('bar foo'));
        expect(div[0][1].className, equals('bar foo'));
      });
      test('preserves a missing class as false', () {
        div.attr('class', 'baz');
        div.classed('foo', false);
        expect(div[0][0].className, equals('baz'));
        expect(div[0][1].className, equals('baz'));
        div.attr('class', null);
        div.classed('bar', false);
        expect(div[0][0].className, equals(''));
        expect(div[0][1].className, equals(''));
      });
      test('preserves a missing class as a function', () {
        div.attr('class', 'baz');
        div.classed('foo', () { return false; });
        expect(div[0][0].className, equals('baz'));
        expect(div[0][1].className, equals('baz'));
        div.attr('class', null);
        div.classed('bar', () { return false; });
        expect(div[0][0].className, equals(''));
        expect(div[0][1].className, equals(''));
      });
      test('gets an existing class', () {
        div[0][0].className = ' foo\tbar  baz';
        expect(div.classed('foo'), isTrue);
        expect(div.classed('bar'), isTrue);
        expect(div.classed('baz'), isTrue);
      });
      test('does not get a missing class', () {
        div[0][0].className = ' foo\tbar  baz';
        expect(div.classed('foob'), isFalse);
        expect(div.classed('bare'), isFalse);
        expect(div.classed('rbaz'), isFalse);
      });
      test('returns the current selection', () {
        expect(div.classed('foo', true), same(div));
      });
      test('ignores null nodes', () {
        var node = div[0][1];
        div.attr('class', null);
        div[0][1] = null;
        div.classed('foo', true);
        expect(div[0][0].className, equals('foo'));
        expect(node.className, equals(''));
      });
    });
  });
}
