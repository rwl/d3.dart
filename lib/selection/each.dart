part of selection;

eachGroup(groups, callback) {
  for (var j = 0, m = groups.length; j < m; j++) {
    for (var group = groups[j], i = 0, n = group.length, node; i < n; i++) {
      node = group[i];
      if (node != null) callback(node, i, j);
    }
  }
  return groups;
}