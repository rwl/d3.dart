@JS('d3')
library d3.src.xhr;

import 'package:js/js.dart';

external Xhr xhr(url, [mimeType, callback]);

class Xhr {
  external header(name, [value]);
  external mimeType([type]);
  external responseType(type);
  external response(value);
  external get([callback]);
  external post([data, callback]);
  external send(method, [data, callback]);
  external abort();
  external on(type, [listener]);
}

external text(url, [mimeType, callback]);
external json(url, [callback]);
external xml(url, [mimeType, callback]);
external html(url, [callback]);
external csv(url, [accessor, callback]);
external tsv(url, [accessor, callback]);
