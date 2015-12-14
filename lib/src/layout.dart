library d3.src.layout;

import 'dart:js';
import 'dart:async';
import 'js/layout.dart' as layout;
import 'd3.dart';

/// Construct a new default bundle layout.
class Bundle {
  final layout.Bundle js;

  Bundle() : js = layout.bundle();

  /// Apply Holten's hierarchical bundling algorithm to edges.
  call(links) => js.call(links);
}

/// Cluster entities into a dendrogram.
class Cluster {
  final layout.Cluster js;

  Cluster() : js = layout.cluster();

  /// Alias for cluster.nodes.
  List call(dynamic root) => js.call(root);

  /// Compute the cluster layout and return the array of nodes.
  List nodes(root) => js.nodes(root);

  /// Compute the parent-child links between tree nodes.
  List links(nodes) => js.links(nodes);

  /// Set the layout size in x and y.
  void set size(List size) {
    js.size(size);
  }

  /// Set the comparator function for sibling nodes.
  void set sort(Function comparator) {
    js.sort(comparator);
  }

  /// Specify a fixed size for each node.
  void set value(Function value) {
    js.value(value);
  }
}

/// Position linked nodes using physical simulation.
class Force {
  final layout.Force js;

  Force() : js = layout.force();

  /// Set the charge strength.
  void set charge(num charge) {
    js.charge(charge);
  }

  /// Set the link distance.
  void set linkDistance(num distance) {
    js.linkDistance(distance);
  }

  /// Set the layout size in x and y.
  void set size(List size) {
    js.size(size);
  }

  /// Set the array of nodes to layout.
  void set nodes(List nodes) {
    js.nodes(nodes);
  }

  /// Get or set the array of links between nodes.
  void set links(List links) {
    js.links(links);
  }

  /// Start or restart the simulation when the nodes change.
  void start() {
    js.start();
  }

  /// Bind a behavior to nodes to allow interactive dragging.
  void drag() {
    js.drag();
  }

  Stream<JsMap> get onTick {
    var ctrl = new StreamController(onCancel: () {
      js.on('tick', null);
    });
    js.on('tick', (event) {
      ctrl.add(new JsMap(event));
    });
    return ctrl.stream;
  }
}

/// Position a tree of nodes tidily.
class Tree {
  final layout.Tree js;

  Tree() : js = layout.tree();

  /// Specify the layout size in x and y.
  void set size(List size) {
    js.size(size);
  }

  /// Compute the tree layout and return the array of nodes.
  JsObject nodes(JsObject root) => js.nodes(root);

  /// Compute the parent-child links between tree nodes.
  JsObject links(JsObject nodes) => js.links(nodes);
}

/// Produce a chord diagram from a matrix of relationships.
class ChordLayout {
  final layout.Chord js;

  ChordLayout() : js = layout.chord();

  /// Get or set the matrix data backing the layout.
  void set matrix(List<List> matrix) {
    js.matrix(matrix);
  }

  /// Set the angular padding between chord segments.
  void set padding(num padding) {
    js.padding(padding);
  }

  /// Set the comparator function for groups.
  void set sortGroups(Comparator comparator) {
    js.sortGroups(comparator);
  }

  /// Set the comparator function for subgroups.
  void set sortSubgroups(Comparator comparator) {
    js.sortSubgroups(comparator);
  }

  /// Set the comparator function for chords (z-order).
  void set sortChords(Comparator comparator) {
    js.sortChords(comparator);
  }

  /// Retrieve the computed chord angles.
  List chords() => js.chords();

  /// Retrieve the computed group angles.
  List groups() => js.groups();
}
