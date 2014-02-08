part of selection;

class EnteringSelection {

  final List<List<Element>> groups;

  EnteringSelection(this.groups);

  int get length => groups.length;

  List<Element> operator [](i) {
    return groups[i];
  }

  add(nodes) {
    this.groups.add(nodes);
  }

  append(name) {
    name = creator(name);
    return this.selectFunc((node, data, i, j) {
      return node.append(name(node, data, i, j));
    });
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

  selectFunc(final selectFunction selector) {
    final subgroups = new List<List<Element>>();

    for (int j = -1, m = this.length; ++j < m;) {
      final group = this[j];
      final upgroup = updateGroup(group);
      final subgroup = new List<Element>();
      subgroups.add(subgroup);
      parentNode(subgroup, parentNode(group));
      for (int i = -1, n = group.length; ++i < n;) {
        final node = group[i];
        if (node != null) {
          final subnode = selector(parentNode(group), nodeData(node), i, j);
          upgroup[i] = subnode;
          subgroup.add(subnode);
          nodeData(subnode, nodeData(node));
        } else {
          subgroup.add(null);
        }
      }
    }

    return new Selection(subgroups);
  }

}