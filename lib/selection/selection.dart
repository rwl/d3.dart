library selection;

import 'dart:html';
import 'dart:math' as math;

import '../core/core.dart' as core;
import '../utils.dart' as utils;

part 'append.dart';
part 'data.dart';
part 'each.dart';
part 'enter.dart';
part 'style.dart';
part 'expando.dart';

const String unique = '8fc4ac4743d2195d2b44bbbcff2ac2c73f82c71d';

typedef Element selectFunction(Element node, Object data, int i, int j);
typedef List<Element> selectAllFunction(Element node, Object data, int i, int j);

typedef List dataFunction(List<Element> group, Object data, int i);
typedef String dataKeyFunction(var thiz, int i);

typedef EnteringSelection enterFunction();
typedef Selection exitFunction();

typedef Object attrFunction(Element node, Object data, int i, int j);

typedef eachFunction(Element node, Object data, int i, int j);

class Selection extends EnteringSelection {

  enterFunction enter = () => null;
  exitFunction exit = () => null;

  Selection(final List<List<Element>> groups) : super(groups);

  factory Selection.fromSelector(final String s) {
    final group = [document.querySelector(s)];
    parentNode(group, document);
    return new Selection([group]);
  }

  factory Selection.ofNode(final Element node) {
    final group = [node];
    parentNode(group, document);
    return new Selection([group]);
  }

  factory Selection.fromSelectorAll(final String s) {
    final group = document.querySelectorAll(s);
    parentNode(group, document);
    return new Selection([group]);
  }

  factory Selection.ofNodes(final List<Element> nodes) {
    final group = nodes;
    parentNode(group, document);
    return new Selection([group]);
  }

  /**
   * Returns the value of the specified attribute for the first non-null
   * element in the selection.
   */
  String nodeAttr(final String name) {
    // For attr(string), return the attribute value for the first node.
    final node = this.node();
    final qualified = core.qualify(name);
    final val = (qualified.space != null)
        ? node.getAttributeNS(qualified.space, qualified.local)
            : node.getAttribute(qualified.local);
    return val == '' ? null : val;
  }

  /**
   * The map specifies the names and values of the attributes to set
   * or remove. The values may be functions that are evaluated for
   * each element.
   */
  attrMap(final Map<String, Object> attrs) {
    attrs.forEach((final String name, final Object value) {
      if (value == null) {
        attrNull(name);
      } else if (value is attrFunction) {
        attrFunc(name, value);
      } else {
        attr(name, value);
      }
    });
  }

  /**
   * Sets the attribute with the specified name to the specified value
   * on all selected elements.
   */
  attr(final String name, final Object value) {
    if (value == null) {
      attrNull(name);
    }
    final qualified = core.qualify(name);
    if (qualified.space != null) {
      each((node, d, i, j) {
        node.setAttributeNS(qualified.space, qualified.local, value.toString());
      });
    } else {
      each((final Element node, d, i, j) {
        node.setAttribute(name, value.toString());
      });
    }
  }

  /**
   * Removes the specified attribute from all elements in the current
   * selection.
   */
  attrNull(final String name) {
    final qualified = core.qualify(name);
    if (qualified.space != null) {
      each((node, d, i, j) {
        node.getNamespacedAttributes(qualified.space).remove(qualified.local);
      });
    } else {
      each((final Element node, d, i, j) {
        node.attributes.remove(name);
      });
    }
  }

  /**
   * The specified function is evaluated for each selected element (in order),
   * being passed the current datum and the current index, with the current
   * DOM element. The function's return value is then used to set each
   * element's attribute. A null value will remove the specified attribute.
   */
  attrFunc(final String name, final attrFunction fn) {
    final qualified = core.qualify(name);
    if (qualified.space != null) {
      each((node, data, i, j) {
        final x = fn(node, data, i, j);
        if (x == null) {
          node.getNamespacedAttributes(qualified.space).remove(qualified.local);
        } else {
          node.setAttributeNS(qualified.space, qualified.local, x);
        }
      });
    } else {
      each((node, data, i, j) {
        var x = fn(node, data, i, j);
        if (x == null) {
          node.attributes.remove(name);
        } else {
          node.setAttribute(name, x);
        }
      });
    }
  }

  /**
   * Returns the array of data for the first group in the selection.
   */
  List get groupData {
    final group = this[0];
    final n = group.length;
    final value = new List(n);
    int i = -1;
    while (++i < n) {
      final node = group[i];
      if (node != null) {
        value[i] = nodeData(node);
      }
    }
    return value;
  }

  /**
   * Joins the specified array of data with the current selection.
   */
  Selection data(List value, [dataKeyFunction key = null]) {
    return dataFunc((group, data, i) {
      return value;
    }, key);
  }

  /**
   * Specifies the data for each group in the selection using a function
   * that returns an array.
   */
  Selection dataFunc(final dataFunction fn, [dataKeyFunction key=null]) {
    final enter = new EnteringSelection([]);
    final update = new Selection([]);
    final exit = new Selection([]);

    final n = this.length;
    int i = -1;

    while (++i < n) {
      final group = this[i];
      final values = fn(group, nodeData(parentNode(group)), i);
      bind(group, values, key, enter, update, exit);
    }

    update.enter = () { return enter; };
    update.exit = () { return exit; };
    return update;
  }

  each(eachFunction callback) {
    return eachGroup(this, (node, i, j) {
//      utils.FnWith4Args fnWith4Args = utils.relaxFn4Args(callback);
      callback(node, nodeData(node), i, j);
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

  remove() {
    return this.each((node, data, i, j) {
      node.remove();
//      var parent = parentNode(node);
//      if (parent != null) parent.removeChild(node);
    });
  }

  Selection select(final String selector) {
    return selectFunc((final Element node, _d, _i, _j) {
      return node.querySelector(selector);
    });
  }

  Selection selectFunc(final selectFunction selector) {
    final subgroups = new List<List<Element>>();

    for (var j = -1, m = this.length; ++j < m;) {
      final subgroup = new List<Element>();
      subgroups.add(subgroup);
      final group = this[j];
      parentNode(subgroup, parentNode(group));
      for (var i = -1, n = group.length; ++i < n;) {
        final Element node = group[i];
        if (node != null) {
          final subnode = selector(node, nodeData(node), i, j);
          subgroup.add(subnode);
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

  Selection selectAll(final String selector) {
    return selectAllFunc((final Element node, _d, _i, _j) {
      return node.querySelectorAll(selector);
    });
  }

  Selection selectAllFunc(final selectAllFunction selector) {
    final subgroups = new List<List<Element>>();

    for (int j = -1, m = this.length; ++j < m;) {
      final group = this[j];
      for (int i = -1, n = group.length; ++i < n;) {
        final Element node = group[i];
        if (node != null) {
          final List<Element> subgroup = selector(node, nodeData(node), i, j);
          subgroups.add(subgroup);
          parentNode(subgroup, node);
        }
      }
    }

    return new Selection(subgroups);
  }

  int size() {
    int n = 0;
    this.each((e, d, i, j) { ++n; });
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
