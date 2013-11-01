import 'package:unittest/unittest.dart';

void main() {
  var selection = () {
    return d3.select('body').html('').selectAll()
        .data(['foo', 'bar'])
      .enter().append('div')
        .attr('class', String);
  };
  test('defaults to 250 milliseconds', () {
    var t = selection.transition();
    expect(t[0][0].__transition__[t.id].duration, same(250));
    expect(t[0][1].__transition__[t.id].duration, same(250));
  });
  test('can specify duration as a number', () {
    var t = selection.transition().duration(150);
    expect(t[0][0].__transition__[t.id].duration, same(150));
    expect(t[0][1].__transition__[t.id].duration, same(150));
    t.duration(50);
    expect(t[0][0].__transition__[t.id].duration, same(50));
    expect(t[0][1].__transition__[t.id].duration, same(50));
  });
  test('zero or negative durations are treated as 1ms', () {
    var t = selection.transition().duration(0);
    expect(t[0][0].__transition__[t.id].duration, same(1));
    expect(t[0][1].__transition__[t.id].duration, same(1));
    t.duration(-10);
    expect(t[0][0].__transition__[t.id].duration, same(1));
    expect(t[0][1].__transition__[t.id].duration, same(1));
    t.duration(-Infinity);
    expect(t[0][0].__transition__[t.id].duration, same(1));
    expect(t[0][1].__transition__[t.id].duration, same(1));
  });
  test('duration is coerced to a number', () {
    var t = selection.transition().duration('520');
    expect(t[0][0].__transition__[t.id].duration, same(520));
    expect(t[0][1].__transition__[t.id].duration, same(520));
  });
  test('floating-point durations are not floored to integers', () {
    var t = selection.transition().duration(14.6);
    expect(t[0][0].__transition__[t.id].duration, same(14.6));
    expect(t[0][1].__transition__[t.id].duration, same(14.6));
    t = selection.transition().duration('16.99');
    expect(t[0][0].__transition__[t.id].duration, same(16.99));
    expect(t[0][1].__transition__[t.id].duration, same(16.99));
  });
  test('can specify duration as a function', () {
    var dd = [], ii = [], tt = [];
    var f = (d, i) { dd.push(d); ii.push(i); tt.push(this); return i * 20 + 10; }
    var t = selection.transition().duration(f);
    expect(t[0][0].__transition__[t.id].duration, same(10));
    expect(t[0][1].__transition__[t.id].duration, same(30));
    expect(dd, ['foo', 'bar'], equals('expected data, got {actual}'));
    expect(ii, [0, 1], equals('expected index, got {actual}'));
    expect(tt[0], t[0][0], domEquals('expected this, got {actual}'));
    expect(tt[1], t[0][1], domEquals('expected this, got {actual}'));
  });
  test('coerces duration to a number', () {
    var t = selection.transition().duration('150');
    expect(t[0][0].__transition__[t.id].duration, same(150));
    expect(t[0][1].__transition__[t.id].duration, same(150));
  });
}
