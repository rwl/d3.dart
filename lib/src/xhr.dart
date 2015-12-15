library d3.src.xhr;

import 'dart:js';
import 'dart:async';

//import 'dart:html';
//import 'dart:convert' show JSON;

import 'js/xhr.dart' as xhr;

/// Request a JSON blob.
Future json(String url) async {
  var completer = new Completer<JsObject>();
  xhr.json(url, (err, resp) {
    if (err != null) {
      completer.completeError(err);
    } else {
      completer.complete(resp);
    }
  });
  return completer.future;

//  var req = await HttpRequest.request(url, mimeType: "application/json");
//  return JSON.decode(req.responseText);
}

/// Request a tab-separated values (TSV) file.
Future<List> tsv(String url, [accessor(d)]) {
  if (accessor == null) {
    accessor = (d) => d;
  }
  var completer = new Completer<List>();
  xhr.tsv(url, accessor, (err, data) {
    if (err != null) {
      completer.completeError(err);
    } else {
      completer.complete(data);
    }
  });
  return completer.future;
}
