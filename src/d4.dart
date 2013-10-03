// Copyright (c) 2013, Michael Bostock

library d4;

import 'dart:html';

import 'core/document.dart';
import 'selection/selection.dart' as s;


Element selection() {
  //return sel.selectionRoot;
  return select(d4_documentElement);
}

Selection select(String node) {
  var group = [s.select(node, document)];
  group.parentNode = documentElement;
  return s.selection([group]);
}

Selection selectElement(Element node) {
  group = [node];
  group.parentNode = documentElement;
  return s.selection([group]);
}

Selection selectAll(String nodes) {
  var group = d3_array(s.selectAll(nodes, d4_document));
  group.parentNode = d4_documentElement;
  return s.selection([group]);
};

Selection selectAllElements(List<Element> nodes) {
  var group = d3_array(nodes);
  group.parentNode = d4_documentElement;
  return s.selection([group]);
};
