import 'package:unittest/unittest.dart';
import 'package:unittest/html_enhanced_config.dart';
import 'package:d3/selection/selection.dart';

main() {
  useHtmlEnhancedConfiguration();

  group('select(body)', () {
    group('on an initially-empty page', () {
      final Selection body = new Selection.selector('body');
      test('sets a property as a string', () {
        body.style('background-color', 'red');
        expect(body.node.style.getPropertyValue('background-color'), equals('red'));
      });
      test('sets a property as a number', () {
        body.style('opacity', .3);
        expect(body.node.style.getPropertyValue('opacity'), equals('0.3'));
      });
      test('sets a property as a function', () {
        body.styleFunc('background-color', (n, d, i, j) { return 'orange'; });
        expect(body.node.style.getPropertyValue('background-color'), equals('orange'));
      });
      test('sets properties as a map of constants', () {
        body.styleMap({'background-color': 'white', 'opacity': .42});
        expect(body.node.style.getPropertyValue('background-color'), equals('white'));
        expect(body.node.style.getPropertyValue('opacity'), equals('0.42'));
      });
      test('sets properties as a map of functions', () {
        body.data(['orange']).styleMap({
          'background-color': (n, d, i, j) { return d; },
          'opacity': (n, d, i, j) { return i; }
        });
        expect(body.node.style.getPropertyValue('background-color'), equals('orange'));
        expect(body.node.style.getPropertyValue('opacity'), equals('0'));
      });
      /*test('gets a property value', () {
        body.node.style.setProperty('background-color', 'yellow', '');
        expect(body.style('background-color'), equals('yellow'));
      });*/
      test('observes the specified priority', () {
        body.style('background-color', 'green', 'important');
        expect(body.node.style.getPropertyPriority('background-color'), equals('important'));
        body.styleMap({'opacity': .52}, 'important');
        expect(body.node.style.getPropertyPriority('opacity'), equals('important'));
        body.styleMap({'visibility': (n, d, i, j) { return 'visible'; }}, 'important');
        expect(body.node.style.getPropertyPriority('visibility'), equals('important'));
      });
      /*test('removes a property as null', () {
        body.style('background-color', 'green').style('background-color', null);
        expect(body.style('background-color'), equals(''));
      });
      test('removes a property as a function', () {
        body.style('background-color', 'green').style('background-color', () { return null; });
        expect(body.style('background-color'), equals(''));
      });
      test('removes properties as a map of nulls', () {
        body.node.style.setProperty('background-color', 'purple');
        body.style({'background-color': null});
        expect(body.style('background-color'), equals(''));
      });
      test('removes properties as a map of functions that return null', () {
        body.node.style.setProperty('background-color', 'purple');
        body.style({'background-color': () {}});
        expect(body.style('background-color'), equals(''));
      });*/
      test('returns the current selection', () {
        expect(body..style('background-color', 'green'), same(body));
      });
    });
  });
}