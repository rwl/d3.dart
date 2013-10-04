import 'package:unittest/unittest.dart';

import '../../src/selection/selection.dart' as d4;

void main() {
  group('select(body)', () {
    group('on a simple page', () {
      Selection body = d4.select('body');
      test('sets a property as a string', () {
        body.property('bgcolor', 'red');
        expect(body.node().bgcolor, equals('red'));
      });
      test('sets a property as a number', () {
        body.property('opacity', 1);
        expect(body.node().opacity, equals('1'));
      });
      test('sets a property as a function', () {
        body.property('bgcolor', () { return 'orange'; });
        expect(body.node().bgcolor, equals('orange'));
      });
      test('sets properties as a map of constants', () {
        body.property({bgcolor: 'purple', opacity: .41});
        expect(body.node().bgcolor, equals('purple'));
        expect(body.node().opacity, equals(.41));
      });
      test('sets properties as a map of functions', () {
        body.data(['cyan']).property({bgcolor: String, opacity: (d, i) { return i; }});
        expect(body.node().bgcolor, equals('cyan'));
        expect(body.node().opacity, equals(0));
      });
      test('gets a property value', () {
        body.node().bgcolor = 'yellow';
        expect(body.property('bgcolor'), equals('yellow'));
      });
      test('removes a property as null', () {
        body.property('bgcolor', 'yellow').property('bgcolor', null);
        expect(body.node().containsKey('bgcolor'), isFalse);
      });
      test('removes a property as a function', () {
        body.property('bgcolor', 'yellow').property('bgcolor', () { return null; });
        expect(body.node().containsKey('bgcolor'), isFalse);
      });
      test('removes properties as a map of nulls', () {
        body.node().bgcolor = 'red';
        body.property({bgcolor: null});
        expect(body.node().containsKey('bgcolor'), isFalse);
      });
      test('removes properties as a map of functions that return null', () {
        body.node().bgcolor = 'red';
        body.property({bgcolor: () {}});
        expect(body.node().containsKey('bgcolor'), isFalse);
      });
      test('returns the current selection', () {
        expect(body.property('bgcolor', 'yellow'), same(body));
      });
    });
  });

  group('selectAll(div)', () {
    var d3 = load('selection/property').document();
    group('on a simple page', () {
      var div = d3.select('body').html('').selectAll('div').data([0, 1]).enter().append('div');
      test('sets a property as a string', () {
        div.property('bgcolor', 'red');
        expect(div[0][0].bgcolor, equals('red'));
        expect(div[0][1].bgcolor, equals('red'));
      });
      test('sets a property as a number', () {
        div.property('opacity', 0.4);
        expect(div[0][0].opacity, equals('0.4'));
        expect(div[0][1].opacity, equals('0.4'));
      });
      test('sets a property as a function', () {
        div.property('bgcolor', _.interpolateRgb('brown', 'steelblue'));
        expect(div[0][0].bgcolor, equals('#a52a2a'));
        expect(div[0][1].bgcolor, equals('#4682b4'));
      });
      test('gets a property value', () {
        div[0][0].bgcolor = 'purple';
        expect(div.property('bgcolor'), equals('purple'));
      });
      test('removes a property as null', () {
        div.property('bgcolor', 'yellow').property('bgcolor', null);
        expect(div[0][0].containsKey('bgcolor'), isFalse);
        expect(div[0][1].containsKey('bgcolor'), isFalse);
      });
      test('removes a property as a function', () {
        div.property('bgcolor', 'yellow').property('bgcolor', () { return null; });
        expect(div[0][0].containsKey('bgcolor'), isFalse);
        expect(div[0][1].containsKey('bgcolor'), isFalse);
      });
      test('returns the current selection', () {
        expect(div.property('bgcolor', 'yellow'), same(div));
      });
      test('ignores null nodes', () {
        var node = div[0][1];
        div.property('bgcolor', null);
        div[0][1] = null;
        div.property('bgcolor', 'red');
        expect(div[0][0].bgcolor, equals('red'));
        expect(node.containsKey('bgcolor'), isFalse);
      });
    });
  });
}
