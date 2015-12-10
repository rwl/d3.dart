library d3.test.util;

import 'dart:js';

parentNode(node) {
  var js = new JsObject.fromBrowserObject(node);
  return js['parentNode'];
}

nodeData(node) {
  var js = new JsObject.fromBrowserObject(node);
  return js['__data__'];
}

void setNodeData(node, value) {
  var js = new JsObject.fromBrowserObject(node);
  js['__data__'] = value;
}

void deleteNodeData(node) {
  var js = new JsObject.fromBrowserObject(node);
  js.deleteProperty('__data__');
}
