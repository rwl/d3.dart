part of selection;

class EnteringSelection {
  List<List> groups;
  EnteringSelection(this.groups);

  get length => groups.length;

  operator [](i) {
    return groups[i];
  }

  addAll(nodes) {
    this.groups.addAll(nodes);
  }

  node() {
    for (var j = 0, m = this.length; j < m; j++) {
      for (var group = this[j], i = 0, n = group.length; i < n; i++) {
        var node = group[i];
        if (node != null) return node;
      }
    }
    return null;
  }

}