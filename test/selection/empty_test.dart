import 'package:test/test.dart';
import 'package:d3/js/d3.dart';

main() {
  group('select(body)', () {
    group('on a simple page', () {
      final Selection body = select('body');
      test('returns true for empty selections', () {
        expect(body.select('foo').empty(), isTrue);
      });
      test('returns false for non-empty selections', () {
        expect(body.empty(), isFalse);
      });
      test('ignores null nodes', () {
        body[0][0] = null;
        expect(body.empty(), isTrue);
      });
    });
  });
}
