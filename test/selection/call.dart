import 'package:unittest/unittest.dart';

import '../../src/selection/selection.dart' as d4;


void main() {
  group('select(body)', () {
    group('on a simple page', () {
      Selection body = d4.select('body');
      test('calls the function once', () {
        var count = 0;
        body.call(() { ++count; });
        expect(count, equals(1));
      });
      test('passes any optional arguments', () {
        var abc;
        body.call((selection, a, b, c) { abc = [a, b, c]; }, 'a', 'b', 'c');
        expect(abc, equals(['a', 'b', 'c']));
      });
      test('passes the selection as the first argument', () {
        var s;
        body.call((selection) { s = selection; });
        expect(s, same(body));
      });
      test('uses the selection as the context', () {
        var s;
        body.call(() { s = this; });
        expect(s, same(body));
      });
      test('returns the current selection', () {
        expect(body.call(() {}), same(body));
      });
    });
  });
  
  group('selectAll(div)', () {
    var d3 = load('selection/call').document();
    group('on a simple page', () {
      var div = d3.select('body').selectAll('div').data([0, 1]).enter().append('div');

      test('calls the function once', (div) {
        var count = 0;
        div.call(() { ++count; });
        expect(count, equals(1));
      });
      test('passes any optional arguments', (div) {
        var abc;
        div.call((selection, a, b, c) { abc = [a, b, c]; }, 'a', 'b', 'c');
        expect(abc, equals(['a', 'b', 'c']));
      });
      test('passes the selection as the first argument', (div) {
        var s;
        div.call((selection) { s = selection; });
        expect(s, same(div));
      });
      test('uses the selection as the context', (div) {
        var s;
        div.call(() { s = this; });
        expect(s, same(div));
      });
      test('returns the current selection', (div) {
        expect(div.call(() {}), same(div));
      });
    });
  });
}
