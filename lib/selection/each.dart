part of selection;

eachNode(groups, callback) {
  for (var j = 0, m = groups.length; j < m; j++) {
    var group = groups[j];
    for (var i = 0, n = group.length, node; i < n; i++) {
      node = group[i];
      if (node != null) callback(node, i, j);
    }
  }
  return groups;
}