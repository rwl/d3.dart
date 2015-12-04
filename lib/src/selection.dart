@JS('d3')
library d3.src.selection;

import 'dart:html';
import 'package:js/js.dart';

/// D3 uses semantic versioning.
external String get version;

/// Select an element from the current document.
external Selection select(selector);

/// Select multiple elements from the current document.
external Selection selectAll(selector);

/// Access the current user event for interaction.
external Event get event;

/// Gets the mouse position relative to a specified container.
external List mouse(container);

/// Gets a touch position relative to a specified container.
external List touch(container, [touches, identifier]);

/// Gets the touch positions relative to a specified container.
external List touches(container, [touches]);

/// A selection is an array of elements pulled from the current document.
@JS('select')
class Selection {
  Selection(selector);

  /// Get or set attribute values.
  external Selection attr(name, [value]);

  /// Add or remove CSS classes.
  external Selection classed(name, [value]);

  /// Get or set style properties.
  external Selection style(name, [value, priority]);

  /// Get or set raw properties.
  external Selection property(name, [value]);

  /// Get or set text content.
  external Selection text([value]);

  /// Get or set inner HTML content.
  external Selection html([value]);

  /// Create and append new elements.
  external Selection append(String name);

  /// Create and insert new elements before existing elements.
  external Selection insert(name, [before]);

  /// Remove elements from the document.
  external Selection remove();

  /// Get or set data for a group of elements, while computing a
  /// Relational join.
  external Selection data([values, key]);

  /// Returns placeholders for missing elements.
  external Selection enter();

  /// Returns elements that are no longer needed.
  external Selection exit();

  /// Filter a selection based on data.
  external Selection filter(selector);

  /// Get or set data for individual elements, without computing a join.
  external Selection datum([value]);

  /// Sort elements in the document based on data.
  external Selection sort([comparator]);

  /// Reorders elements in the document to match the selection.
  external Selection order();

  /// Add or remove event listeners for interaction.
  external Selection on(type, [listener, capture]);

  /// Start a transition on the selected elements.
  external Selection transition([name]);

  /// Immediately interrupt the current transition, if any.
  external Selection interrupt([name]);

  /// Subselect a descendant element for each selected element.
  external Selection select(selector);

  /// Subselect multiple descendants for each selected element.
  external Selection selectAll(selector);

  /// Call a function for each selected element.
  external Selection each(function);

  /// Call a function passing in the current selection.
  external Selection call(function, [arguments]);

  /// Returns true if the selection is empty.
  external bool empty();

  /// Returns the first node in the selection.
  external Node node();

  /// Returns the number of elements in the selection.
  external int size();
}
