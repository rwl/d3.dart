library d3.src.namespace;

import 'dart:js';

JsObject _ns = context['d3']['ns'];

/// Access or extend known XML namespaces.
Map<String, String> get prefix {
  return _ns['prefix'];
}

/// Qualify a prefixed name, such as "xlink:href".
Map qualify(String name) {
  return _ns.callMethod('qualify', []);
}
