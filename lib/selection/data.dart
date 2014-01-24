part of selection;

class DataNode {
  var __data__;
  DataNode(this.__data__);
}

nodeData(node, [d = null]) {
  if (d == null) {
    return dataProp[node];
  }
  dataProp[node] = d;
}

bool hasData(node) {
  return dataProp[node] != null;
}

final dataProp = new Expando<Object>('d3data');
