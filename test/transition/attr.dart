import 'package:unittest/unittest.dart';

import '../../src/transition/transition.dart' as d4;

void main() {
  var result = () {
    var s = d3.select('body').append('div')
        .attr('display', 'none')
        .attr('font-size', '20px')
        .attr('width', 20)
        .attr('color', 'red')
        .attr('xlink:type', 'simple')
        .attr('xlink:href', 'http://mbostock.github.com/d3/');

    var t = s.transition()
        .attr('display', null)
        .attr('font-size', () { return null; })
        .attr('display', null)
        .attr('width', 100)
        .attr('width', 200)
        .attr('color', () { return 'green'; })
        .attr('xlink:href', null)
        .attr('xlink:type', () { return null; });

    return {selection: s, transition: t};
  };
  test('defines the corresponding attr tween', () {
    expect(result.transition.tween('attr.width'), typeOf('function'));
    expect(result.transition.tween('attr.color'), typeOf('function'));
  });
  group('on end', () {
    var result = () {
      var cb = this.callback;
      result.transition.each('end', () { cb(null, result); });
    };
    test('the last attr operator takes precedence', () {
      expect(result.selection.attr('width'), equals('200'));
    });
    test('sets an attribute as a number', () {
      expect(result.selection.attr('width'), equals('200'));
    });
    test('sets an attribute as a function', () {
      expect(result.selection.attr('color'), equals('#008000'));
    });
    test('removes an attribute using a constant null', () {
      expect(result.selection.attr('display'), isNull);
    });
    test('removes an attribute using a function null', () {
      expect(result.selection.attr('font-size'), isNull);
    });
    test('removes a namespaced attribute using a constant null', () {
      expect(result.selection.attr('xlink:href'), isNull);
    });
    test('removes a namespaced attribute using a function null', () {
      expect(result.selection.attr('xlink:type'), isNull);
    });
  });
}
