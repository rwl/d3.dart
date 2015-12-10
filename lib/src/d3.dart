library d3.src;

import 'dart:js';
import 'dart:collection';

class JsMap extends MapBase<String, dynamic> {
  final JsObject _proxy;

  JsMap(this._proxy);

  Iterable<String> get keys => context['Object'].callMethod('keys', [_proxy]);

  dynamic operator [](String key) => _proxy[key];

  void operator []=(String key, value) {
    _proxy[key] = value;
  }

  remove(String key) {
    _proxy.deleteProperty(key);
  }

  void clear() => keys.forEach((String k) => _proxy.deleteProperty(k));
}
