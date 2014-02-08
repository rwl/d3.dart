part of selection;

final parentProp = new Expando<Node>('parentNode');

parentNode(List<Element> group, [Node node = null]) {
  if (node == null) {
    return parentProp[group];
  }
  parentProp[group] = node;
}

final updateProp = new Expando<List>('update');

List<Element> updateGroup(List<Element> group, [List<Element> upgroup = null]) {
  if (upgroup == null) {
    return updateProp[group];
  }
  updateProp[group] = upgroup;
}

nodeData(node, [d = null]) {
  if (d == null) {
    if (node is DataNode) {
      return node.data;
    }
    return dataProp[node];
  }
  dataProp[node] = d;
}

bool hasData(node) {
  if (node is DataNode) {
    return node.data != null;
  }
  return dataProp[node] != null;
}

final dataProp = new Expando<Object>('data');
