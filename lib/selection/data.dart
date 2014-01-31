part of selection;

class DataNode {
  var data;
  DataNode(this.data);
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
