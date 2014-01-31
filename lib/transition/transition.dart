library d3.transition;

import 'dart:math' as math;

import '../core/core.dart' as core;
import '../selection/selection.dart';
import '../utils.dart';
import '../interpolate/interpolate.dart' as libInterpolate;

part 'tween.dart';
part 'transition_node.dart';

final idProp = new Expando<int>('id');

groupId(groups, [id = null]) {
  if (id == null) {
    return idProp[groups];
  }
  idProp[groups] = id;
}

final transitionProp = new Expando<Transition>('transition');

nodeTransition(node, [t = null]) {
  if (t == null) {
    return transitionProp[t];
  }
  transitionProp[node] = t;
}

int transitionId = 0;
bool transitionInheritId;
bool transitionInherit;

class Transition {
  List<List> groups;
  var id;

  Transition(this.groups, this.id) {
    groupId(this.groups, this.id); // Note: read-only!
  }

  get length => groups.length;

  operator [](i) {
    return groups[i];
  }

  attr([nameNS=null, value=null]) {

    if (nameNS==null && value==null) {
      // For attr(object), the object specifies the names and values of the
      // attributes to transition. The values may be functions that are
      // evaluated for each element.
      nameNS.forEach((k, v) {
        this.attr(k, v);
      });
      return this;
    }

    Function interpolate = nameNS == "transform" ? libInterpolate.interpolateTransform : libInterpolate.interpolate;
    var name = core.qualify(nameNS);

    // For attr(string, null), remove the attribute with the specified name.
    attrNull(node) {
      node.removeAttribute(name);
    }
    attrNullNS(node) {
      node.removeAttributeNS(name.space, name.local);
    }

    // For attr(string, string), set the attribute with the specified name.
    attrTween(b) {
      if (b == null) {
        return attrNull;
      } else {
        b += "";
        return (node) {
          var a = node.getAttribute(name), i;
          if (a != b) {
            i = interpolate(a, b);
            return (node, t) { node.setAttribute(name, i(t)); };
          }
        };
      }
    }
    attrTweenNS(b) {
      if (b == null) {
        return attrNullNS;
      } else {
        b += "";
        return (node) {
          var a = node.getAttributeNS(name.space, name.local), i;
          if (a != b) {
            i = interpolate(a, b);
            return (node, t) {
              node.setAttributeNS(name.space, name.local, i(t));
            };
          }
        };
      }
    }

    return transition_tween(this, "attr." + nameNS, value, name.local ? attrTweenNS : attrTween);
  }

  delay(value) {
    var id = this.id;
    if (value is Function) {
      return eachGroup(this, (node, i, j) {
        nodeTransition(node)[id].delay = toDouble(value(node, nodeData(node), i, j));
      });
    } else {
      value = toDouble(value);
      return eachGroup(this, (node) {
        nodeTransition(node)[id].delay = value;
      });
    }
  }

  duration(value) {
    var id = this.id;
    if (value is Function) {
      return eachGroup(this, (node, i, j) {
        nodeTransition(node)[id].duration = math.max(1, value(node, nodeData(node), i, j));
      });
    } else {
      value = math.max(1, value);
      return eachGroup(this, (node) {
        nodeTransition(node)[id].duration = value;
      });
    }
  }

  each([type=null, listener=null]) {
    var id = this.id;
    if (type==null && listener==null) {
      var inherit = transitionInherit,
          inheritId = transitionInheritId;
      transitionInheritId = id;
      eachGroup(this, (node, i, j) {
        transitionInherit = nodeTransition(node)[id];
        type(node, nodeData(node), i, j);
      });
      transitionInherit = inherit;
      transitionInheritId = inheritId;
    } else {
      eachGroup(this, (node) {
        var transition = nodeTransition(node)[id];
        if (transition.event) {
          transition.event = dispatch("start", "end");
          transition.event.on(type, listener);
        }
      });
    }
    return this;
  }

  ease([value=null]) {
    var id = this.id;
    if (value == null) {
      return nodeTransition(this.node())[id].ease;
    }
    if (value is Function) {
      value = libInterpolate.ease(value);
    }
    return eachGroup(this, (node) {
      nodeTransition(node)[id].ease = value;
    });
  }

  bool empty() {
    return this.node() == null;
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

  remove() {
    return this.each("end.transition", () {
      var p = parentNode(this);
      if (nodeTransition(this).count < 2 && p != null) {
        p.removeChild(this);
      }
    });
  }

  Transition select(s) {
    var id = this.id,
        subgroups = [],
        subgroup,
        subnode,
        node;

    s = selector(s);

    for (var j = -1, m = this.length; ++j < m;) {
      subgroups.add(subgroup = []);
      for (var group = this[j], i = -1, n = group.length; ++i < n;) {
        node = group[i];
        if (node != null) {
          subnode = s(node, nodeData(node), i, j);
          if (subnode != null) {
            if (hasData(node)) {
              nodeData(subnode, nodeData(node));
            }
            transitionNode(subnode, i, id, nodeTransition(node)[id]);
            subgroup.add(subnode);
          }
        } else {
          subgroup.add(null);
        }
      }
    }

    return new Transition(subgroups, id);
  }

  Transition selectAll(selector) {
    var id = this.id,
        subgroups = [],
        subgroup,
        subnodes,
        node,
        subnode,
        transition;

    selector = selectorAll(selector);

    for (var j = -1, m = this.length; ++j < m;) {
      for (var group = this[j], i = -1, n = group.length; ++i < n;) {
        node = group[i];
        if (node != null) {
          transition = nodeTransition(node)[id];
          subnodes = selector(node, nodeData(node), i, j);
          subgroups.add(subgroup = []);
          for (var k = -1, o = subnodes.length; ++k < o;) {
            if (subnode = subnodes[k]) {
              transitionNode(subnode, k, id, transition);
            }
            subgroup.add(subnode);
          }
        }
      }
    }

    return new Transition(subgroups, id);
  }

  int size() {
    int n = 0;
    this.each(() { ++n; });
    return n;
  }

  tween([name=null, tween=null]) {
    var id = this.id;
    if (name==null && tween==null) {
      return nodeTransition(this.node())[id].tween.get(name);
    }
    return eachGroup(this, tween == null
        ? (node) { nodeTransition(node)[id].tween.remove(name); }
        : (node) { nodeTransition(node)[id].tween.set(name, tween); });
  }
}