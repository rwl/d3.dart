import 'package:unittest/unittest.dart';
import 'package:unittest/html_enhanced_config.dart';
import 'package:d3/selection/selection.dart';

main() {
  useHtmlEnhancedConfiguration();

  group('select(body)', () {
    group('on an initially-empty page', () {
      final Selection body = new Selection.selector('body');
      test('sets the text content as a string', () {
        body.text('Hello, world!');
        expect(body.node.text, equals('Hello, world!'));
      });
      test('sets the text content as a number', () {
        body.text(42);
        expect(body.node.text, equals('42'));
      });
      test('sets the text content as a function', () {
        body.data(['Subject']).textFunc((n, d, i, j) { return 'Hello, $d $i!'; });
        expect(body.node.text, equals('Hello, Subject 0!'));
      });
      test('escapes html content to text', () {
        body.text('<h1>Hello, world!</h1>');
        expect(body.node.text, equals('<h1>Hello, world!</h1>'));
        expect(body.node.firstChild.nodeType, equals(3));
      });
      test('clears the text content as null', () {
        body.text(null);
        expect(body.node.text, equals(''));
      });
      test('clears the text content as null', () {
        body.textNull();
        expect(body.node.text, equals(''));
      });
      test('clears the text content as a function returning null', () {
        body.textFunc((n, d, i, j) { return null; });
        expect(body.node.text, equals(''));
      });
      test('returns the current selection', () {
        expect(body..text('hello'), same(body));
      });
      test('ignores null nodes', () {
        var node = body.node;
        node.text = 'foo';
        body[0][0] = null;
        body.text('bar');
        expect(node.text, equals('foo'));
      });
    });
  });
}
