import 'package:unittest/unittest.dart';

void main() {
  var result = () {
    var cb = this.callback,
        dd = [],
        ii = [],
        tt = [],
        vv = [],
        fails = 0;

    var s = d3.select('body').html('').append('div').selectAll('div')
        .data(['red', 'green'])
      .enter().append('div')
        .style('background-color', (d) { return d3.rgb(d)+''; });

    var t = s.transition()
        .styleTween('background-color', () { ++fails; })
        .styleTween('background-color', tween);

    var tween = (d, i, v) {
      dd.push(d);
      ii.push(i);
      vv.push(v);
      if (tt.push(this) >= 2) cb(null, {
        selection: s,
        transition: t,
        data: dd,
        index: ii,
        value: vv,
        context: tt,
        fails: fails
      });
      return i && _.interpolateHsl(v, 'blue');
    };
  };

  test('defines the corresponding style tween', () {
    expect(result.transition.tween('style.background-color'), typeOf('function'));
  });
  test('the last style tween takes precedence', () {
    expect(result.fails, equals(0));
  });
  test('invokes the tween function', () {
    expect(result.data, equals(['red', 'green']), 'expected data, got {actual}');
    expect(result.index, equals([0, 1]), 'expected index, got {actual}');
    expect(result.value, equals(['#ff0000', '#008000']), 'expected value, got {actual}');
    expect(result.context[0], domEquals(result.selection[0][0]), 'expected this, got {actual}');
    expect(result.context[1], domEquals(result.selection[0][1]), 'expected this, got {actual}');
  });

  group('end', () {
    var result = () {
      var cb = this.callback;
      result.transition.each('end', (d, i) { if (i >= 1) cb(null, result); });
    };
    test('uses the returned interpolator', () {
      expect(result.selection[0][1].style.getPropertyValue('background-color'), equals('#0000ff'));
    });
    test('does nothing if the interpolator is falsey', () {
      expect(result.selection[0][0].style.getPropertyValue('background-color'), equals('#ff0000'));
    });
  });
}
