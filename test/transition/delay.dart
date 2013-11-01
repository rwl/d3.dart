import 'package:unittest/unittest.dart';

void main() {
  var selection = () {
    return d3.select('body').html('').selectAll()
        .data(['foo', 'bar'])
      .enter().append('div')
        .attr('class', String);
  };
  test('defaults to zero', () {
    var t = selection.transition();
    expect(t[0][0].__transition__[t.id].delay, same(0));
    expect(t[0][1].__transition__[t.id].delay, same(0));
  });
  test('can specify delay as a number', () {
    var t = selection.transition().delay(150);
    expect(t[0][0].__transition__[t.id].delay, same(150));
    expect(t[0][1].__transition__[t.id].delay, same(150));
    t.delay(250);
    expect(t[0][0].__transition__[t.id].delay, same(250));
    expect(t[0][1].__transition__[t.id].delay, same(250));
  });
  test('can specify delay as a negative number', () {
    var t = selection.transition().delay(-250);
    expect(t[0][0].__transition__[t.id].delay, same(-250));
    expect(t[0][1].__transition__[t.id].delay, same(-250));
  });
  test('delay is coerced to a number', () {
    var t = selection.transition().delay('520');
    expect(t[0][0].__transition__[t.id].delay, same(520));
    expect(t[0][1].__transition__[t.id].delay, same(520));
  });
  test('floating-point durations are not floored to integers', () {
    var t = selection.transition().delay(14.6);
    expect(t[0][0].__transition__[t.id].delay, same(14.6));
    expect(t[0][1].__transition__[t.id].delay, same(14.6));
    t = selection.transition().delay('16.99');
    expect(t[0][0].__transition__[t.id].delay, same(16.99));
    expect(t[0][1].__transition__[t.id].delay, same(16.99));
  });
  test('can specify delay as a function', () {
    var dd = [], ii = [], tt = [];
    var f = (d, i) {
      dd.push(d); ii.push(i); tt.push(this); return i * 20;
    }
    var t = selection.transition().delay(f);
    expect(t[0][0].__transition__[t.id].delay, same(0));
    expect(t[0][1].__transition__[t.id].delay, same(20));
    expect(dd, ['foo', 'bar'], equals('expected data, got {actual}'));
    expect(ii, [0, 1], equals('expected index, got {actual}'));
    expect(tt[0], t[0][0], domEquals('expected this, got {actual}'));
    expect(tt[1], t[0][1], domEquals('expected this, got {actual}'));
  });
  test('coerces delay to a number', () {
    var t = selection.transition().delay('150');
    expect(t[0][0].__transition__[t.id].delay, same(150));
    expect(t[0][1].__transition__[t.id].delay, same(150));
  });
}
