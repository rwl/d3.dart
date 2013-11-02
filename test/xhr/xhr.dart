import 'package:unittest/unittest.dart';

void main() {
  group('xhr', () {
    var d3 = load('xhr/xhr').document();

    group('on a sample text file', () {
      var req = () {
        d3.xhr('test/data/sample.txt', this.callback);
      };
      test('makes an asynchronous HTTP request', () {
        expect(req._info.url, equals('test/data/sample.txt'));
        assert.isTrue(req._info.async, isTrue);
      });
      test('invokes the callback with the request object', () {
        expect(req.responseText, equals('Hello, world!\n'));
      });
      test('does not override the mime type by default', () {
        assert.isUndefined(req._info.mimeType, isUndefined);
      });
      test('waits until the request is done', () {
        expect(req.readyState, equals(4));
        expect(req.status, equals(200));
      });
    });

    group('when a custom mime type is specified', () {
      var req = () {
        d3.xhr('test/data/sample.txt', 'text/plain', this.callback);
      };
      test('observes the optional mime type', () {
        expect(req._info.mimeType, equals('text/plain'));
      });
    });

    group('when a beforesend listener is specified', () {
      var result = () {
        var callback = this.callback;
        var xhr = d3.xhr('test/data/sample.txt', 'text/plain').on('beforesend', (request) {
          callback(null, {
            that: this,
            xhr: xhr,
            readyState: request.readyState,
            request: request
          });
        });
        xhr.get();
      };
      test('invokes the beforesend listener with the xhr object as the context', () {
        expect(result.that, equals(result.xhr));
        expect(result.xhr.get, ok);
      });
      test('invokes the beforesend listener with the underlying XMLHttpRequest as an argument', () {
        expect(result.request, instanceOf(XMLHttpRequest));
      });
      test('invokes the beforesend listener after open and before send', () {
        expect(result.readyState, equals(1));
      });
    });

    group('on a file that does not exist', () {
      var req = () {
        var callback = this.callback;
        d3.xhr('//does/not/exist.txt', (error, req) {
          callback(null, req);
        });
      };
      test('invokes the callback with undefined when an error occurs', () {
        expect(req, isUndefined);
      });
    });
  });
}
