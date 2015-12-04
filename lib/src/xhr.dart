@JS('d3')
library d3.src.xhr;

import 'package:js/js.dart';

/// Request a resource using XMLHttpRequest.
external Xhr xhr(url, [mimeType, callback]);

@JS()
class Xhr {
  /// Set a request header.
  external header(name, [value]);

  /// Set the Accept request header and override the response MIME type.
  external mimeType([type]);
  external responseType(type);

  /// Set a response mapping function.
  external response(value);

  /// Issue a GET request.
  external get([callback]);

  /// Issue a POST request.
  external post([data, callback]);

  /// Issue a request with the specified method and data.
  external send(method, [data, callback]);

  /// Abort an outstanding request.
  external abort();

  /// Add an event listener for "progress", "load" or "error" events.
  external on(type, [listener]);
}

/// Request a text file.
external text(url, [mimeType, callback]);

/// Request a JSON blob.
external json(url, [callback]);

/// Request an XML document fragment.
external xml(url, [mimeType, callback]);

/// Request an HTML document fragment.
external html(url, [callback]);

/// Request a comma-separated values (CSV) file.
external csv(url, [accessor, callback]);

/// Request a tab-separated values (TSV) file.
external tsv(url, [accessor, callback]);
