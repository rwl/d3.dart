library d3.src.js.xhr;

import 'dart:js';
import 'd3.dart';

JsObject _d3 = context['d3'];

/// Request a resource using XMLHttpRequest.
Xhr xhr(String url,
    [/*String*/ mimeType = undefined, /*Function*/ callback = undefined]) {
  var args = [url];
  if (mimeType != undefined) {
    args.add(mimeType);
  }
  if (callback != undefined) {
    args.add(callback);
  }
  return new Xhr._(_d3.callMethod('xhr', args));
}

class Xhr {
  final JsObject _proxy;

  Xhr._(this._proxy);

  factory Xhr(String url,
          [/*String*/ mimeType = undefined,
          /*Function*/ callback = undefined]) =>
      xhr(url, mimeType, callback);

  factory Xhr.text(String url,
          [/*String*/ mimeType = undefined,
          /*Function*/ callback = undefined]) =>
      text(url, mimeType, callback);

  factory Xhr.json(String url, [/*Function*/ callback = undefined]) =>
      json(url, callback);

  factory Xhr.xml(String url,
          [/*String*/ mimeType = undefined,
          /*Function*/ callback = undefined]) =>
      xml(url, mimeType, callback);

  factory Xhr.html(String url, [/*Function*/ callback = undefined]) =>
      html(url, callback);

  factory Xhr.csv(String url,
          [/*Function*/ accessor = undefined, /*Function*/ callback =
              undefined]) =>
      csv(url, accessor, callback);

  factory Xhr.tsv(String url,
          [/*Function*/ accessor = undefined, /*Function*/ callback =
              undefined]) =>
      tsv(url, accessor, callback);

  /// Set a request header.
  header(String name, [value = undefined]) {
    var args = [name];
    if (value != undefined) {
      args.add(value);
    }
    var retval = _proxy.callMethod('header', args);
    if (value == undefined) {
      return retval;
    } else {
      return new Xhr._(retval);
    }
  }

  /// Set the Accept request header and override the response MIME type.
  mimeType([type = undefined]) {
    var args = [];
    if (type != undefined) {
      args.add(type);
    }
    var retval = _proxy.callMethod('mimeType', args);
    if (type == undefined) {
      return retval;
    } else {
      return new Xhr._(retval);
    }
  }

  responseType([type = undefined]) {
    var args = [];
    if (type != undefined) {
      args.add(type);
    }
    var retval = _proxy.callMethod('responseType', args);
    if (type == undefined) {
      return retval;
    } else {
      return new Xhr._(retval);
    }
  }

  /// Set a response mapping function.
  response([/*Function*/ value(req) = undefined]) {
    var args = [];
    if (value != undefined) {
      args.add(value);
    }
    var retval = _proxy.callMethod('response', args);
    if (value == undefined) {
      return retval;
    } else {
      return new Xhr._(retval);
    }
  }

  /// Issue a GET request.
  Xhr get([/*Function*/ callback = undefined]) {
    var args = [];
    if (callback != undefined) {
      args.add(callback);
    }
    return new Xhr._(_proxy.callMethod('get', args));
  }

  /// Issue a POST request.
  Xhr post([data = undefined, /*Function*/ callback = undefined]) {
    var args = [];
    if (data != undefined) {
      args.add(data);
    }
    if (callback != undefined) {
      args.add(callback);
    }
    return new Xhr._(_proxy.callMethod('post', args));
  }

  /// Issue a request with the specified method and data.
  Xhr send(String method,
      [data = undefined, /*Function*/ callback = undefined]) {
    var args = [method];
    if (data != undefined) {
      args.add(data);
    }
    if (callback != undefined) {
      args.add(callback);
    }
    return new Xhr._(_proxy.callMethod('send', args));
  }

  /// Abort an outstanding request.
  abort() => new Xhr._(_proxy.callMethod('abort'));

  /// Add an event listener for "progress", "load" or "error" events.
  on(String type, [/*Function*/ listener = undefined]) {
    var args = [type];
    if (listener != undefined) {
      args.add(listener);
    }
    var retval = _proxy.callMethod('on', args);
    if (listener == undefined) {
      return retval;
    } else {
      return new Xhr._(retval);
    }
  }
}

/// Request a text file.
Xhr text(String url,
    [/*String*/ mimeType = undefined, /*Function*/ callback = undefined]) {
  var args = [url];
  if (mimeType != undefined) {
    args.add(mimeType);
  }
  if (callback != undefined) {
    args.add(callback);
  }
  return new Xhr._(_d3.callMethod('text', args));
}

/// Request a JSON blob.
Xhr json(String url, [/*Function*/ callback = undefined]) {
  var args = [url];
  if (callback != undefined) {
    args.add(callback);
  }
  return new Xhr._(_d3.callMethod('json', args));
}

/// Request an XML document fragment.
Xhr xml(String url,
    [/*String*/ mimeType = undefined, /*Function*/ callback = undefined]) {
  var args = [url];
  if (mimeType != undefined) {
    args.add(mimeType);
  }
  if (callback != undefined) {
    args.add(callback);
  }
  return new Xhr._(_d3.callMethod('xml', args));
}

/// Request an HTML document fragment.
Xhr html(String url, [/*Function*/ callback = undefined]) {
  var args = [url];
  if (callback != undefined) {
    args.add(callback);
  }
  return new Xhr._(_d3.callMethod('html', args));
}

/// Request a comma-separated values (CSV) file.
Xhr csv(String url,
    [/*Function*/ accessor = undefined, /*Function*/ callback = undefined]) {
  var args = [url];
  if (accessor != undefined) {
    args.add(accessor);
  }
  if (callback != undefined) {
    args.add(callback);
  }
  return new Xhr._(_d3.callMethod('csv', args));
}

/// Request a tab-separated values (TSV) file.
Xhr tsv(String url,
    [/*Function*/ accessor = undefined, /*Function*/ callback = undefined]) {
  var args = [url];
  if (accessor != undefined) {
    args.add(func3VarArgs(accessor));
  }
  if (callback != undefined) {
    args.add(callback);
  }
  return new Xhr._(_d3.callMethod('tsv', args));
}
