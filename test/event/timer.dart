import 'package:unittest/unittest.dart';

import '../../src/event/event.dart' as d4;

void main() {
  group('timer', () {
    var timer = load('event/timer').expression('d3.timer').document();
    
    group('with no delay', () {
      var info = delay();
      test('first calls after 17 ms or less', () {
        expect(info.start - info.scheduled, inDelta(17, 20));
      });
      test('calls until the function returns true', () {
        expect(info.count, equals(4));
      });
      test('calls every 17 ms', () {
        expect(info.stop - info.start, inDelta(17 * 3, 20));
      });
    });

    group('with a specified delay', () {
      var info = delay(250);
      test('first calls after the delay', () {
        expect(info.start - info.scheduled, inDelta(250, 20));
      });
      test('calls until the function returns true', () {
        expect(info.count, equals(4));
      });
      test('calls every 17 ms', () {
        expect(info.stop - info.start, inDelta(17 * 3, 20));
      });
    });

    group('with multiple registered tasks', () {
      var callback = this.callback, results = [];
      timer(() { results.push('A'); return true; });
      timer(() { results.push('B'); return true; });
      timer(() { results.push('C'); return true; });
      timer(() { callback(null, results); return true; });
      test('invokes tasks in the order they were registered', () {
        expect(results, equals(['A', 'B', 'C']));
      });
    });
  });
}

delay(delay) {
  var args = Array.prototype.slice.call(arguments);
  return (timer) {
    var cb = this.callback,
        info = {scheduled: Date.now(), count: 0};

    args.unshift(() {
      var count = ++info.count;
      if (count == 1) {
        info.start = Date.now();
      } else if (count == 4) {
        info.stop = Date.now();
        cb(null, info);
        return true;
      }
    });

    timer.apply(this, args);
  };
}
