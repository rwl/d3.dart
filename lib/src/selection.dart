library d3.src.selection;

import 'dart:js';
import 'dart:html';

JsObject _d3 = context['d3'];

/// D3 uses semantic versioning.
String get version {
  return _d3.callMethod('version', []);
}

/// Select an element from the current document.
Selection select(selector) {
  return _d3.callMethod('select', []);
}

/// Select multiple elements from the current document.
Selection selectAll(selector) {
  return _d3.callMethod('selectAll', []);
}

/// Access the current user event for interaction.
Event get event {
  return _d3['event'];
}

/// Gets the mouse position relative to a specified container.
List mouse(container) {
  return _d3.callMethod('mouse', []);
}

/// Gets a touch position relative to a specified container.
List touch(container, [touches, identifier]) {
  return _d3.callMethod('touch', []);
}

/// Gets the touch positions relative to a specified container.
List touches(container, [touches]) {
  return _d3.callMethod('touches', []);
}

/// A selection is an array of elements pulled from the current document.
class Selection {
  final JsObject _proxy;

  Selection._(this._proxy);

  /// Get or set attribute values.
  Selection attr(name, [value]) {
    return _proxy.callMethod('attr', []);
  }

  /// Add or remove CSS classes.
  Selection classed(name, [value]) {
    return _proxy.callMethod('classed', []);
  }

  /// Get or set style properties.
  Selection style(name, [value, priority]) {
    return _proxy.callMethod('style', []);
  }

  /// Get or set raw properties.
  Selection property(name, [value]) {
    return _proxy.callMethod('property', []);
  }

  /// Get or set text content.
  Selection text([value]) {
    return _proxy.callMethod('text', []);
  }

  /// Get or set inner HTML content.
  Selection html([value]) {
    return _proxy.callMethod('html', []);
  }

  /// Create and append new elements.
  Selection append(String name) {
    return _proxy.callMethod('append', []);
  }

  /// Create and insert new elements before existing elements.
  Selection insert(name, [before]) {
    return _proxy.callMethod('insert', []);
  }

  /// Remove elements from the document.
  Selection remove() {
    return _proxy.callMethod('remove', []);
  }

  /// Get or set data for a group of elements, while computing a
  /// relational join.
  Selection data([values, key]) {
    return _proxy.callMethod('data', []);
  }

  /// Returns placeholders for missing elements.
  Selection enter() {
    return _proxy.callMethod('enter', []);
  }

  /// Returns elements that are no longer needed.
  Selection exit() {
    return _proxy.callMethod('exit', []);
  }

  /// Filter a selection based on data.
  Selection filter(selector) {
    return _proxy.callMethod('filter', []);
  }

  /// Get or set data for individual elements, without computing a join.
  Selection datum([value]) {
    return _proxy.callMethod('datum', []);
  }

  /// Sort elements in the document based on data.
  Selection sort([comparator]) {
    return _proxy.callMethod('sort', []);
  }

  /// Reorders elements in the document to match the selection.
  Selection order() {
    return _proxy.callMethod('order', []);
  }

  /// Add or remove event listeners for interaction.
  Selection on(type, [listener, capture]) {
    return _proxy.callMethod('on', []);
  }

  /// Start a transition on the selected elements.
  Selection transition([name]) {
    return _proxy.callMethod('transition', []);
  }

  /// Immediately interrupt the current transition, if any.
  Selection interrupt([name]) {
    return _proxy.callMethod('interrupt', []);
  }

  /// Subselect a descendant element for each selected element.
  Selection select(selector) {
    return _proxy.callMethod('select', []);
  }

  /// Subselect multiple descendants for each selected element.
  Selection selectAll(selector) {
    return _proxy.callMethod('selectAll', []);
  }

  /// Call a function for each selected element.
  Selection each(function) {
    return _proxy.callMethod('each', []);
  }

  /// Call a function passing in the current selection.
  Selection call(function, [arguments]) {
    return _proxy.callMethod('call', []);
  }

  /// Returns true if the selection is empty.
  bool empty() {
    return _proxy.callMethod('empty', []);
  }

  /// Returns the first node in the selection.
  Node node() {
    return _proxy.callMethod('node', []);
  }

  /// Returns the number of elements in the selection.
  int size() {
    return _proxy.callMethod('size', []);
  }
}
