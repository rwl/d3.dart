import 'package:unittest/unittest.dart';

void main() {
  var div = () {
    return d3.select('body').append('div').text('foo').transition().text('bar');
  };
  test('sets the text tween', () {
    expect(div.tween('text'), typeOf('function'));
  });
  group('start', () {
    var result = () {
      var cb = this.callback,
          tween = div.tween('text');
      div.tween('text', () {
        var result = tween.apply(this, arguments);
        cb(null, {transition: div, tween: result});
        return result;
      });
    };
    test('sets the text content as a string', () {
      expect(result.transition[0][0].textContent, equals('bar'));
    });
    test('does not interpolate text', () {
      expect(!result.tween, isTrue);
    });
  });
}
