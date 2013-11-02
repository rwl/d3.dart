import 'package:unittest/unittest.dart';

void main() {
  group('text', () {
    var text = load('xhr/text').expression('d3.text').document();

    group('on a sample file', () {
      var text = () {
        text('test/data/sample.txt', this.callback);
      };
      test('invokes the callback with the loaded text', () {
        expect(text, equals('Hello, world!\n'));
      });
      test('does not override the mime type by default', () {
        expect(XMLHttpRequest._last._info.mimeType, isUndefined);
      });
    });

    group('with a custom mime type', () {
      var text = () {
        text('test/data/sample.txt', 'text/plain+sample', this.callback);
      };
      test('observes the optional mime type', () {
        expect(XMLHttpRequest._last._info.mimeType, equals('text/plain+sample'));
      });
    });

    test('on a file that does not exist', () {
      var text = () {
        var callback = this.callback;
        text('//does/not/exist.txt', (error, text) {
          callback(null, text);
        });
      };
      test('invokes the callback with undefined when an error occurs', () {
        expect(text, isUndefined);
      });
    });
  });
}
