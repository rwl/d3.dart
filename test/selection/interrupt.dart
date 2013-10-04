import 'package:unittest/unittest.dart';

import '../../src/selection/selection.dart' as d4;

void main() {
  group('interrupt', () {
    var d3 = load('transition/transition').document();
    test('returns the current selection', () {
      var selection = d3.select('body').append('div');
      expect(selection.interrupt(), same(selection));
    });
    test('increments the active transition', () {
      var selection = d3.select('body').append('div'),
          transition = selection.transition();
      expect(selection.node().__transition__.active, equals(0)); // transition hasn’t yet started
      d3.timer.flush();
      expect(selection.node().__transition__.active, equals(transition.id)); // transition has started
      selection.interrupt();
      expect(selection.node().__transition__.active, equals(transition.id + 1)); // transition was interrupted
    });
    test('does nothing if there is no active transition', () {
      var selection = d3.select('body').append('div');
      expect(selection.node().__transition__, isNull/*isUndefined*/); // no transition scheduled
      selection.interrupt();
      expect(selection.node().__transition__, isNull/*isUndefined*/); // still no transition scheduled
    });
  });
}
