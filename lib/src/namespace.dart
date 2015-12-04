@JS('d3.ns')
library d3.src.namespace;

import 'package:js/js.dart';

/// access or extend known XML namespaces.
external Map<String, String> get prefix;

/// qualify a prefixed name, such as "xlink:href".
external Map qualify(String name);
