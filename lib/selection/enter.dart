part of selection;

typedef appendFunction(Element node, var data, int i, int j);

class EnteringSelection {

  final List<List<Element>> groups;

  EnteringSelection(this.groups);

  int get length => groups.length;

  List<Element> operator [](i) {
    return groups[i];
  }

  add(final List<Element> nodes) {
    this.groups.add(nodes);
  }

  /**
   * Appends a new element with the specified name as the last child of
   * each element in the current selection, returning a new selection
   * containing the appended elements.
   */
  Selection append(final String name) {
    final qualified = core.qualify(name);
    appendFunction fn;
    if (qualified.space != null) {
      fn = (final Element node, _d, _i, _j) {
        return node.ownerDocument.createElementNS(qualified.space, qualified.local);
      };
    } else {
      fn = (final Element node, _d, _i, _j) {
        return node.ownerDocument.createElementNS(node.namespaceUri, qualified.local);
      };
    }
    return this.appendFunc(fn);
  }

  /**
   * The specified function is called for each element in the current
   * selection and returned element is appended as the last child.
   * A new selection containing the appended elements is returned.
   */
  Selection appendFunc(final appendFunction fn) {
    return this.selectFunc((node, data, i, j) {
      return node.append(fn(node, data, i, j));
    });
  }

  /**
   * The first non-null element in the current selection or null if the
   * selection is empty.
   */
  Element get node {
    for (int j = 0, m = this.length; j < m; j++) {
      final group = this[j];
      final n = group.length;
      for (int i = 0; i < n; i++) {
        final node = group[i];
        if (node != null) {
          return node;
        }
      }
    }
    return null;
  }

  Selection selectFunc(final selectFunction selector) {
    final subgroups = new List<List<Element>>();

    for (int j = -1, m = this.length; ++j < m;) {
      final group = this[j];
      final upgroup = getUpdate(group);
      final subgroup = new List<Element>();
      subgroups.add(subgroup);
      setParentNode(subgroup, parentNode(group));
      for (int i = -1, n = group.length; ++i < n;) {
        final node = group[i];
        if (node != null) {
          final subnode = selector(parentNode(group), nodeData(node), i, j);
          upgroup[i] = subnode;
          subgroup.add(subnode);
          setNodeData(subnode, nodeData(node));
        } else {
          subgroup.add(null);
        }
      }
    }

    return new Selection(subgroups);
  }

}