library selection;

import 'dart:html';
import 'dart:math' as math;

import '../core/core.dart' as core;

part 'data.dart';
part 'each.dart';
part 'enter.dart';
part 'expando.dart';

typedef Element selectFunction(Element node, Object data, int i, int j);
typedef List<Element> selectAllFunction(Element node, Object data, int i, int j);

typedef List dataFunction(List<Element> group, Object data, int i);
typedef String dataKeyFunction(var thiz, var data, int i);

typedef EnteringSelection enterFunction();
typedef Selection exitFunction();

typedef Object objectFunction(Element node, Object data, int i, int j);

typedef eachFunction(Element node, Object data, int i, int j);

class Selection extends EnteringSelection {

  enterFunction enter = () => null;
  exitFunction exit = () => null;

  Selection(final List<List<Element>> groups) : super(groups);

  /**
   * Selects the first element that matches the specified selector string,
   * returning a single-element selection. If no elements in the current
   * document match the specified selector, returns the empty selection.
   * If multiple elements match the selector, only the first matching
   * element (in document traversal order) will be selected.
   */
  factory Selection.selector(final String s) {
    final group = [document.querySelector(s)];
    setParentNode(group, document);
    return new Selection([group]);
  }

  /**
   * Selects the specified node. This is useful if you already have a
   * reference to a node, such as within an event listener, or a global
   * such as document.body.
   */
  factory Selection.node(final Element node) {
    final group = [node];
    setParentNode(group, document);
    return new Selection([group]);
  }

  /**
   * Selects all elements that match the specified selector. The elements
   * will be selected in document traversal order (top-to-bottom). If no
   * elements in the current document match the specified selector, returns
   * the empty selection.
   */
  factory Selection.selectorAll(final String s) {
    final group = document.querySelectorAll(s);
    setParentNode(group, document);
    return new Selection([group]);
  }

  /**
   * Selects the specified array of elements. This is useful if you already
   * have a reference to nodes, such as within an event listener, or a global
   * such as document.links.
   */
  factory Selection.nodes(final List<Element> nodes) {
    final group = nodes;
    setParentNode(group, document);
    return new Selection([group]);
  }

  /**
   * Returns the value of the specified attribute for the first non-null
   * element in the selection.
   */
  String nodeAttr(final String name) {
    // For attr(string), return the attribute value for the first node.
    final node = this.node;
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
      } else if (value is objectFunction) {
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
      return;
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
  attrFunc(final String name, final objectFunction fn) {
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
          node.setAttribute(name, x.toString());
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
    return eachNode(this, (node, i, j) {
//      utils.FnWith4Args fnWith4Args = utils.relaxFn4Args(callback);
      callback(node, nodeData(node), i, j);
    });
  }

  bool empty() {
    return this.node == null;
  }

  /**
   * Returns the inner HTML content for the first non-null element in the
   * selection.
   */
  String get nodeHtml {
    return this.node.innerHtml;
  }

  /**
   * The specified function is evaluated for each selected element (in order),
   * being passed the current datum, the current index and the current DOM
   * element. The function's return value is then used to set each element's
   * inner HTML content. A null value will clear the content.
   */
  htmlFunc(final objectFunction fn) {
    each((node, data, i, j) {
      var v = fn(node, data, i, j);
      node.innerHtml = (v == null ? "" : v.toString());
    });
  }

  /**
   * Clears the inner HTML content of all selected elements.
   */
  htmlNull() {
    each((node, data, i, j) {
      node.innerHtml = "";
    });
  }

  /**
   * Sets the inner HTML content to the specified value on all selected
   * elements.
   */
  html(final Object value) {
    if (value == null) {
      htmlNull();
      return;
    }
    each((node, data, i, j) {
      node.innerHtml = value.toString();
    });
  }

  remove() {
    return this.each((node, data, i, j) {
      node.remove();
    });
  }

  Selection select(final String selector) {
    return selectFunc((final Element node, d, i, j) {
      return node.querySelector(selector);
    });
  }

  Selection selectFunc(final selectFunction selector) {
    final subgroups = new List<List<Element>>();

    for (var j = -1, m = this.length; ++j < m;) {
      final subgroup = new List<Element>();
      subgroups.add(subgroup);
      final group = this[j];
      setParentNode(subgroup, parentNode(group));
      for (var i = -1, n = group.length; ++i < n;) {
        final Element node = group[i];
        if (node != null) {
          final subnode = selector(node, nodeData(node), i, j);
          subgroup.add(subnode);
          if (subnode is Element && hasData(node)) {
            setNodeData(subnode, nodeData(node));
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
          setParentNode(subgroup, node);
        }
      }
    }

    return new Selection(subgroups);
  }

  int get size {
    int n = 0;
    this.each((e, d, i, j) { ++n; });
    return n;
  }

  /**
   * Returns the computed style value for the first node.
   */
  String nodeStyle(final String name) {
    return node.getComputedStyle().getPropertyValue(name);
  }

  /**
   * The map specifies the names and values of the attributes to set or
   * remove. The values may be functions that are evaluated for each
   * element. The optional string specifies the priority.
   */
  styleMap(final Map<String, Object> map, [String priority=""]) {
    map.forEach((final String name, final Object value) {
      if (value == null) {
        styleNull(name);
      } else if (value is objectFunction) {
        styleFunc(name, value, priority);
      } else {
        style(name, value, priority);
      }
    });
  }

  /**
   * Remove the style property with the specified name.
   */
  styleNull(final String name) {
    each((node, d, i, j) {
      node.style.removeProperty(name);
    });
  }

  /**
   * Sets the style property with the specified name, using the specified
   * priority.
   */
  style(final String name, final Object value, [String priority=""]) {
    if (value == null) {
      styleNull(name);
      return;
    }
    each((node, d, i, j) {
      node.style.setProperty(name, value.toString(), priority);
    });
  }

  /**
   * The specified function is evaluated for each element, and the style
   * property set or removed as appropriate. When setting, the specified
   * priority is used.
   */
  styleFunc(final String name, final objectFunction fn, [String priority=""]) {
    each((node, d, i, j) {
      final x = fn(node, d, i, j);
      if (x == null) {
        node.style.removeProperty(name);
      } else {
        node.style.setProperty(name, x.toString(), priority);
      }
    });
  }

  /**
   * Returns the text content for the first non-null element in the selection.
   */
  String get nodeText {
    return this.node.text;
  }

  /**
   * The specified function is evaluated for each selected element (in order),
   * being passed the current datum, the current index and the current DOM
   * element. The function's return value is then used to set each element's
   * text content. A null value will clear the content.
   */
  textFunc(final objectFunction fn) {
    each((node, data, i, j) {
      var v = fn(node, data, i, j);
      node.text = (v == null ? "" : v.toString());
    });
  }

  /**
   * Clears the text content for each element in the current selection.
   */
  textNull() {
    each((node, data, i, j) {
      node.text = "";
    });
  }

  /**
   * Sets the text content to the specified value on all selected elements.
   */
  text(final Object value) {
    if (value == null) {
      textNull();
      return;
    }
    each((node, data, i, j) {
      node.text = value.toString();
    });
  }

}
