import 'package:unittest/unittest.dart';

void main() {
  group('on a new transition', () {
    var transition = () {
      return d3.select('body').append('div').transition();
    };
    test('is approximately equal to now', () {
      var time = transition[0][0].__transition__[transition.id].time;
      expect(time, inDelta(Date.now(), 20));
    });
  });
  test('increases monotonically across transitions', () {
    var now = Date.now, then = Date.now();
    try {
      Date.now = () { return ++then; };
      var t0 = d3.select('body').append('div').transition(),
          t1 = d3.select('body').append('div').transition();
      expect(t1[0][0].__transition__[t1.id].time > t0[0][0].__transition__[t0.id].time, isTrue);
    } finally {
      Date.now = now;
    }
  });
  test('is inherited by subtransitions', () {
    var now = Date.now, then = Date.now();
    try {
      Date.now = () { return ++then; };
      var t0 = d3.select('body').append('div').transition(),
          t1 = t0.transition();
      expect(t1[0][0].__transition__[t1.id].time, equals(t0[0][0].__transition__[t0.id].time));
    } finally {
      Date.now = now;
    }
  });
}
