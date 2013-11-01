import 'package:unittest/unittest.dart';

void main() {
  var transition = () {
    return d3.select('body').append('div').transition();
  };
  test('calls the function once', () {
    var count = 0;
    transition.call(() { ++count; });
    expect(count, equals(1));
  });
  test('passes any optional arguments', () {
    var abc;
    transition.call((selection, a, b, c) { abc = [a, b, c]; }, 'a', 'b', 'c');
    expect(abc, equals(['a', 'b', 'c']));
  });
  test('passes the transition as the first argument', () {
    var t;
    transition.call((x) { t = x; });
    expect(t == transition, isTrue);
  });
  test('uses the transition as the context', () {
    var t;
    transition.call(() { t = this; });
    expect(t == transition, isTrue);
  });
  test('returns the current transition', () {
    expect(transition.call(() {}) == transition, isTrue);
  });
}