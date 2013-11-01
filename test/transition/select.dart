import 'package:unittest/unittest.dart';

void main() {
  var transition = () {
    var s = d3.select('body').append('div').selectAll('div')
        .data(['one', 'two', 'three', 'four'])
      .enter().append('div')
        .attr('class', String);

    s.filter((d, i) { return i > 0; }).append('span');
    s[0][3] = null;

    return s.transition()
        .delay((d, i) { return i * 13; })
        .duration((d, i) { return i * 21; });
  };

  test('selects the first matching element', () {
    var t = transition.select('span');
    expect(t[0][1].parentNode, domEquals(transition[0][1]));
    expect(t[0][2].parentNode, domEquals(transition[0][2]));
  });
  test('ignores null elements', () {
    var t = transition.select('span');
    expect(t[0][3], isNull);
  });
  test('propagates data to the selected elements', () {
    var t = transition.select('span');
    expect(t[0][1].__data__, equals('two'));
    expect(t[0][2].__data__, equals('three'));
  });
  test('propagates delay to the selected elements', () {
    var t = transition.select('span');
    expect(t[0][1].__transition__[t.id].delay, equals(13));
    expect(t[0][2].__transition__[t.id].delay, equals(26));
  });
  test('propagates duration to the selected elements', () {
    var t = transition.select('span');
    expect(t[0][1].__transition__[t.id].duration, equals(21));
    expect(t[0][2].__transition__[t.id].duration, equals(42));
  });
  test('does not propagate data if no data was specified', () {
    delete transition[0][1].__data__;
    delete transition[0][1].firstChild.__data__;
    var t = transition.select('span');
    expect(t[0][1].__data__, isUndefined);
    expect(t[0][2].__data__, equals('three'));
  });
  test('returns null if no match is found', () {
    var t = transition.select('span');
    expect(t[0][0], isNull);
  });
  test('inherits transition id', () {
    var id = transition.id,
        t0 = transition.select('span'),
        t1 = transition.select('span');
    expect(t0.id, equals(id));
    expect(t1.id, equals(id));
  });
}