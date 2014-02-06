part of selection;

class EnteringSelection {
  List<List<Element>> groups;
  EnteringSelection(this.groups);

  get length => groups.length;

  operator [](i) {
    return groups[i];
  }

  add(nodes) {
    this.groups.add(nodes);
  }

  append(name) {
    name = creator(name);
    return this.select((node, data, i, j) {
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

  select(s) {
    var subgroups = [],
        subgroup,
        subnode,
        upgroup,
        group,
        node;

    for (var j = -1, m = this.length; ++j < m;) {
      group = this[j];
      upgroup = updateGroup(group);
      subgroups.add(subgroup = []);
      parentNode(subgroup, parentNode(group));
      for (var i = -1, n = group.length; ++i < n;) {
        node = group[i];
        if (node != null) {
          upgroup[i] = subnode = s(parentNode(group), nodeData(node), i, j);
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