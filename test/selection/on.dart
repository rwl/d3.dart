import 'package:unittest/unittest.dart';

import '../../src/selection/selection.dart' as d4;

void main() {
  group('select(body)', () {
    group('on a simple page', () {
      Selection body = d4.select('body');
      test('registers an event listener for the specified type', () {
        var form = body.append('form'), count = 0;
        form.on('submit', () { ++count; }); // jsdom has spotty event support
        form.append('input').attr('type', 'submit').node().click();
        expect(count, equals(1));
      });
      test('replaces an existing event listener for the same type', () {
        var form = body.append('form'), count = 0, fail = 0;
        form.on('submit', () { ++fail; });
        form.on('submit', () { ++count; });
        form.append('input').attr('type', 'submit').node().click();
        expect(count, equals(1));
        expect(fail, equals(0));
      });
      test('removes an existing event listener', () {
        var form = body.append('form'), fail = 0;
        form.on('submit', () { ++fail; });
        form.on('submit', null);
        form.append('input').attr('type', 'submit').node().click();
        expect(fail, equals(0));
        expect(form.on('submit'), isNull/*isUndefined*/);
      });
      /* Regrettably, JSDOM ignores the capture flag, so we can't test this yet…
      test('removing a listener doesn't require the capture flag', () {
        var form = body.append('form'), fail = 0;
        form.on('submit', () { ++fail; }, true);
        form.on('submit', null);
        form.append('input').attr('type', 'submit').node().click();
        expect(fail, equals(0));
        expect(form.on('submit'), isUndefined);
      });
      */
      test('ignores removal of non-matching event listener', () {
        body.append('form').on('submit', null);
      });
      test('observes the specified namespace', () {
        var form = body.append('form'), foo = 0, bar = 0;
        form.on('submit.foo', () { ++foo; });
        form.on({'submit.bar': () { ++bar; }});
        form.append('input').attr('type', 'submit').node().click();
        expect(foo, equals(1));
        expect(bar, equals(1));
      });
      test('can register listeners as a map', () {
        var form = body.append('form'), count = 0, fail = 0;
        form.on({submit: () { ++fail; }});
        form.on({submit: () { ++count; }});
        form.append('input').attr('type', 'submit').node().click();
        expect(count, equals(1));
        expect(fail, equals(0));
        form.on({submit: null});
        expect(form.on('submit'), isNull/*isUndefined*/);
      });
      /* Not really sure how to test this one…
      test('observes the specified capture flag', () {
      });
      */
      test('passes the current data and index to the event listener', () {
        var forms = body.html('').selectAll('form').data(['a', 'b']).enter().append('form'), dd, ii, data = new Object();
        forms.on('submit', (d, i) { dd = d; ii = i; });
        forms.append('input').attr('type', 'submit')[0][1].click();
        assert.equal(dd, 'b');
        assert.equal(ii, 1);
        forms[0][1].attributes['__data__'] = data;
        forms.append('input').attr('type', 'submit')[0][1].click();
        expect(dd, equals(data));
        expect(ii, equals(1));
      });
      test('uses the current element as the context', () {
        var forms = body.html('').selectAll('form').data(['a', 'b']).enter().append('form'), context;
        forms.on('submit', () { context = this; });
        forms.append('input').attr('type', 'submit')[0][1].click();
        expect(context, domEquals(forms[0][1]));
      });
      test('returns the current selection', () {
        expect(body.on('submit', () {}), same(body));
      });
      test('returns the assigned listener if called with one argument', () {
        body.on('mouseover', f).on('click.foo', f);
        f() {}
        expect(body.on('mouseover'), equals(f));
        expect(body.on('click.foo'), equals(f));
        expect(body.on('click'), isNull/*isUndefined*/);
        expect(body.on('mouseover.foo'), isNull/*isUndefined*/);
      });
      group('omitting the event type', () {
        test('returns undefined when retrieving a listener', () {
          expect(body.on('.foo'), isNull/*isUndefined*/);
        });
        test('null removes all named event listeners', () {
          body.on('mouseover.foo', f)
              .on('click.foo', f)
              .on('click.foobar', f)
              .on('.foo', null);
          f() {}
          expect(body.on('mouseover.foo'), isUndefined);
          expect(body.on('click.foo'), isUndefined);
          expect(body.on('click.foobar'), equals(f));
        });
        test('no-op when setting a listener', () {
          expect(body.on('.foo', () {}), same(body));
          expect(body.on('.foo'), isNull/*isUndefined*/);
        });
      });
    });
    test('sets the current event as d3.event', () {
      var form = d3.select('body').append('form'), event;
      form.on('submit', () { event = d3.event; });
      form.append('input').attr('type', 'submit').node().click();
      expect(event.type, equals('submit'));
      expect(event.target, domEquals(form[0][0]));
    });
    test('restores the original event after notifying listeners', () {
      var form = d3.select('body').append('form'), event = d3.event = new Object();
      form.on('submit', () {});
      form.append('input').attr('type', 'submit').node().click();
      expect(d3.event, equals(event));
    });
  });
}
