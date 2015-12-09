library d3.src.selection;

import 'dart:async';
import 'dart:html';
import 'js/selection.dart' as sel;
import 'transition.dart' as trans;

typedef SelectionFn(data);
typedef SelectionFunc(data, int i);
typedef SelectionFunction(Element elem, data, int i);

class Selected {
  final Element elem;
  final data;
  final int i;
  Selected(this.elem, this.data, this.i);
}

abstract class AbstractSelection {
  dynamic get js;
}

/// A selection is an array of elements pulled from the current document.
class Selection implements AbstractSelection {
  final sel.Selection js;

  Selection._(this.js);

  /// Select an element from the current document.
  Selection(String selector) : js = sel.select(selector);

  /// Select multiple elements from the current document.
  Selection.all(String selector) : js = sel.selectAll(selector);

  /// Subselect multiple descendants for each selected element.
  Selection selectAll(String selector) {
    return new Selection._(js.selectAll(selector));
  }

  /// Set data for a group of elements, while computing a
  /// relational join.
  UpdateSelection setData(List values) {
    return new UpdateSelection._(js.data(values));
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

  /// Call a function passing in the current selection.
  void call(function(AbstractSelection s)) {
    js.call(function);
  }

  /// Subselect a descendant element for each selected element.
  Selection select(String selector) => new Selection._(js.select(selector));

  /// Add or remove event listeners for interaction.
  Stream<Selected> on(String type, {bool capture: false}) {
    var ctrl = new StreamController<Selected>(onCancel: () {
      js.on(type, null);
    });
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
}

class EnterSelection {
  final sel.Selection js;

  EnterSelection._(this.js);

  /// Create and append new elements.
  Selection append(String name) => new Selection._(js.append(name));
}

class Styles<T> {
  final Selection _selection;
  Styles._(this._selection);

  void operator []=(String name, T value) {
    _selection.js.style(name, value);
  }
}

class Attr<T> {
  final Selection _selection;
  Attr._(this._selection);

  void operator []=(String name, T value) {
    _selection.js.attr(name, value);
  }
}
