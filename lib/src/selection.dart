library d3.src.selection;

//import 'dart:js';
import 'dart:async';
import 'dart:html' show Element, Node;
import 'js/selection.dart' as sel;
import 'transition.dart' as trans;
import 'color.dart' as color;
import 'js/d3.dart';

typedef SelectionFn(data);
typedef SelectionFunc(data, int i);
typedef SelectionFunction(Element elem, data, int i);
typedef Comparator(a, b);

/// Access the current user event for interaction.
dynamic get event => sel.event;

class Selected {
  final Element elem;
  final data;
  final int i;
  Selected(this.elem, this.data, this.i);
}

/// A selection is an array of elements pulled from the current document.
class Selection {
  final sel.Selection js;

  Selection._(this.js);

  /// Select an element from the current document.
  Selection(String selector) : js = sel.select(selector);

  /// Select an element from the current document.
  Selection.node(Node node) : js = sel.select(node);

  /// Select multiple elements from the current document.
  Selection.all(String selector) : js = sel.selectAll(selector);

  /// Subselect multiple descendants for each selected element.
  Selection selectAll(String selector) {
    return new Selection._(js.selectAll(selector));
  }

  /// Call a function for each selected element.
  void each(SelectionFunction function) {
    js.each(function);
  }

  /// Call a function for each selected element.
  void eachFn(SelectionFn function) {
    js.each(function);
  }

  /// Set data for individual elements, without computing a join.
  void set datumFn(SelectionFn value) {
    js.datum(value);
  }

  /// Set data for a group of elements, while computing a
  /// relational join.
  UpdateSelection setData(List values, [SelectionFn key]) {
    sel.Selection retval;
    if (key != null) {
      retval = js.data(values, key);
    } else {
      retval = js.data(values);
    }
    return new UpdateSelection._(retval);
  }

  /// Set data for a group of elements, while computing a
  /// relational join.
  UpdateSelection setDataFn(List values(), [SelectionFn key]) {
    sel.Selection retval;
    if (key != null) {
      retval = js.data(values, key);
    } else {
      retval = js.data(values);
    }
    return new UpdateSelection._(retval);
  }

  /// Create and append new elements.
  Selection append(String name) => new Selection._(js.append(name));

  /// Set style properties.
  Styles<String> get style => new Styles<String>._(this);

  /// Set style properties.
  Styles<SelectionFn> get styleFn => new Styles<SelectionFn>._(this);

  /// Set text content.
  void set text(String value) {
    js.text(value);
  }

  /// Set text content.
  void set textFn(SelectionFn value) {
    js.text(value);
  }

  /// Get or set attribute values.
  Attr<String> get attr => new Attr<String>._(this);

  /// Get or set attribute values.
  Attr<SelectionFn> get attrFn => new Attr<SelectionFn>._(this);

  /// Get or set attribute values.
  Attr<SelectionFunc> get attrFunc => new Attr<SelectionFunc>._(this);

  /// Add or remove CSS classes.
  Classed<String> get classed => new Classed<String>._(this);

  /// Add or remove CSS classes.
  Classed<SelectionFn> get classedFn => new Classed<SelectionFn>._(this);

  /// Call a function passing in the current selection.
  void call(function(selection)) {
    js.call(function);
  }

  /// Filter a selection based on data.
  Selection filterFn(SelectionFn selector) {
    return new Selection._(js.filter(selector));
  }

  /// Subselect a descendant element for each selected element.
  Selection select(String selector) => new Selection._(js.select(selector));

  /// Add or remove event listeners for interaction.
  Stream<Selected> on(String type, {bool capture: false}) {
    var ctrl = new StreamController<Selected>(onCancel: () {
      js.on(type, null);
    }, sync: true);
    js.on(type, (elem, d, i) {
      ctrl.add(new Selected(elem, d, i));
    }, capture);
    return ctrl.stream;
  }

  /// Start a transition on the selected elements.
  trans.Transition transition() {
    return trans.newTransition(js.transition());
  }
}

class UpdateSelection {
  final sel.Selection js;

  UpdateSelection._(this.js);

  /// Returns placeholders for missing elements.
  EnterSelection enter() {
    return new EnterSelection._(js.enter());
  }

  /// Returns elements that are no longer needed.
  Selection exit() {
    return new Selection._(js.exit());
  }

  /// Start a transition on the selected elements.
  trans.Transition transition() {
    return trans.newTransition(js.transition());
  }
}

class EnterSelection {
  final sel.Selection js;

  EnterSelection._(this.js);

  /// Create and append new elements.
  Selection append(String name) => new Selection._(js.append(name));

  /// Create and insert new elements before existing elements.
  Selection insert(String name, [String before]) {
    sel.Selection retval;
    if (before != null) {
      retval = js.insert(name, before);
    } else {
      retval = js.insert(name);
    }
    return new Selection._(retval);
  }
}

class Styles<T> {
  final _selection;
  Styles._(this._selection);

  void operator []=(String name, T value) {
    var arg;
    if (value is Function) {
      var fn = (elem, data, i) {
        if (value is Func0Arg) {
          return (value as Func0Arg)();
        } else if (value is Func1Arg) {
          return (value as Func1Arg)(data);
        } else if (value is Func2Args) {
          return (value as Func2Args)(data, i);
        } else if (value is Func3Args) {
          return (value as Func3Args)(elem, data, i);
        } else {
          throw new ArgumentError.value(value);
        }
      };
      arg = (elem, data, i) {
        var v = fn(elem, data, i);
        if (v is color.Color) {
          v = v.js;
        }
        return v;
      };
    } else if (value is color.Color) {
      arg = (value as color.Color).js;
    } else {
      arg = value;
    }
    _selection.js.style(name, arg);
  }
}

class Attr<T> {
  final _selection;
  Attr._(this._selection);

  void operator []=(String name, T value) {
    _selection.js.attr(name, value);
  }
}

class Classed<T> {
  final _selection;
  Classed._(this._selection);

  void operator []=(String name, T value) {
    _selection.js.classed(name, value);
  }
}

/// For internal use.
Attr newAttr(selection) => new Attr._(selection);

/// For internal use.
Styles newStyles(selection) => new Styles._(selection);
