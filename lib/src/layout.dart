library d3.src.layout;

import 'dart:async';
import 'js/layout.dart' as layout;
import 'selection.dart';

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

  Stream<Selected> get onTick {
    var ctrl = new StreamController(onCancel: () {
      js.on('tick', null);
    });
    js.on('tick', (elem, data, i) {
      ctrl.add(new Selected(elem, data, i));
    });
    return ctrl.stream;
  }
}
