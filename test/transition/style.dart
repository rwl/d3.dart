import 'package:unittest/unittest.dart';

void main() {
  var result = () {
    var s = d3.select('body').append('div')
        .style('background-color', 'white')
        .style('color', 'red')
        .style('display', 'none')
        .style('font-size', '20px');

    var t = s.transition()
        .style('display', null)
        .style('font-size', () { return null; })
        .style('display', null)
        .style('background-color', 'green')
        .style('background-color', 'red')
        .style('color', () { return 'green'; }, 'important');

    return {selection: s, transition: t};
  };
  test('defines the corresponding style tween', () {
    expect(result.transition.tween('style.background-color'), typeOf('function'));
    expect(result.transition.tween('style.color'), typeOf('function'));
  });
  group('on end', () {
    var result = () {
      var cb = this.callback;
      result.transition.each('end', () { cb(null, result); });
    };
    test('the last style operator takes precedence', () {
      expect(result.selection.style('background-color'), equals('#ff0000'));
    });
    test('sets a property as a string', () {
      expect(result.selection.style('background-color'), equals('#ff0000'));
    });
    test('sets a property as a function', () {
      expect(result.selection.style('color'), equals('#008000'));
    });
    test('observes the specified priority', () {
      var style = result.selection.node().style;
      expect(style.getPropertyPriority('background-color'), equals(''));
      expect(style.getPropertyPriority('color'), equals('important'));
    });
    test('removes a property using a constant null', () {
      expect(result.selection.style('display'), equals(''));
    });
    test('removes a property using a function null', () {
      expect(result.selection.style('font-size'), equals(''));
    });
  });
}