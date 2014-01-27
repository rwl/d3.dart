import 'package:unittest/unittest.dart';
import 'package:d3/scale/scale.dart' as scale;
import 'package:d3/color/color.dart' as color;

void main() {
  group('linear', () {
    group('domain', () {
      test('defaults to [0, 1]', () {
        var x = scale.linear();
        expect(x.domain(), equals([0, 1]));
        expect(x(.5), closeTo(.5, 1e-6));
      });
      test('coerces domain values to numbers', () {
        var x = scale.linear().domain([new DateTime(1990, 0, 1), new DateTime(1991, 0, 1)]);
        expect(x.domain()[0] is num, isTrue);
        expect(x.domain()[1] is num, isTrue);
        expect(x(new DateTime(1989, 09, 20)), closeTo(-.2, 1e-2));
        expect(x(new DateTime(1990, 00, 01)), closeTo(0, 1e-2));
        expect(x(new DateTime(1990, 02, 15)), closeTo(.2, 1e-2));
        expect(x(new DateTime(1990, 04, 27)), closeTo(.4, 1e-2));
        expect(x(new DateTime(1991, 00, 01)), closeTo(1, 1e-2));
        expect(x(new DateTime(1991, 02, 15)), closeTo(1.2, 1e-2));
        x = scale.linear().domain(['0', '1']);
        expect(x.domain()[0] is num, isTrue);
        expect(x.domain()[1] is num, isTrue);
        expect(x(.5), closeTo(.5, 1e-6));
        //x = scale.linear().domain([new Number(0), new Number(1)]);
        //expect(x.domain()[0] is num, isTrue);
        //expect(x.domain()[1] is num, isTrue);
        //expect(x(.5), closeTo(.5, 1e-6));
      });
      /*test('can specify a polylinear domain and range', () {
        var x = scale.linear().domain([-10, 0, 100]).range(['red', 'white', 'green']);
        expect(x(-5), equals('#ff8080'));
        expect(x(50), equals('#80c080'));
        expect(x(75), equals('#40a040'));
      });
      test('the smaller of the domain or range is observed', () {
        var x = d3.scale.linear().domain([-10, 0]).range(['red', 'white', 'green']).clamp(true);
        expect(x(-5), equals('#ff8080'));
        expect(x(50), equals('#ffffff'));
        x = d3.scale.linear().domain([-10, 0, 100]).range(['red', 'white']).clamp(true);
        expect(x(-5), equals('#ff8080'));
        expect(x(50), equals('#ffffff'));
      });
      test('an empty domain maps to the range start', () {
        var x = d3.scale.linear().domain([0, 0]).range(['red', 'green']);
        expect(x(0), equals('#ff0000'));
        expect(x(-1), equals('#ff0000'));
        expect(x(1), equals('#ff0000'));
      });*/
    });

    group('range', () {
      test('defaults to [0, 1]', () {
        var x = scale.linear();
        expect(x.range(), equals([0, 1]));
        expect(x.invert(.5), closeTo(.5, 1e-6));
      });
      test('does not coerce range to numbers', () {
        var x = scale.linear().range(['0', '2']);
        expect(x.range()[0] is String, isTrue);
        expect(x.range()[1] is String, isTrue);
      });
      test('can specify range values as colors', () {
        var x = scale.linear();
        x.range(['red', 'blue']);
        expect(x(.5), equals('#800080'));
//        x = scale.linear().range(['#ff0000', '#0000ff']);
//        expect(x(.5), equals('#800080'));
//        x = scale.linear().range(['#f00', '#00f']);
//        expect(x(.5), equals('#800080'));
        x = scale.linear().range([color.rgb(255,0,0), color.hsl(240,1,.5)]);
        expect(x(.5), equals('#800080'));
//        x = scale.linear().range(['hsl(0,100%,50%)', 'hsl(240,100%,50%)']);
//        expect(x(.5), equals('#800080'));
      });
      /*test('can specify range values as arrays or objects', () {
        var x = scale.linear().range([{'color': 'red'}, {'color': 'blue'}]);
        expect(x(.5), equals({'color': '#800080'}));
        x = scale.linear().range([['red'], ['blue']]);
        expect(x(.5), equals(['#800080']));
      });*/
    });
  });
}