library selection;

import 'dart:html';
import 'dart:math' as math;

import '../core/core.dart' as core;
import '../utils.dart' as utils;

part 'append.dart';
part 'attr.dart';
part 'data.dart';
part 'each.dart';
part 'enter.dart';
part 'select.dart';
part 'style.dart';

const String unique = '8fc4ac4743d2195d2b44bbbcff2ac2c73f82c71d';

final parentProp = new Expando<Node>('parentNode');

parentNode(List group, [Node node = null]) {
  if (node == null) {
    return parentProp[group];
  }
  parentProp[group] = node;
}

final updateProp = new Expando<List>('update');

updateGroup(List group, [List upgroup = null]) {
  if (upgroup == null) {
    return updateProp[group];
  }
  updateProp[group] = upgroup;
}

class Selection extends EnteringSelection {

  Function enter, exit;

  Selection(List groups) : super(groups);

  attr(name, [value = unique]) {
    if (value == unique) {

      // For attr(string), return the attribute value for the first node.
      if (name is String) {
        var node = this.node();
        name = core.qualify(name);
        var val = (name is core.Name)
            ? node.getAttributeNS(name.space, name.local)
                : node.getAttribute(name);
        return val == '' ? null : val;
      }

      // For attr(object), the object specifies the names and values of the
      // attributes to set or remove. The values may be functions that are
      // evaluated for each element.
      //for (value in name) this.each(attrFunc(value, name[value]));
      name.forEach((k, v) { this.each(attrFunc(k, v)); });
      return this;
    }

    return this.each(attrFunc(name, value));
  }

  data([value = unique, key = null]) {
    var i = -1,
        n = this.length,
        group,
        node;

    // If no value is specified, return the first value.
    if (value == unique && key == null) {
      group = this[0];
      n = group.length;
      value = new List(n);
      while (++i < n) {
        node = group[i];
        if (node != null) {
          value[i] = nodeData(node);
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

    if (value is Function) {
      while (++i < n) {
        group = this[i];
        utils.FnWith3Args fnWith3Args = utils.relaxFn3Args(value);
        bind(group, fnWith3Args(group, nodeData(parentNode(group)), i));
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
      utils.FnWith4Args fnWith4Args = utils.relaxFn4Args(callback);
      fnWith4Args(node, nodeData(node), i, j);
    });
  }

  bool empty() {
    return this.node() == null;
  }

  html([value = unique]) {
    if (value != unique) {
      Function fn;
      if (value is Function) {
        fn = (node, data, i, j) {
          utils.FnWith4Args fnWith4Args = utils.relaxFn4Args(value);
          var v = fnWith4Args(node, data, i, j);
          node.innerHtml = (v == null ? "" : v);
        };
      } else if (value == null) {
        fn = (node) { node.innerHtml = ""; };
      } else {
        fn = (node) { node.innerHtml = value.toString(); };
      }
      return this.each(fn);
    } else {
      return this.node().innerHtml;
    }
  }

  // TODO remove(selector)?
  // TODO remove(node)?
  // TODO remove(function)?
  remove() {
    return this.each((node, data, i, j) {
      node.remove();
//      var parent = parentNode(node);
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
      parentNode(subgroup, parentNode(group));
      for (var i = -1, n = group.length; ++i < n;) {
        node = group[i];
        if (node != null) {
          subgroup.add(subnode = s(node, nodeData(node), i, j));
          if (subnode is Element && hasData(node)) {
            nodeData(subnode, nodeData(node));
          }
        } else {
          subgroup.add(null);
        }
      }
    }

    return new Selection(subgroups);
  }

  selectAll(selector) {
    var subgroups = [],
        subgroup,
        node;

    selector = selectorAll(selector);

    for (var j = -1, m = this.length; ++j < m;) {
      for (var group = this[j], i = -1, n = group.length; ++i < n;) {
        node = group[i];
        if (node != null) {
          subgroup = selector(node, nodeData(node), i, j);
          subgroups.add(subgroup);
          parentNode(subgroup, node);
        }
      }
    }

    return new Selection(subgroups);
  }

  int size() {
    int n = 0;
    this.each(() { ++n; });
    return n;
  }

  style(name, [value = unique, priority = null]) {
    if (priority == null) {

      // For style(object) or style(object, string), the object specifies the
      // names and values of the attributes to set or remove. The values may be
      // functions that are evaluated for each element. The optional string
      // specifies the priority.
      if (!(name is String)) {
        if (value == null) value = "";
        name.forEach((k, v) {
          this.each(styleNode(k, v, value));
        });
        return this;
      }

      // For style(string), return the computed style value for the first node.
      if (value == unique) {
        return this.node().getComputedStyle().getPropertyValue(name);
      }

      // For style(string, string) or style(string, function), use the default
      // priority. The priority is ignored for style(string, null).
      priority = "";
    }

    // Otherwise, a name, value and priority are specified, and handled as below.
    return this.each(styleNode(name, value, priority));
  }

  text([value = unique]) {
    if (value != unique) {
      Function fn;
      if (value is Function) {
        fn = (node, data, i, j) {
          utils.FnWith4Args fnWith4Args = utils.relaxFn4Args(value);
          var v = fnWith4Args(node, data, i, j);
          node.text = (v == null ? "" : v.toString());
        };
      } else if (value == null) {
        fn = (node) { node.text = ""; };
      } else {
        fn = (node) { node.text = value.toString(); };
      }
      return each(fn);
    } else {
      return this.node().text;
    }
  }

}

selectNode(s, n) { return n.querySelector(s); }

selectNodeAll(s, n) { return n.querySelectorAll(s); }

select(node) {
  var group = [node is String ? selectNode(node, document) : node];
  parentNode(group, document);
  return new Selection([group]);
}

selectAll(nodes) {
  var group = [nodes is String ? selectNodeAll(nodes, document) : nodes];
  parentNode(group, document);
  return new Selection([group]);
}
