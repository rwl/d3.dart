library d3.src.selection;

import 'dart:js';
import 'dart:html';

import 'd3.dart';
import 'transition.dart' as trans;

JsObject _d3 = context['d3'];

/// D3 uses semantic versioning.
String get version => _d3['version'];

/// Select an element from the current document.
Selection select(selector) {
  return new Selection._(_d3.callMethod('select', [selector]));
}

/// Select multiple elements from the current document.
Selection selectAll(selector) {
  return new Selection._(_d3.callMethod('selectAll', [selector]));
}

/// Access the current user event for interaction.
Event get event => _d3['event'];

/// Gets the mouse position relative to a specified container.
List mouse(Element container) {
  return _d3.callMethod('mouse', [container]);
}

/// Gets a touch position relative to a specified container.
List<List> touch(Element container, identifier, {touches: undefined}) {
  var args = [container];
  if (touches != undefined) {
    args.add(touches);
  }
  args.add(identifier);
  return _d3.callMethod('touch', args);
}

/// Gets the touch positions relative to a specified container.
List touches(Element container, [touches = undefined]) {
  var args = [container];
  if (touches != undefined) {
    args.add(touches);
  }
  return _d3.callMethod('touches', args);
}

/// A selection is an array of elements pulled from the current document.
class Selection {
  final JsObject _proxy;

  Selection._(this._proxy);

  /// Get or set attribute values.
  attr(name, [value = undefined]) {
    if (name is Map) {
      name = new JsObject.jsify(name);
    }
    var args = [name];
    if (value is Function) {
      args.add(func4VarArgs(value));
    } else if (value != undefined) {
      args.add(value);
    }
    var retval = _proxy.callMethod('attr', args);
    if (value == undefined) {
      return retval;
    } else {
      return new Selection._(retval);
    }
  }

  /// Add or remove CSS classes.
  classed(name, [value = undefined]) {
    if (name is Map) {
      name = new JsObject.jsify(name);
    }
    var args = [name];
    if (value is Function) {
      args.add(func4VarArgs(value));
    } else if (value != undefined) {
      args.add(value);
    }
    var retval = _proxy.callMethod('classed', args);
    if (value == undefined) {
      return retval;
    } else {
      return new Selection._(retval);
    }
  }

  /// Get or set style properties.
  style(name, [value = undefined, priority = undefined]) {
    if (name is Map) {
      name = new JsObject.jsify(name);
    }
    var args = [name];
    if (value is Function) {
      args.add(func4VarArgs(value));
    } else if (value != undefined) {
      args.add(value);
    }
    if (priority != undefined) {
      args.add(priority);
    }
    var retval = _proxy.callMethod('style', args);
    if (value == undefined) {
      return retval;
    } else {
      return new Selection._(retval);
    }
  }

  /// Get or set raw properties.
  Selection property(name, [value = undefined]) {
    if (name is Map) {
      name = new JsObject.jsify(name);
    }
    var args = [name];
    if (value is Function) {
      args.add(func4VarArgs(value));
    } else if (value != undefined) {
      args.add(value);
    }
    var retval = _proxy.callMethod('property', args);
    if (value == undefined) {
      return retval;
    } else {
      return new Selection._(retval);
    }
  }

  /// Get or set text content.
  Selection text([value = undefined]) {
    var args = [];
    if (value is Function) {
      args.add(func4VarArgs(value));
    } else if (value != undefined) {
      args.add(value);
    }
    var retval = _proxy.callMethod('text', args);
    if (value == undefined) {
      return retval;
    } else {
      return new Selection._(retval);
    }
  }

  /// Get or set inner HTML content.
  Selection html([value = undefined]) {
    var args = [];
    if (value is Function) {
      args.add(func4VarArgs(value));
    } else if (value != undefined) {
      args.add(value);
    }
    var retval = _proxy.callMethod('html', args);
    if (value == undefined) {
      return retval;
    } else {
      return new Selection._(retval);
    }
  }

  /// Create and append new elements.
  Selection append(name) {
    var args = [];
    if (name is Function) {
      args.add(func4VarArgs(name));
    } else {
      args.add(name);
    }
    var retval = _proxy.callMethod('append', args);
    return new Selection._(retval);
  }

  /// Create and insert new elements before existing elements.
  Selection insert(name, [before = undefined]) {
    var args = [name];
    if (before != undefined) {
      args.add(before);
    }
    var retval = _proxy.callMethod('insert', args);
    return new Selection._(retval);
  }

  /// Remove elements from the document.
  Selection remove() {
    return new Selection._(_proxy.callMethod('remove'));
  }

  /// Get or set data for a group of elements, while computing a
  /// relational join.
  Selection data([values = undefined, key = undefined]) {
    var args = [];
    if (values != undefined) {
      args.add(values);
    }
    if (key is Function) {
      args.add(func2VarArgs(key));
    } else if (key != undefined) {
      args.add(key);
    }
    var retval = _proxy.callMethod('data', args);
    if (values == undefined) {
      return retval;
    } else {
      return new Selection._(retval);
    }
  }

  /// Returns placeholders for missing elements.
  Selection enter() {
    return new Selection._(_proxy.callMethod('enter'));
  }

  /// Returns elements that are no longer needed.
  Selection exit() {
    return new Selection._(_proxy.callMethod('exit'));
  }

  /// Filter a selection based on data.
  Selection filter(selector) {
    var args = [];
    if (selector is Function) {
      args.add(func4VarArgs(selector));
    } else {
      args.add(selector);
    }
    return new Selection._(_proxy.callMethod('filter', args));
  }

  /// Get or set data for individual elements, without computing a join.
  Selection datum([value = undefined]) {
    var args = [];
    if (value is Function) {
      args.add(func4VarArgs(value));
    } else if (value != undefined) {
      args.add(value);
    }
    var retval = _proxy.callMethod('datum', args);
    if (value == undefined) {
      return retval;
    } else {
      return new Selection._(retval);
    }
  }

  /// Sort elements in the document based on data.
  Selection sort([comparator(a, b) = undefinedFn]) {
    var args = [];
    if (comparator != undefinedFn) {
      args.add(comparator);
    }
    var retval = _proxy.callMethod('sort', args);
    return new Selection._(retval);
  }

  /// Reorders elements in the document to match the selection.
  Selection order() {
    return new Selection._(_proxy.callMethod('order'));
  }

  /// Add or remove event listeners for interaction.
  Selection on(String type, [listener = undefined, capture = undefined]) {
    var args = [type];
    if (listener != undefined) {
      args.add(func4VarArgs(listener));
    }
    if (capture != undefined) {
      args.add(capture);
    }
    var retval = _proxy.callMethod('on', args);
    if (listener == undefined) {
      return retval;
    } else {
      return new Selection._(retval);
    }
  }

  /// Start a transition on the selected elements.
  trans.Transition transition([String name = '']) {
    return trans.newTransition(_proxy.callMethod('transition', [name]));
  }

  /// Immediately interrupt the current transition, if any.
  Selection interrupt([String name = '']) {
    return new Selection._(_proxy.callMethod('interrupt', [name]));
  }

  /// Subselect a descendant element for each selected element.
  Selection select(selector) {
    var args = [];
    if (selector is Function) {
      args.add(func4VarArgs(selector));
    } else {
      args.add(selector);
    }
    return new Selection._(_proxy.callMethod('select', args));
  }

  /// Subselect multiple descendants for each selected element.
  Selection selectAll(selector) {
    var args = [];
    if (selector is Function) {
      args.add(func4VarArgs(selector));
    } else {
      args.add(selector);
    }
    return new Selection._(_proxy.callMethod('selectAll', args));
  }

  /// Call a function for each selected element.
  Selection each(Function function) {
    var args = [func4VarArgs(function)];
    return new Selection._(_proxy.callMethod('each', args));
  }

  /// Call a function passing in the current selection.
  Selection call(function,
      [arg1 = undefined,
      arg2 = undefined,
      arg3 = undefined,
      arg4 = undefined,
      arg5 = undefined,
      arg6 = undefined,
      arg7 = undefined]) {
    var args = [
      funcVarArgs(function, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    ];
    return new Selection._(_proxy.callMethod('call', args));
  }

  /// Returns true if the selection is empty.
  bool empty() => _proxy.callMethod('empty');

  /// Returns the first node in the selection.
  Node node() => _proxy.callMethod('node');

  /// Returns the number of elements in the selection.
  int size() => _proxy.callMethod('size');
}

/// For internal use.
JsObject getProxy(arg) => arg._proxy;
