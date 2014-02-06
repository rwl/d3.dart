part of selection;

final parentProp = new Expando<Node>('parentNode');

parentNode(List<Element> group, [Node node = null]) {
  if (node == null) {
    return parentProp[group];
  }
  parentProp[group] = node;
}

final updateProp = new Expando<List>('update');

updateGroup(List<Element> group, [List upgroup = null]) {
  if (upgroup == null) {
    return updateProp[group];
  }
  updateProp[group] = upgroup;
}