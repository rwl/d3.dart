import 'package:unittest/unittest.dart';

void main() {
  group('xml', () {
    var xml = load('xhr/xml').expression('d3.xml').document();

    group('on a sample file', () {
      var xml = () {
        xml('test/data/sample.xml', this.callback);
      };
      test('invokes the callback with the loaded xml', () {
        expect(xml, equals({_xml: '<?xml version=\'1.0\' encoding=\'UTF-8\' ?>\n<hello>\n  <world name=\'Earth\'/>\n</hello>\n'}));
      });
      test('does not override the mime type by default', () {
        expect(XMLHttpRequest._last._info.mimeType, isUndefined);
      });
    });

    group('with a custom mime type', () {
      var xml = () {
        xml('test/data/sample.txt', 'application/xml+sample', this.callback);
      };
      test('observes the optional mime type', () {
        expect(XMLHttpRequest._last._info.mimeType, equals('application/xml+sample'));
      });
    });

    group('on a file that does not exist', () {
      var xml = () {
        var callback = this.callback;
        xml('//does/not/exist.xml', (error, xml) {
          callback(null, xml);
        });
      };
      test('invokes the callback with undefined when an error occurs', () {
        expect(xml, isUndefined);
      });
    });
  });
}
