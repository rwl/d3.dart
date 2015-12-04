@JS('d3')
library d3.src.xhr;

import 'package:js/js.dart';

/// request a resource using XMLHttpRequest.
external Xhr xhr(url, [mimeType, callback]);

@JS()
class Xhr {
  /// set a request header.
  external header(name, [value]);

  /// set the Accept request header and override the response MIME type.
  external mimeType([type]);
  external responseType(type);

  /// set a response mapping function.
  external response(value);

  /// issue a GET request.
  external get([callback]);

  /// issue a POST request.
  external post([data, callback]);

  /// issue a request with the specified method and data.
  external send(method, [data, callback]);

  /// abort an outstanding request.
  external abort();

  /// add an event listener for "progress", "load" or "error" events.
  external on(type, [listener]);
}

/// request a text file.
external text(url, [mimeType, callback]);

/// request a JSON blob.
external json(url, [callback]);

/// request an XML document fragment.
external xml(url, [mimeType, callback]);

/// request an HTML document fragment.
external html(url, [callback]);

/// request a comma-separated values (CSV) file.
external csv(url, [accessor, callback]);

/// request a tab-separated values (TSV) file.
external tsv(url, [accessor, callback]);
