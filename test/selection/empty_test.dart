import 'package:unittest/unittest.dart';
import 'package:unittest/html_enhanced_config.dart';
import 'package:d3/selection/selection.dart';

main() {
  useHtmlEnhancedConfiguration();

  group('select(body)', () {
    group('on a simple page', () {
      final Selection body = new Selection.selector('body');
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
