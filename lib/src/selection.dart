library d3.src.selection;

import 'js/selection.dart' as sel;

/// A selection is an array of elements pulled from the current document.
class Selection {
  final sel.Selection js;

  Selection._(this.js);

  /// Select an element from the current document.
  Selection(String selector) : js = sel.select(selector);

  /// Subselect multiple descendants for each selected element.
  Selection selectAll(String selector) {
    return new Selection._(js.selectAll(selector));
  }

  /// Set data for a group of elements, while computing a
  /// relational join.
  UpdateSelection setData(List values) {
    return new UpdateSelection._(js.data(values));
  }

  /// Get or set attribute values.
  Attr<String> get attr => new Attr<String>._(this);
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
  void append(String name) {
    js.append(name);
  }

  /// Set style properties.
  Styles<String> get style => new Styles<String>._(this);

  /// Set style properties.
  Styles<Function> get styleFn => new Styles<Function>._(this);

  /// Set text content.
  void set textFn(Function value) {
    js.text(value);
  }

  /// Get or set attribute values.
  Attr<String> get attr => new Attr<String>._(this);

  /// Get or set attribute values.
  Attr<Function> get attrFn => new Attr<Function>._(this);
}

class Styles<T> {
  final _selection;
  Styles._(this._selection);

  void operator []=(String name, T value) {
    _selection.js.style(name, value);
  }
}

class Attr<T> {
  final _selection;
  Attr._(this._selection);

  void operator []=(String name, T value) {
    _selection.js.attr(name, value);
  }
}
