library d3.src.xhr;

import 'dart:js';
import 'dart:async';
import 'js/xhr.dart' as xhr;
//import 'd3.dart';

/// Request a JSON blob.
Future<JsObject> json(String url) {
  var completer = new Completer<JsObject>();
  xhr.json(url, (err, resp) {
    if (err != null) {
      completer.completeError(err);
    } else {
//      completer.complete(new JsMap(resp));
      completer.complete(resp);
    }
  });
  return completer.future;
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
