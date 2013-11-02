import 'package:unittest/unittest.dart';

void main() {
  group('html', () {
    var html = load('xhr/html').expression('d3.html').document();

    group('on a sample file', () {
      var document = (html) {
        html('test/data/sample.html', this.callback);
      };
      test('invokes the callback with the loaded html', () {
        expect(document.getElementsByTagName('H1')[0].textContent, equals('Hello & world!'));
      });
      test('override the mime type to text/html', () {
        expect(XMLHttpRequest._last._info.mimeType, equals('text/html'));
      });
    });

    group('on a file that does not exist', () {
      var document = () {
        var callback = this.callback;
        html('//does/not/exist.html', (error, document) {
          callback(null, document);
        });
      };
      test('invokes the callback with undefined when an error occurs', () {
        expect(document, isUndefined);
      });
    });
  });
}
