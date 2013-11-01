import 'package:unittest/unittest.dart';

void main() {
  var transition = () {
    var s = d3.select('body').append('div').selectAll('div')
        .data(['one', 'two', 'three', 'four'])
      .enter().append('div')
        .attr('class', String);

    s.filter((d, i) { return i > 0; }).append('span');
    s.filter((d, i) { return i > 1; }).append('span');
    s[0][3] = null;

    return s.transition()
        .delay((d, i) { return i * 13; })
        .duration((d, i) { return i * 21; });
  };

  test('selects all matching elements', () {
    var t = transition.selectAll('span');
    expect(t[1][0].parentNode, domEquals(transition[0][1]));
    expect(t[2][0].parentNode, domEquals(transition[0][2]));
    expect(t[2][1].parentNode, domEquals(transition[0][2]));
  });
  test('ignores null elements', () {
    var t = transition.selectAll('span');
    expect(t.length, equals(3));
  });
  test('propagates delay to the selected elements', () {
    var t = transition.selectAll('span');
    expect(t[1][0].__transition__[t.id].delay, domEquals(13));
    expect(t[2][0].__transition__[t.id].delay, domEquals(26));
    expect(t[2][1].__transition__[t.id].delay, domEquals(26));
  });
  test('propagates duration to the selected elements', () {
    var t = transition.selectAll('span');
    expect(t[1][0].__transition__[t.id].duration, domEquals(21));
    expect(t[2][0].__transition__[t.id].duration, domEquals(42));
    expect(t[2][1].__transition__[t.id].duration, domEquals(42));
  });
  test('returns empty if no match is found', () {
    var t = transition.selectAll('span');
    expect(t[0], isEmpty);
  });
  test('inherits transition id', () {
    var id = transition.id,
        t0 = transition.selectAll('span'),
        t1 = transition.selectAll('span');
    expect(t0.id, equals(id));
    expect(t1.id, equals(id));
  });
  test('groups are arrays, not instances of NodeList', () {
    var t = transition.selectAll(() { return this.getElementsByClassName('span'); });
    expect(Array.isArray(t[0]), isTrue);
  });
}
