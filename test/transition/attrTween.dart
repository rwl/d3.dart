import 'package:unittest/unittest.dart';

void main() {
  var result = () {
    var callback = this.callback,
        dd = [],
        ii = [],
        tt = [],
        vv = [];

    var s = d3.select('body').html('').append('div').selectAll('div')
        .data(['red', 'green'])
      .enter().append('div')
        .attr('color', (d, i) { return i ? '#008000' : '#ff0000'; });

    var t = s.transition()
        .attrTween('color', tween);

    tween(d, i, v) {
      dd.push(d);
      ii.push(i);
      vv.push(v);
      if (tt.push(this) >= 2) callback(null, {
        selection: s,
        transition: t,
        data: dd,
        index: ii,
        value: vv,
        context: tt
      });
      return i && _.interpolateHsl(v, 'blue');
    }
  };

  test('defines the corresponding attr tween', () {
    expect(result.transition.tween('attr.color'), typeOf('function'));
  });
  test('invokes the tween function', () {
    expect(result.data, ['red', 'green'], equals('expected data, got {actual}'));
    expect(result.index, [0, 1], equals('expected data, got {actual}'));
    expect(result.value, ['#ff0000', '#008000'], equals('expected value, got {actual}'));
    expect(result.context[0], result.selection[0][0], domEquals('expected this, got {actual}'));
    expect(result.context[1], result.selection[0][1], domEquals('expected this, got {actual}'));
  });

  group('end', () {
    result = () {
      var callback = this.callback;
      result.transition.each('end', (d, i) { if (i >= 1) callback(null, result); });
    };
    test('uses the returned interpolator', () {
      expect(result.selection[0][1].getAttribute('color'), equals('#0000ff'));
    });
    test('does nothing if the interpolator is falsey', () {
      expect(result.selection[0][0].getAttribute('color'), equals('#ff0000'));
    });
  });
}
