library d3.src.xhr;

import 'dart:js';

JsObject _d3 = context['d3'];

/// Request a resource using XMLHttpRequest.
Xhr xhr(url, [mimeType, callback]) {
  return _d3.callMethod('xhr', []);
}

class Xhr {
  final JsObject _proxy;

  Xhr._(this._proxy);

  /// Set a request header.
  header(name, [value]) {
    return _proxy.callMethod('header', []);
  }

  /// Set the Accept request header and override the response MIME type.
  mimeType([type]) {
    return _proxy.callMethod('mimeType', []);
  }

  responseType(type) {
    return _proxy.callMethod('responseType', []);
  }

  /// Set a response mapping function.
  response(value) {
    return _proxy.callMethod('response', []);
  }

  /// Issue a GET request.
  get([callback]) {
    return _proxy.callMethod('get', []);
  }

  /// Issue a POST request.
  post([data, callback]) {
    return _proxy.callMethod('post', []);
  }

  /// Issue a request with the specified method and data.
  send(method, [data, callback]) {
    return _proxy.callMethod('send', []);
  }

  /// Abort an outstanding request.
  abort() {
    return _proxy.callMethod('abort', []);
  }

  /// Add an event listener for "progress", "load" or "error" events.
  on(type, [listener]) {
    return _proxy.callMethod('on', []);
  }
}

/// Request a text file.
text(url, [mimeType, callback]) {
  return _d3.callMethod('text', []);
}

/// Request a JSON blob.
json(url, [callback]) {
  return _d3.callMethod('json', []);
}

/// Request an XML document fragment.
xml(url, [mimeType, callback]) {
  return _d3.callMethod('xml', []);
}

/// Request an HTML document fragment.
html(url, [callback]) {
  return _d3.callMethod('html', []);
}

/// Request a comma-separated values (CSV) file.
csv(url, [accessor, callback]) {
  return _d3.callMethod('csv', []);
}

/// Request a tab-separated values (TSV) file.
tsv(url, [accessor, callback]) {
  return _d3.callMethod('tsv', []);
}
