import 'package:unittest/unittest.dart';

void main() {
  var result = () {
    var cb = this.callback,
        dd = [],
        ii = [],
        tt = [],
        fails = 0;

    var s = d3.select('body').append('div').selectAll('div')
        .data(['red', 'green'])
      .enter().append('div')
        .text((d) { return d3.rgb(d)+''; });

    var t = s.transition()
        .tween('text', () { ++fails; })
        .tween('text', tween);

    var tween = (d, i) {
      dd.push(d);
      ii.push(i);
      if (tt.push(this) >= 2) cb(null, {
        selection: s,
        transition: t,
        data: dd,
        index: ii,
        context: tt,
        fails: fails
      });
      return i && (t) {
        this.textContent = d3.hsl(230, 0.5, t) + '';
      };
    };
  };

  test('defines the corresponding tween', () {
    expect(result.transition.tween('text'), typeOf('function'));
  });
  test('the last tween takes precedence', () {
    expect(result.fails, equals(0));
  });
  test('invokes the tween function', () {
    expect(result.data, equals(['red', 'green']), 'expected data, got {actual}');
    expect(result.index, equals([0, 1]), 'expected data, got {actual}');
    expect(result.context[0], domEquals(result.selection[0][0]), 'expected this, got {actual}');
    expect(result.context[1], domEquals(result.selection[0][1]), 'expected this, got {actual}');
  });

  group('end', () {
    var result = () {
      var cb = this.callback;
      result.transition.each('end', (d, i) { if (i >= 1) cb(null, result); });
    };
    test('uses the returned tweener', () {
      expect(result.selection[0][1].textContent, equals('#ffffff'));
    });
    test('does nothing if the tweener is falsey', () {
      expect(result.selection[0][0].textContent, equals('#ff0000'));
    });
  });
}
