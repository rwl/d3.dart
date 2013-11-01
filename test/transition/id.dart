import 'package:unittest/unittest.dart';

void main() {
  group('on a new transition', () {
    var transition = () {
      return d3.select('body').append('div').transition();
    };
    test('has a positive integer id', () {
      var id = transition.id;
      expect(id > 0, isTrue);
      expect(~~id, equals(id));
    });
  });
  test('increases monotonically across transitions', () {
    var t0 = d3.select('body').append('div').transition(),
        t1 = d3.select('body').append('div').transition();
    expect(t1.id > t0.id, isTrue);
  });
}
