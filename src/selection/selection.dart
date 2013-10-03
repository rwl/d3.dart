
library selection;

import 'dart:html';

import '../core/array.dart';
import '../core/document.dart';
import '../core/subclass.dart';
import '../core/vendor.dart';

//import '../d4.dart' as d4;

function selection(groups) {
  subclass(groups, Selection);
  return groups;
}


Element select(s, n) {
  return n.query(s);
}

List<Element> selectAll(s, n) {
  return n.queryAll(s);
}

/*var selectMatcher = d4_documentElement[vendorSymbol(d4_documentElement, "matchesSelector")];

function selectMatches(n, s) {
  return selectMatcher.call(n, s);
}*/

class Selection extends ElementList {
  
//  Selection(int size) : super(size) {
//    
//  }

  Selection select(String selector) {
    Element selectorFunc(Element node, String data, int i, int j) {
      return select(selector, this);
    }
    
    return selectFunc(selectorFunc);
  }
  
  Selection selectFunc(Element selector(Element node, String data, int i, int j)) {
    List<String> subgroups;
    
    for (var j = -1, m = this.length; ++j < m;) {
      subgroup = new List();
      subgroups.add(subgroup);
      group = this[j];
      subgroup.parentNode = group.parentNode;
      for (var i = -1, n = group.length; ++i < n;) {
        node = group[i];
        if (node != null) {
          subnode = selectorFunc(node, node.__data__, i, j);
          subgroup.add(subnode);
          if (subnode != null && node.attributes.containsKey("__data__")) {
            subnode.attributes["__data__"] = node.attributes["__data__"];
          }
        } else {
          subgroup.add(null);
        }
      }
    }

    return selection(subgroups);
  }
  
  Selection append(String name) {
    name = selectionCreator(name);
    return this.selectFunction(() {
        super.append(name.apply(this, arguments));
    });
  }

}

/*selectionSelector(selector) {
  return typeof selector === "function" ? selector : function() {
    return select(selector, this);
  };
}*/


//var selectionRoot = d4.select(d4_documentElement);

/*selectionCreator(name) {
  return typeof name === "function" ? name
      : (name = d3.ns.qualify(name)).local ? function() { return d3_document.createElementNS(name.space, name.local); }
      : function() { return d3_document.createElementNS(this.namespaceURI, name); };
}*/
