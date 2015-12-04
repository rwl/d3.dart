@JS('d3')
library d3.src.selection;

import 'dart:html';
import 'package:js/js.dart';

/// select an element from the current document.
external Selection select(selector);

/// select multiple elements from the current document.
external Selection selectAll(selector);

/// access the current user event for interaction.
external Event get event;

/// gets the mouse position relative to a specified container.
external List mouse(container);

/// gets a touch position relative to a specified container.
external List touch(container, [touches, identifier]);

/// gets the touch positions relative to a specified container.
external List touches(container, [touches]);

/// A selection is an array of elements pulled from the current document.
@JS()
class Selection {
  /// get or set attribute values.
  external Selection attr(name, [value]);

  /// add or remove CSS classes.
  external Selection classed(name, [value]);

  /// get or set style properties.
  external Selection style(name, [value, priority]);

  /// get or set raw properties.
  external Selection property(name, [value]);

  /// get or set text content.
  external Selection text([value]);

  /// get or set inner HTML content.
  external Selection html([value]);

  /// create and append new elements.
  external Selection append(String name);

  /// create and insert new elements before existing elements.
  external Selection insert(name, [before]);

  /// remove elements from the document.
  external Selection remove();

  /// get or set data for a group of elements, while computing a
  /// relational join.
  external Selection data([values, key]);

  /// returns placeholders for missing elements.
  external Selection enter();

  /// returns elements that are no longer needed.
  external Selection exit();

  /// filter a selection based on data.
  external Selection filter(selector);

  /// get or set data for individual elements, without computing a join.
  external Selection datum([value]);

  /// sort elements in the document based on data.
  external Selection sort([comparator]);

  /// reorders elements in the document to match the selection.
  external Selection order();

  /// add or remove event listeners for interaction.
  external Selection on(type, [listener, capture]);

  /// start a transition on the selected elements.
  external Selection transition([name]);

  /// immediately interrupt the current transition, if any.
  external Selection interrupt([name]);

  /// subselect a descendant element for each selected element.
  external Selection select(selector);

  /// subselect multiple descendants for each selected element.
  external Selection selectAll(selector);

  /// call a function for each selected element.
  external Selection each(function);

  /// call a function passing in the current selection.
  external Selection call(function, [arguments]);

  /// returns true if the selection is empty.
  external bool empty();

  /// returns the first node in the selection.
  external Node node();

  /// returns the number of elements in the selection.
  external int size();
}
