import 'package:unittest/unittest.dart';

void main() {
  group('json', () {
    var json = load('xhr/json').expression('d3.json').document();

    group('on a sample file', () {
      var json = () {
        json('test/data/sample.json', this.callback);
      };
      test('invokes the callback with the loaded JSON', () {
        expect(json, equals([{'Hello':42,'World':'\'fish\''}]));
      });
      test('overrides the mime type to application/json', () {
        expect(XMLHttpRequest._last._info.mimeType, equals('application/json'));
      });
    });

    group('on a file that does not exist', () {
      var result = () {
        var callback = this.callback;
        json('//does/not/exist.json', (error, json) {
          callback(null, {error: error, value: json});
        });
      };
      test('invokes the callback with undefined when an error occurs', () {
        expect(result.error.status, equals(404));
        expect(result.value, isUndefined);
      });
    });

    group('on a file with invalid JSON', () {
      var result = () {
        var callback = this.callback;
        json('test/data/sample.tsv', (error, json) {
          callback(null, {error: error, value: json});
        });
      };
      test('invokes the callback with undefined when an error occurs', () {
        expect(result.error.constructor.name, equals('SyntaxError'));
        expect(result.value, isUndefined);
      });
    });
  });
}