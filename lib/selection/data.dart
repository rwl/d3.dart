part of selection;

class DataNode {
  var data;
  DataNode(this.data);
}

bind(final List<Element> group, final List groupData, final dataKeyFunction key,
     final EnteringSelection enter, final Selection update, final Selection exit) {
  var i,
  n = group.length,
  m = groupData.length,
  n0 = math.min(n, m),
  updateNodes = new List(m),
  enterNodes = new List(m),
  exitNodes = new List(n),
  node,
  nodedata;

  if (key != null) {
    var nodeByKeyValue = new Map(),
        dataByKeyValue = new Map(),
        keyValues = [],
        keyValue;

    for (i = -1; ++i < n;) {
      keyValue = key.call(node = group[i], nodeData(node), i);
      if (nodeByKeyValue.containsKey(keyValue)) {
        exitNodes[i] = node; // duplicate selection key
      } else {
        nodeByKeyValue[keyValue] = node;
      }
      keyValues.add(keyValue);
    }

    for (i = -1; ++i < m;) {
      keyValue = key.call(groupData, nodedata = groupData[i], i);
      if (nodeByKeyValue.containsKey(keyValue)) {
        node = nodeByKeyValue[keyValue];
        updateNodes[i] = node;
        nodeData(node, nodedata);
      } else if (!dataByKeyValue.containsKey(keyValue)) { // no duplicate data key
        enterNodes[i] = new DataNode(nodedata);
      }
      dataByKeyValue[keyValue] = nodedata;
      nodeByKeyValue.remove(keyValue);
    }

    for (i = -1; ++i < n;) {
      if (nodeByKeyValue.containsKey(keyValues[i])) {
        exitNodes[i] = group[i];
      }
    }
  } else {
    for (i = -1; ++i < n0;) {
      node = group[i];
      nodedata = groupData[i];
      if (node != null) {
        nodeData(node, nodedata);
        updateNodes[i] = node;
      } else {
        enterNodes[i] = new DataNode(nodedata);
      }
    }
    for (; i < m; ++i) {
      enterNodes[i] = new DataNode(groupData[i]);
    }
    for (; i < n; ++i) {
      exitNodes[i] = group[i];
    }
  }

  updateGroup(enterNodes, updateNodes);

  var parent = parentNode(group);
  parentNode(enterNodes, parent);
  parentNode(updateNodes, parent);
  parentNode(exitNodes, parent);

  enter.add(enterNodes);
  update.add(updateNodes);
  exit.add(exitNodes);
}
