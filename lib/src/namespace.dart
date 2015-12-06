library d3.src.namespace;

import 'dart:js';

JsObject _ns = context['d3']['ns'];

/// Access or extend known XML namespaces.
get prefix => _ns['prefix'];

/// Qualify a prefixed name, such as "xlink:href".
qualify(String name) => _ns.callMethod('qualify', [name]);
