@JS('d3')
library d3.src.dsv;

import 'package:js/js.dart';

/// Create a parser/formatter for the specified delimiter and mime type.
external dsv(url, [accessor, callback]);

@JS()
abstract class Dsv implements Function {
  call(delimiter, mimeType) => dsv(delimiter, mimeType);
  dsv(delimiter, mimeType);

  external parse(string, [accessor]);
  external parseRows(string, [accessor]);
  external format(rows);
  external formatRows(rows);
}
