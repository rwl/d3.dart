@JS('d3.layout')
library d3.src.layout;

import 'package:js/js.dart';

/// Construct a new default bundle layout.
external Bundle bundle();

@JS()
abstract class Bundle implements Function {
  call(links) => bundle(links);

  /// Apply Holten's hierarchical bundling algorithm to edges.
  external bundle(links);
}

/// Produce a chord diagram from a matrix of relationships.
external Chord chord();

@JS()
class Chord {
  /// Get or set the matrix data backing the layout.
  external matrix([matrix]);

  /// Get or set the angular padding between chord segments.
  external padding([padding]);

  /// Get or set the comparator function for groups.
  external sortGroups([comparator]);

  /// Get or set the comparator function for subgroups.
  external sortSubgroups([comparator]);

  /// Get or set the comparator function for chords (z-order).
  external sortChords([comparator]);

  /// Retrieve the computed chord angles.
  external chords();

  /// Retrieve the computed group angles.
  external groups();
}

/// Cluster entities into a dendrogram.
external Cluster cluster();

@JS()
abstract class Cluster implements Function {
  call(root) => cluster(root);

  /// Alias for cluster.nodes.
  external cluster(root);

  /// Compute the cluster layout and return the array of nodes.
  external nodes(root);

  /// Compute the parent-child links between tree nodes.
  external links(nodes);

  /// Get or set the accessor function for child nodes.
  external children([children]);

  /// Get or set the comparator function for sibling nodes.
  external sort([comparator]);

  /// Get or set the spacing function between neighboring nodes.
  external separation([separation]);

  /// Get or set the layout size in x and y.
  external size([size]);
  external nodeSize([nodeSize]);

  /// Specify a fixed size for each node.
  external value([value]);
}

/// Position linked nodes using physical simulation.
external Force force();

@JS()
class Force {
  /// Get or set the layout size in x and y.
  external size([width, height]);

  /// Get or set the link distance.
  external linkDistance([distance]);

  /// Get or set the link strength.
  external linkStrength([strength]);

  /// Get or set the friction coefficient.
  external friction([friction]);

  /// Get or set the charge strength.
  external charge([charge]);

  /// Get or set the maximum charge distance.
  external chargeDistance([distance]);

  /// Get or set the accuracy of the charge interaction.
  external theta([theta]);

  /// Get or set the gravity strength.
  external gravity([gravity]);

  /// Get or set the array of nodes to layout.
  external nodes([nodes]);

  /// Get or set the array of links between nodes.
  external links([links]);

  /// Start or restart the simulation when the nodes change.
  external start();

  /// Get or set the layout's cooling parameter.
  external alpha([value]);

  /// Reheat the cooling parameter and restart simulation.
  external resume();

  /// Immediately terminate the simulation.
  external stop();

  /// Run the layout simulation one step.
  external tick();

  /// Listen to updates in the computed layout positions.
  external on(type, listener);

  /// Bind a behavior to nodes to allow interactive dragging.
  external drag();
}

/// Derive a custom hierarchical layout implementation.
external Hierarchy hierarchy();

@JS()
abstract class Hierarchy implements Function {
  call(root) => hierarchy(root);

  /// Alias for hierarchy.nodes.
  external hierarchy(root);

  /// Compute the layout and return the array of nodes.
  external nodes(root);

  /// Compute the parent-child links between tree nodes.
  external links(nodes);

  /// Get or set the accessor function for child nodes.
  external children([accessor]);

  /// Get or set the comparator function for sibling nodes.
  external sort([comparator]);

  /// Get or set the value accessor function.
  external value([value]);

  /// Recompute the hierarchy values.
  external revalue(root);
}

/// Construct a new default histogram layout.
external Histogram histogram();

@JS()
abstract class Histogram implements Function {
  call(values, [index]) => histogram(values, [index]);

  /// Compute the distribution of data using quantized bins.
  external histogram(values, [index]);

  /// Get or set the value accessor function.
  external value([accessor]);

  /// Get or set the considered value range.
  external range([range]);

  /// Specify how values are organized into bins.
  external bins([count_or_thresholds_or_function]);

  /// Compute the distribution as counts or probabilities.
  external frequency([frequency]);
}

/// Produce a hierarchical layout using recursive circle-packing.
external Pack pack();

@JS()
abstract class Pack implements Function {
  call(root) => pack(root);

  /// Alias for pack.nodes.
  external pack(root);

  /// Compute the pack layout and return the array of nodes.
  external nodes(root);

  /// Compute the parent-child links between tree nodes.
  external links(nodes);

  /// Get or set the children accessor function.
  external children([children]);

  /// Control the order in which sibling nodes are traversed.
  external sort([comparator]);

  /// Get or set the value accessor used to size circles.
  external value([value]);

  /// Specify the layout size in x and y.
  external size([size]);

  /// Specify the node radius, rather than deriving it from value.
  external radius([radius]);

  /// Specify the layout padding in (approximate) pixels.
  external padding([padding]);
}

/// Recursively partition a node tree into a sunburst or icicle.
external Partition partition();

@JS()
abstract class Partition implements Function {
  call(root) => partition(root);

  /// Alias for partition.nodes.
  external partition(root);

  /// Compute the partition layout and return the array of nodes.
  external nodes(root);

  /// Compute the parent-child links between tree nodes.
  external links(nodes);

  /// Get or set the children accessor function.
  external children([children]);

  /// Control the order in which sibling nodes are traversed.
  external sort([comparator]);

  /// Get or set the value accessor used to size circles.
  external value([value]);

  /// Specify the layout size in x and y.
  external size([size]);
}

/// Construct a new default pie layout.
external Pie pie();

@JS()
abstract class Pie implements Function {
  call(values, [index]) => pie(values, [index]);

  /// Compute the start and end angles for arcs in a pie or donut chart.
  external pie(values, [index]);

  /// Get or set the value accessor function.
  external value([accessor]);

  /// Control the clockwise order of pie slices.
  external sort([comparator]);

  /// Get or set the overall start angle of the pie.
  external startAngle([angle]);

  /// Get or set the overall end angle of the pie.
  external endAngle([angle]);

  /// Get or set the pad angle of the pie.
  external padAngle([angle]);
}

/// Construct a new default stack layout.
external Stack stack();

@JS()
abstract class Stack implements Function {
  call(layers, [index]) => stack(layers, [index]);

  /// Compute the baseline for each series in a stacked bar or area chart.
  external stack(layers, [index]);

  /// Get or set the values accessor function per series.
  external values([accessor]);

  /// Specify the overall baseline algorithm.
  external offset([offset]);

  /// Control the order in which series are stacked.
  external order([order]);

  /// Get or set the x-dimension accessor function.
  external x([accessor]);

  /// Get or set the y-dimension accessor function.
  external y([accessor]);

  /// Get or set the output function for storing the baseline.
  external out([setter]);
}

/// Position a tree of nodes tidily.
external Tree tree();

@JS()
abstract class Tree implements Function {
  call(root) => tree(root);

  /// Alias for tree.nodes.
  external tree(root);

  /// Compute the tree layout and return the array of nodes.
  external nodes(root);

  /// Compute the parent-child links between tree nodes.
  external links(nodes);

  /// Get or set the children accessor function.
  external children([children]);

  /// Get or set the spacing function between neighboring nodes.
  external separation([separation]);

  /// Specify the layout size in x and y.
  external size([size]);

  /// Specify a fixed size for each node.
  external nodeSize([nodeSize]);

  /// Control the order in which sibling nodes are traversed.
  external sort([comparator]);
  external value([value]);
}

/// Use recursive spatial subdivision to display a tree of nodes.
external Treemap treemap();

@JS()
abstract class Treemap implements Function {
  call(root) => treemap(root);

  /// Alias for treemap.nodes.
  external treemap(root);

  /// Compute the treemap layout and return the array of nodes.
  external nodes(root);

  /// Compute the parent-child links between tree nodes.
  external links(nodes);

  /// Get or set the children accessor function.
  external children([children]);

  /// Control the order in which sibling nodes are traversed.
  external sort([comparator]);

  /// Get or set the value accessor used to size treemap cells.
  external value([value]);

  /// Specify the layout size in x and y.
  external size([size]);

  /// Specify the padding between a parent and its children.
  external padding([padding]);

  /// Enable or disable rounding to exact pixels.
  external round([round]);

  /// Make the layout sticky for stable updates.
  external sticky([sticky]);

  /// Change the treemap layout algorithm.
  external mode([mode]);
  external ratio([ratio]);
}
