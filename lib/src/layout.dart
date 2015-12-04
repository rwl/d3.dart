@JS('d3.layout')
library d3.src.layout;

import 'package:js/js.dart';

/// construct a new default bundle layout.
external Bundle bundle();

@JS()
class Bundle {
  /// apply Holten's hierarchical bundling algorithm to edges.
  external bundle(links);
}

/// produce a chord diagram from a matrix of relationships.
external Chord chord();

@JS()
class Chord {
  /// get or set the matrix data backing the layout.
  external matrix([matrix]);

  /// get or set the angular padding between chord segments.
  external padding([padding]);

  /// get or set the comparator function for groups.
  external sortGroups([comparator]);

  /// get or set the comparator function for subgroups.
  external sortSubgroups([comparator]);

  /// get or set the comparator function for chords (z-order).
  external sortChords([comparator]);

  /// retrieve the computed chord angles.
  external chords();

  /// retrieve the computed group angles.
  external groups();
}

/// cluster entities into a dendrogram.
external Cluster cluster();

@JS()
class Cluster {
  /// alias for cluster.nodes.
  external cluster(root);

  /// compute the cluster layout and return the array of nodes.
  external nodes(root);

  /// compute the parent-child links between tree nodes.
  external links(nodes);

  /// get or set the accessor function for child nodes.
  external children([children]);

  /// get or set the comparator function for sibling nodes.
  external sort([comparator]);

  /// get or set the spacing function between neighboring nodes.
  external separation([separation]);

  /// get or set the layout size in x and y.
  external size([size]);
  external nodeSize([nodeSize]);

  /// specify a fixed size for each node.
  external value([value]);
}

/// position linked nodes using physical simulation.
external Force force();

@JS()
class Force {
  /// get or set the layout size in x and y.
  external size([width, height]);

  /// get or set the link distance.
  external linkDistance([distance]);

  /// get or set the link strength.
  external linkStrength([strength]);

  /// get or set the friction coefficient.
  external friction([friction]);

  /// get or set the charge strength.
  external charge([charge]);

  /// get or set the maximum charge distance.
  external chargeDistance([distance]);

  /// get or set the accuracy of the charge interaction.
  external theta([theta]);

  /// get or set the gravity strength.
  external gravity([gravity]);

  /// get or set the array of nodes to layout.
  external nodes([nodes]);

  /// get or set the array of links between nodes.
  external links([links]);

  /// start or restart the simulation when the nodes change.
  external start();

  /// get or set the layout's cooling parameter.
  external alpha([value]);

  /// reheat the cooling parameter and restart simulation.
  external resume();

  /// immediately terminate the simulation.
  external stop();

  /// run the layout simulation one step.
  external tick();

  /// listen to updates in the computed layout positions.
  external on(type, listener);

  /// bind a behavior to nodes to allow interactive dragging.
  external drag();
}

/// derive a custom hierarchical layout implementation.
external Hierarchy hierarchy();

@JS()
class Hierarchy {
  /// alias for hierarchy.nodes.
  external hierarchy(root);

  /// compute the layout and return the array of nodes.
  external nodes(root);

  /// compute the parent-child links between tree nodes.
  external links(nodes);

  /// get or set the accessor function for child nodes.
  external children([accessor]);

  /// get or set the comparator function for sibling nodes.
  external sort([comparator]);

  /// get or set the value accessor function.
  external value([value]);

  /// recompute the hierarchy values.
  external revalue(root);
}

/// construct a new default histogram layout.
external Histogram histogram();

@JS()
class Histogram {
  /// compute the distribution of data using quantized bins.
  external histogram(values, [index]);

  /// get or set the value accessor function.
  external value([accessor]);

  /// get or set the considered value range.
  external range([range]);

  /// specify how values are organized into bins.
  external bins([count_or_thresholds_or_function]);

  /// compute the distribution as counts or probabilities.
  external frequency([frequency]);
}

/// produce a hierarchical layout using recursive circle-packing.
external Pack pack();

@JS()
class Pack {
  /// alias for pack.nodes.
  external pack(root);

  /// compute the pack layout and return the array of nodes.
  external nodes(root);

  /// compute the parent-child links between tree nodes.
  external links(nodes);

  /// get or set the children accessor function.
  external children([children]);

  /// control the order in which sibling nodes are traversed.
  external sort([comparator]);

  /// get or set the value accessor used to size circles.
  external value([value]);

  /// specify the layout size in x and y.
  external size([size]);

  /// specify the node radius, rather than deriving it from value.
  external radius([radius]);

  /// specify the layout padding in (approximate) pixels.
  external padding([padding]);
}

/// recursively partition a node tree into a sunburst or icicle.
external Partition partition();

@JS()
class Partition {
  /// alias for partition.nodes.
  external partition(root);

  /// compute the partition layout and return the array of nodes.
  external nodes(root);

  /// compute the parent-child links between tree nodes.
  external links(nodes);

  /// get or set the children accessor function.
  external children([children]);

  /// control the order in which sibling nodes are traversed.
  external sort([comparator]);

  /// get or set the value accessor used to size circles.
  external value([value]);

  /// specify the layout size in x and y.
  external size([size]);
}

/// construct a new default pie layout.
external Pie pie();

@JS()
class Pie {
  /// compute the start and end angles for arcs in a pie or donut chart.
  external pie(values, [index]);

  /// get or set the value accessor function.
  external value([accessor]);

  /// control the clockwise order of pie slices.
  external sort([comparator]);

  /// get or set the overall start angle of the pie.
  external startAngle([angle]);

  /// get or set the overall end angle of the pie.
  external endAngle([angle]);

  /// get or set the pad angle of the pie.
  external padAngle([angle]);
}

/// construct a new default stack layout.
external Stack stack();

@JS()
class Stack {
  /// compute the baseline for each series in a stacked bar or area chart.
  external stack(layers, [index]);

  /// get or set the values accessor function per series.
  external values([accessor]);

  /// specify the overall baseline algorithm.
  external offset([offset]);

  /// control the order in which series are stacked.
  external order([order]);

  /// get or set the x-dimension accessor function.
  external x([accessor]);

  /// get or set the y-dimension accessor function.
  external y([accessor]);

  /// get or set the output function for storing the baseline.
  external out([setter]);
}

/// position a tree of nodes tidily.
external Tree tree();

@JS()
class Tree {
  /// alias for tree.nodes.
  external tree(root);

  /// compute the tree layout and return the array of nodes.
  external nodes(root);

  /// compute the parent-child links between tree nodes.
  external links(nodes);

  /// get or set the children accessor function.
  external children([children]);

  /// get or set the spacing function between neighboring nodes.
  external separation([separation]);

  /// specify the layout size in x and y.
  external size([size]);

  /// specify a fixed size for each node.
  external nodeSize([nodeSize]);

  /// control the order in which sibling nodes are traversed.
  external sort([comparator]);
  external value([value]);
}

/// use recursive spatial subdivision to display a tree of nodes.
external Treemap treemap();

@JS()
class Treemap {
  /// alias for treemap.nodes.
  external treemap(root);

  /// compute the treemap layout and return the array of nodes.
  external nodes(root);

  /// compute the parent-child links between tree nodes.
  external links(nodes);

  /// get or set the children accessor function.
  external children([children]);

  /// control the order in which sibling nodes are traversed.
  external sort([comparator]);

  /// get or set the value accessor used to size treemap cells.
  external value([value]);

  /// specify the layout size in x and y.
  external size([size]);

  /// specify the padding between a parent and its children.
  external padding([padding]);

  /// enable or disable rounding to exact pixels.
  external round([round]);

  /// make the layout sticky for stable updates.
  external sticky([sticky]);

  /// change the treemap layout algorithm.
  external mode([mode]);
  external ratio([ratio]);
}
