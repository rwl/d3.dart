library selection;

import 'dart:html';

import '../core/core.dart' as core;

Selection _selection(groups) {
//  d3_subclass(groups, d3_selectionPrototype);
  return new Selection(groups);
}

_select(s, n) { return n.querySelector(s); }

class Selection {
  var groups;

  Selection(this.groups);

  get length => groups.length;

  operator [](i) {
    return groups[i];
  }

  append(name) {
    name = _creator(name);
    return this.select((node, data, i, j) {
      return node.appendChild(name(node, data, i, j));
    });
  }

  attr(name, [value = null]) {
    if (value == null) {

      // For attr(string), return the attribute value for the first node.
      if (name is String) {
        var node = this.node();
        name = core.qualify(name);
        return (name is core.Name)
            ? node.getAttributeNS(name.space, name.local)
                : node.getAttribute(name);
      }

      // For attr(object), the object specifies the names and values of the
      // attributes to set or remove. The values may be functions that are
      // evaluated for each element.
      for (value in name) this.each(d3_selection_attr(value, name[value]));
          return this;
    }

    return this.each(d3_selection_attr(name, value));
  }

  node() {
    for (var j = 0, m = this.length; j < m; j++) {
      for (var group = this[j], i = 0, n = group.length; i < n; i++) {
        var node = group[i];
        if (node) return node;
      }
    }
    return null;
  }

  select(selector) {
    List subgroups = [], subgroup;
    var subnode, group, node;

    selector = _selector(selector);

    for (var j = -1, m = this.length; ++j < m;) {
      subgroups.add(subgroup = []);
//      subgroup.parent = (group = this[j]).parent;
      for (var i = -1, n = group.length; ++i < n;) {
        if (node = group[i]) {
          subgroup.add(subnode = selector(node, node.__data__, i, j));
          if (subnode is Element && node.attributes.containsKey("__data__")) {
            subnode.attributes["__data__"] = node.attributes["__data__"];
          }
        } else {
          subgroup.add(null);
        }
      }
    }

    return _selection(subgroups);
  }

}

select(node) {
  var group = [node is String ? _select(node, document) : node];
//  group.parent = document;
  return _selection([group]);
}


_creator(name) {
  if (name is Function) {
    return name;
  } else {
    name = core.qualify(name);
    if (name is core.Name) {
      return (node, data, i, j) { return node.ownerDocument.createElementNS(name.space, name.local); };
    }
    return (node, data, i, j) { return node.ownerDocument.createElementNS(node.namespaceURI, name); };
  }
}

_selector(selector) {
  if (selector is Function) {
    return selector;
  }
  return (node, data, i, j) {
    return _select(selector, node);
  };
}
