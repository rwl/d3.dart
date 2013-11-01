import 'package:unittest/unittest.dart';

void main() {
  group('start', () {
    var result = () {
      var callback = this.callback,
          div = d3.select('body').html('').selectAll().data(['foo', 'bar']).enter().append('div').attr('class', String),
          transition = div.transition().delay(350),
          then = Date.now(),
          n = 0,
          calls = [],
          context = [],
          data = [],
          index = [],
          count = [],
          delay = [];

      // A callback to verify that multiple callbacks are allowed.
      transition.each('start.other', () {
        ++n;
      });

      // A callback which captures arguments and context.
      transition.each('start', (d, i) {
        context.push(this);
        data.push(d);
        index.push(i);
        count.push(++n);
        delay.push(Date.now() - then);
        if (n >= 4) callback(null, {
          selection: div,
          delay: delay,
          context: context,
          data: data,
          index: index,
          count: count,
          id: transition.id
        });
      });
    };

    test('invokes the listener after the specified delay', () {
      expect(result.delay, inDelta([350, 350], 20));
    });
    test('invokes each listener exactly once, in order', () {
      expect(result.count, equals([2, 4]));
    });

    // For the same node, listeners will be called back in order, according to
    // the implementation of d3.dispatch. However, the order of callbacks across
    // nodes is not guaranteed; currently, callbacks are in reverse order if
    // they share the same delay, because of the timer queue. I suppose it'd be
    // slightly better if the callbacks were invoked in node order (consistent
    // with selections), but since these callbacks happen asynchronously I don't
    // think the API needs to guarantee the order of callbacks.

    test('uses the node as the context', () {
      expect(result.context[0], domEquals(result.selection[0][0]));
      expect(result.context[1], domEquals(result.selection[0][1]));
    });
    test('passes the data and index to the function', () {
      expect(result.data, equals(['foo', 'bar']), 'expected data, got {actual}');
      expect(result.index, equals([0, 1]), 'expected index, got {actual}');
    });

    test('sets an exclusive lock on transitioning nodes', () {
      var id = result.id;
      expect(id > 0);
      expect(result.selection[0][0].__transition__.count, equals(1));
      expect(result.selection[0][1].__transition__.count, equals(1));
      expect(result.selection[0][0].__transition__.active, equals(id));
      expect(result.selection[0][1].__transition__.active, equals(id));
    });
  });

  group('end', () {
    var result = () {
      var callback = this.callback,
          div = d3.select('body').html('').selectAll().data(['foo', 'bar']).enter().append('div').attr('class', String),
          transition = div.transition().duration(350),
          then = Date.now(),
          n = 0,
          calls = [],
          context = [],
          data = [],
          index = [],
          count = [],
          delay = [];

      // A callback to verify that multiple callbacks are allowed.
      transition.each('end.other', () {
        ++n;
      });

      // A callback which captures arguments and context.
      transition.each('end', (d, i) {
        context.push(this);
        data.push(d);
        index.push(i);
        count.push(++n);
        delay.push(Date.now() - then);
        if (n >= 4) callback(null, {
          selection: div,
          delay: delay,
          context: context,
          data: data,
          index: index,
          count: count,
          id: transition.id
        });
      });
    });

    test('invokes the listener after the specified delay', () {
      expect(result.delay, inDelta([350, 350], 20));
    });
    test('invokes each listener exactly once, in order', () {
      expect(result.count, equals([2, 4]));
    });

    // For the same node, listeners will be called back in order, according to
    // the implementation of d3.dispatch. However, the order of callbacks across
    // nodes is not guaranteed; currently, callbacks are in reverse order if
    // they share the same delay, because of the timer queue. I suppose it'd be
    // slightly better if the callbacks were invoked in node order (consistent
    // with selections), but since these callbacks happen asynchronously I don't
    // think the API needs to guarantee the order of callbacks.

    test('uses the node as the context', () {
      expect(result.context[0], domEquals(result.selection[0][0]));
      expect(result.context[1], domEquals(result.selection[0][1]));
    });
    test('passes the data and index to the function', () {
      expect(result.data, equals(['foo', 'bar']), 'expected data, got {actual}');
      expect(result.index, equals([0, 1]), 'expected index, got {actual}');
    });

    group('after the transition ends', () {
      var result = () {
        var callback = this.callback;
        process.nextTick(() {
          callback(null, result);
        });
      };
      test('deletes the transition lock', () {
        expect('__transition__' in result.selection[0][0], isFalse);
        expect('__transition__' in result.selection[0][1], isFalse);
      });
    });

    // I'd like to test d3.timer.flush here, but unfortunately there's a bug in
    // Vows where it really doesn't like to receive multiple callbacks from
    // different tests at the same time!

    group('sequenced', () {
      var result = () {
        var callback = this.callback,
            node = d3.select('body').append('div').node(),
            id = result.id;
        d3.select(node).transition().delay(150).each('start', () {
          callback(null, {id: id, node: this});
        });
      };
      test('does not inherit the transition id', () {
        expect(result.id > 0, isTrue);
        expect(result.node.__transition__.count, equals(1));
        expect(result.node.__transition__.active > result.id, isTrue);
      });
    });
  });
}