library d3.src.xhr;

import 'dart:js';
import 'd3.dart';

JsObject _d3 = context['d3'];

/// Request a resource using XMLHttpRequest.
Xhr xhr(String url,
    [String mimeType = undefinedString, callback(err, resp) = undefinedFn]) {
  var args = [url];
  if (mimeType != undefinedString) {
    args.add(mimeType);
  }
  if (callback != undefinedFn) {
    args.add(callback);
  }
  return new Xhr._(_d3.callMethod('xhr', args));
}

class Xhr {
  final JsObject _proxy;

  Xhr._(this._proxy);

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
  response([value(req) = undefinedFn]) {
    var args = [];
    if (value != undefinedFn) {
      args.add(value);
    }
    var retval = _proxy.callMethod('response', args);
    if (value == undefinedFn) {
      return retval;
    } else {
      return new Xhr._(retval);
    }
  }

  /// Issue a GET request.
  Xhr get([callback(err, resp) = undefinedFn]) {
    var args = [];
    if (callback != undefinedFn) {
      args.add(callback);
    }
    return new Xhr._(_proxy.callMethod('get', args));
  }

  /// Issue a POST request.
  Xhr post([data = undefined, callback(err, resp) = undefinedFn]) {
    var args = [];
    if (data != undefined) {
      args.add(data);
    }
    if (callback != undefinedFn) {
      args.add(callback);
    }
    return new Xhr._(_proxy.callMethod('post', args));
  }

  /// Issue a request with the specified method and data.
  Xhr send(String method,
      [data = undefined, callback(err, resp) = undefinedFn]) {
    var args = [method];
    if (data != undefined) {
      args.add(data);
    }
    if (callback != undefinedFn) {
      args.add(callback);
    }
    return new Xhr._(_proxy.callMethod('send', args));
  }

  /// Abort an outstanding request.
  abort() => new Xhr._(_proxy.callMethod('abort'));

  /// Add an event listener for "progress", "load" or "error" events.
  on(String type, [Function listener = undefinedFn]) {
    var args = [type];
    if (listener != undefinedFn) {
      args.add(listener);
    }
    var retval = _proxy.callMethod('on', args);
    if (listener == undefinedFn) {
      return retval;
    } else {
      return new Xhr._(retval);
    }
  }
}

/// Request a text file.
Xhr text(String url,
    [String mimeType = undefinedString, callback(err, resp) = undefinedFn]) {
  var args = [url];
  if (mimeType != undefinedString) {
    args.add(mimeType);
  }
  if (callback != undefinedFn) {
    args.add(callback);
  }
  return new Xhr._(_d3.callMethod('text', args));
}

/// Request a JSON blob.
Xhr json(String url, [callback(err, resp) = undefinedFn]) {
  var args = [url];
  if (callback != undefinedFn) {
    args.add(callback);
  }
  return new Xhr._(_d3.callMethod('json', args));
}

/// Request an XML document fragment.
Xhr xml(String url,
    [String mimeType = undefinedString, callback(err, resp) = undefinedFn]) {
  var args = [url];
  if (mimeType != undefinedString) {
    args.add(mimeType);
  }
  if (callback != undefinedFn) {
    args.add(callback);
  }
  return new Xhr._(_d3.callMethod('xml', args));
}

/// Request an HTML document fragment.
Xhr html(String url, [callback(err, resp) = undefinedFn]) {
  var args = [url];
  if (callback != undefinedFn) {
    args.add(callback);
  }
  return new Xhr._(_d3.callMethod('html', args));
}

/// Request a comma-separated values (CSV) file.
Xhr csv(String url,
    [accessor(d) = undefinedFn, callback(err, resp) = undefinedFn]) {
  var args = [url];
  if (accessor != undefinedFn) {
    args.add(accessor);
  }
  if (callback != undefinedFn) {
    args.add(callback);
  }
  return new Xhr._(_d3.callMethod('csv', args));
}

/// Request a tab-separated values (TSV) file.
Xhr tsv(String url,
    [accessor = undefinedFn, callback(err, resp) = undefinedFn]) {
  var args = [url];
  if (accessor != undefinedFn) {
    args.add(func3VarArgs(accessor));
  }
  if (callback != undefinedFn) {
    args.add(callback);
  }
  return new Xhr._(_d3.callMethod('tsv', args));
}
