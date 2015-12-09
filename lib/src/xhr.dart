library d3.src.xhr;

import 'dart:async';

import 'js/xhr.dart' as xhr;

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
