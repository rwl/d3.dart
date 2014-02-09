part of selection;

final parentProp = new Expando<Node>('parentNode');

setParentNode(final List<Element> group, final Node node) {
  parentProp[group] = node;
}

Node parentNode(final List<Element> group) {
  return parentProp[group];
}

final updateProp = new Expando<List>('update');

setUpdate(final List<Element> group, final List<Element> upgroup) {
  updateProp[group] = upgroup;
}

List<Element> getUpdate(List<Element> group) {
  return updateProp[group];
}

final dataProp = new Expando<Object>('data');

setNodeData(node, d) {
  dataProp[node] = d;
}

nodeData(node) {
  if (node is DataNode) {
    return node.data;
  }
  return dataProp[node];
}

bool hasData(node) {
  if (node is DataNode) {
    return node.data != null;
  }
  return dataProp[node] != null;
}
