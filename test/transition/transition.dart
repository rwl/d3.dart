import 'package:unittest/unittest.dart';

void main() {
  var t1 = () {
    return d3.select('body').append('div').transition()
        .delay(101)
        .duration(152)
        .ease('bounce');
  };

  test('starts immediately after the previous transition ends', () {
    var t2 = t1.transition();
    expect(t2[0][0].__transition__[t2.id].delay, equals(253));
  });
  test('inherits the previous transition\'s duration', () {
    var t2 = t1.transition();
    expect(t2[0][0].__transition__[t2.id].duration, equals(152));
  });
  test('inherits easing', () {
    // TODO how to test this?
  });
  test('gets a new transition id', () {
    var t2 = t1.transition();
    expect(t2.id > t1.id, isTrue);
  });

  group('while transitioning', () {
    var t2 = () {
      var callback = this.callback;
      var t2 = t1.transition().tween('custom', () {
        return (t) {
          if (callback) {
            callback(null, t2);
            callback = null;
          }
        };
      });
    };
    test('increments the lock\'s reference count', () {
      expect(t2[0][0].__transition__.count > 1, isTrue);
    });
  });

  group('after transitioning', () {
    var t2 = (t1) {
      var cb = this.callback;
      var t2 = t1.transition();
      t2.each('end', () {
        setTimeout(() {
          cb(null, t2);
          return true;
        }, 50);
      });
    };
    test('decrements the lock\'s reference count', () {
      expect('__transition__' in t2[0][0], isFalse);
    });
  });
}
