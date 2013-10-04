import 'package:unittest/unittest.dart';

import '../../src/selection/selection.dart' as d4;

void main() {
  group('selectAll(div)', () {
    var d3 = load("selection/enter").document();
    test('is an instanceof d3.selection.enter', () {
      var enter = d3.select("body").selectAll("div").data([0, 1]).enter();
      expect(enter, new isInstanceOf<d3.selection.enter>());
    });
    test("selection prototype can be extended", () {
      var enter = d3.select("body").html("").selectAll("div").data([0, 1]).enter();
      d3.selection.enter.prototype.foo = () { return this.append("foo"); };
      var selection = enter.foo();
      expect(d3.select("body").html(), equals("<foo></foo><foo></foo>"));
//      delete d3.selection.enter.prototype.foo;
    });
  });
}
