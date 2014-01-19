library selection;

import 'dart:html';
import 'dart:math' as math;

import '../core/core.dart' as core;

part 'append.dart';
part 'attr.dart';
part 'data.dart';
part 'each.dart';
part 'enter.dart';
part 'select.dart';

class Selection extends EnteringSelection {
//  List groups;
  Function enter, exit;

  Selection(List groups) : super(groups) {
  }

  append(name) {
    name = creator(name);
    return this.select((node, data, i, j) {
      return node.append(name(node, data, i, j));
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
      for (value in name) this.each(attrFunc(value, name[value]));
          return this;
    }

    return this.each(attrFunc(name, value));
  }

  data([value = null, key = null]) {
    var i = -1,
        n = this.length,
        group,
        node;

    // If no value is specified, return the first value.
    if (value == null && key == null) {
      group = this[0];
      n = group.length;
      value = new List(n);
      while (++i < n) {
        if (node = group[i]) {
          value[i] = node.attributes["__data__"];
        }
      }
      return value;
    }

    EnteringSelection enter = new EnteringSelection([]);
    Selection update = new Selection([]),
        exit = new Selection([]);

    bind(group, groupData) {
      var i,
      n = group.length,
      m = groupData.length,
      n0 = math.min(n, m),
      updateNodes = new List(m),
      enterNodes = new List(m),
      exitNodes = new List(n),
      node,
      nodeData;

      if (key != null) {
        var nodeByKeyValue = new Map(),
            dataByKeyValue = new Map(),
            keyValues = [],
            keyValue;

        for (i = -1; ++i < n;) {
          keyValue = key.call(node = group[i], node.__data__, i);
          if (nodeByKeyValue.containsKey(keyValue)) {
            exitNodes[i] = node; // duplicate selection key
          } else {
            nodeByKeyValue[keyValue] = node;
          }
          keyValues.add(keyValue);
        }

        for (i = -1; ++i < m;) {
          keyValue = key.call(groupData, nodeData = groupData[i], i);
          if (nodeByKeyValue.containsKey(keyValue)) {
            node = nodeByKeyValue[keyValue];
            updateNodes[i] = node;
            node.__data__ = nodeData;
          } else if (!dataByKeyValue.containsKey(keyValue)) { // no duplicate data key
            enterNodes[i] = new DataNode(nodeData);
          }
          dataByKeyValue[keyValue] = nodeData;
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
          nodeData = groupData[i];
          if (node != null) {
            node.attributes["__data__"] = nodeData;
            updateNodes[i] = node;
          } else {
            enterNodes[i] = new DataNode(nodeData);
          }
        }
        for (; i < m; ++i) {
          enterNodes[i] = new DataNode(groupData[i]);
        }
        for (; i < n; ++i) {
          exitNodes[i] = group[i];
        }
      }

//      enterNodes.update
//      = updateNodes;
//
//      enterNodes.parentNode
//      = updateNodes.parentNode
//      = exitNodes.parentNode
//      = group.parentNode;

      enter.addAll(enterNodes);
      update.addAll(updateNodes);
      exit.addAll(exitNodes);
    }

    if (value is Function) {
      while (++i < n) {
        bind(group = this[i], value.call(group, group.parentNode.__data__, i));
      }
    } else {
      while (++i < n) {
        bind(group = this[i], value);
      }
    }

    update.enter = () { return enter; };
    update.exit = () { return exit; };
    return update;
  }

  each(callback) {
    return eachGroup(this, (node, i, j) {
      callback(node, node.attributes["__data__"], i, j);
    });
  }

  // TODO remove(selector)?
  // TODO remove(node)?
  // TODO remove(function)?
  remove() {
    return this.each((node, data, i, j) {
      node.remove();
//      var parent = node.parentNode;
//      if (parent != null) parent.removeChild(node);
    });
  }

  select(s) {
    List subgroups = [], subgroup;
    var subnode, group, node;

    s = selector(s);

    for (var j = -1, m = this.length; ++j < m;) {
      subgroups.add(subgroup = []);
      group = this[j];
//      subgroup.parent = group.parent;
      for (var i = -1, n = group.length; ++i < n;) {
        node = group[i];
        if (node != null) {
          subgroup.add(subnode = s(node, node.attributes["__data__"], i, j));
          if (subnode is Element && node.attributes.containsKey("__data__")) {
            subnode.attributes["__data__"] = node.attributes["__data__"];
          }
        } else {
          subgroup.add(null);
        }
      }
    }

    return new Selection(subgroups);
  }

}

selectNode(s, n) { return n.querySelector(s); }

select(node) {
  var group = [node is String ? selectNode(node, document) : node];
//  group.parent = document;
  return new Selection([group]);
}