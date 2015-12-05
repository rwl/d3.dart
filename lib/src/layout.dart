library d3.src.layout;

import 'dart:js';

JsObject _layout = context['d3']['layout'];

/// Construct a new default bundle layout.
Bundle bundle() {
  return _layout.callMethod('bundle', []);
}

class Bundle {
  final JsObject _proxy;

  Bundle._(this._proxy);

  call(links) => bundle(links);

  /// Apply Holten's hierarchical bundling algorithm to edges.
  bundle(links) {
    return _proxy.callMethod('bundle', []);
  }
}

/// Produce a chord diagram from a matrix of relationships.
Chord chord() {
  return _layout.callMethod('chord', []);
}

class Chord {
  final JsObject _proxy;

  Chord._(this._proxy);

  /// Get or set the matrix data backing the layout.
  matrix([matrix]) {
    return _proxy.callMethod('matrix', []);
  }

  /// Get or set the angular padding between chord segments.
  padding([padding]) {
    return _proxy.callMethod('padding', []);
  }

  /// Get or set the comparator function for groups.
  sortGroups([comparator]) {
    return _proxy.callMethod('sortGroups', []);
  }

  /// Get or set the comparator function for subgroups.
  sortSubgroups([comparator]) {
    return _proxy.callMethod('sortSubgroups', []);
  }

  /// Get or set the comparator function for chords (z-order).
  sortChords([comparator]) {
    return _proxy.callMethod('sortChords', []);
  }

  /// Retrieve the computed chord angles.
  chords() {
    return _proxy.callMethod('chords', []);
  }

  /// Retrieve the computed group angles.
  groups() {
    return _proxy.callMethod('groups', []);
  }
}

/// Cluster entities into a dendrogram.
Cluster cluster() {
  return _layout.callMethod('', []);
}

class Cluster {
  final JsObject _proxy;

  Cluster._(this._proxy);

  call(root) => cluster(root);

  /// Alias for cluster.nodes.
  cluster(root) {
    return _proxy.callMethod('cluster', []);
  }

  /// Compute the cluster layout and return the array of nodes.
  nodes(root) {
    return _proxy.callMethod('nodes', []);
  }

  /// Compute the parent-child links between tree nodes.
  links(nodes) {
    return _proxy.callMethod('links', []);
  }

  /// Get or set the accessor function for child nodes.
  children([children]) {
    return _proxy.callMethod('children', []);
  }

  /// Get or set the comparator function for sibling nodes.
  sort([comparator]) {
    return _proxy.callMethod('sort', []);
  }

  /// Get or set the spacing function between neighboring nodes.
  separation([separation]) {
    return _proxy.callMethod('separation', []);
  }

  /// Get or set the layout size in x and y.
  size([size]) {
    return _proxy.callMethod('size', []);
  }

  nodeSize([nodeSize]) {
    return _proxy.callMethod('nodeSize', []);
  }

  /// Specify a fixed size for each node.
  value([value]) {
    return _proxy.callMethod('value', []);
  }
}

/// Position linked nodes using physical simulation.
Force force() {
  return _layout.callMethod('force', []);
}

class Force {
  final JsObject _proxy;

  Force._(this._proxy);

  /// Get or set the layout size in x and y.
  size([width, height]) {
    return _proxy.callMethod('size', []);
  }

  /// Get or set the link distance.
  linkDistance([distance]) {
    return _proxy.callMethod('linkDistance', []);
  }

  /// Get or set the link strength.
  linkStrength([strength]) {
    return _proxy.callMethod('linkStrength', []);
  }

  /// Get or set the friction coefficient.
  friction([friction]) {
    return _proxy.callMethod('friction', []);
  }

  /// Get or set the charge strength.
  charge([charge]) {
    return _proxy.callMethod('charge', []);
  }

  /// Get or set the maximum charge distance.
  chargeDistance([distance]) {
    return _proxy.callMethod('chargeDistance', []);
  }

  /// Get or set the accuracy of the charge interaction.
  theta([theta]) {
    return _proxy.callMethod('theta', []);
  }

  /// Get or set the gravity strength.
  gravity([gravity]) {
    return _proxy.callMethod('gravity', []);
  }

  /// Get or set the array of nodes to layout.
  nodes([nodes]) {
    return _proxy.callMethod('nodes', []);
  }

  /// Get or set the array of links between nodes.
  links([links]) {
    return _proxy.callMethod('links', []);
  }

  /// Start or restart the simulation when the nodes change.
  start() {
    return _proxy.callMethod('start', []);
  }

  /// Get or set the layout's cooling parameter.
  alpha([value]) {
    return _proxy.callMethod('alpha', []);
  }

  /// Reheat the cooling parameter and restart simulation.
  resume() {
    return _proxy.callMethod('resume', []);
  }

  /// Immediately terminate the simulation.
  stop() {
    return _proxy.callMethod('stop', []);
  }

  /// Run the layout simulation one step.
  tick() {
    return _proxy.callMethod('tick', []);
  }

  /// Listen to updates in the computed layout positions.
  on(type, listener) {
    return _proxy.callMethod('on', []);
  }

  /// Bind a behavior to nodes to allow interactive dragging.
  drag() {
    return _proxy.callMethod('drag', []);
  }
}

/// Derive a custom hierarchical layout implementation.
Hierarchy hierarchy() {
  return _layout.callMethod('hierarchy', []);
}

abstract class Hierarchy implements Function {
  final JsObject _proxy;

  Hierarchy._(this._proxy);

  call(root) => hierarchy(root);

  /// Alias for hierarchy.nodes.
  hierarchy(root) {
    return _proxy.callMethod('hierarchy', []);
  }

  /// Compute the layout and return the array of nodes.
  nodes(root) {
    return _proxy.callMethod('nodes', []);
  }

  /// Compute the parent-child links between tree nodes.
  links(nodes) {
    return _proxy.callMethod('links', []);
  }

  /// Get or set the accessor function for child nodes.
  children([accessor]) {
    return _proxy.callMethod('children', []);
  }

  /// Get or set the comparator function for sibling nodes.
  sort([comparator]) {
    return _proxy.callMethod('sort', []);
  }

  /// Get or set the value accessor function.
  value([value]) {
    return _proxy.callMethod('value', []);
  }

  /// Recompute the hierarchy values.
  revalue(root) {
    return _proxy.callMethod('revalue', []);
  }
}

/// Construct a new default histogram layout.
Histogram histogram() {
  return _layout.callMethod('histogram', []);
}

abstract class Histogram implements Function {
  final JsObject _proxy;

  Histogram._(this._proxy);

  call(values, [index]) => histogram(values, [index]);

  /// Compute the distribution of data using quantized bins.
  histogram(values, [index]) {
    return _proxy.callMethod('histogram', []);
  }

  /// Get or set the value accessor function.
  value([accessor]) {
    return _proxy.callMethod('value', []);
  }

  /// Get or set the considered value range.
  range([range]) {
    return _proxy.callMethod('range', []);
  }

  /// Specify how values are organized into bins.
  bins([count_or_thresholds_or_function]) {
    return _proxy.callMethod('bins', []);
  }

  /// Compute the distribution as counts or probabilities.
  frequency([frequency]) {
    return _proxy.callMethod('frequency', []);
  }
}

/// Produce a hierarchical layout using recursive circle-packing.
Pack pack() {
  return _layout.callMethod('pack', []);
}

class Pack {
  final JsObject _proxy;

  Pack._(this._proxy);

  call(root) => pack(root);

  /// Alias for pack.nodes.
  pack(root) {
    return _proxy.callMethod('pack', []);
  }

  /// Compute the pack layout and return the array of nodes.
  nodes(root) {
    return _proxy.callMethod('nodes', []);
  }

  /// Compute the parent-child links between tree nodes.
  links(nodes) {
    return _proxy.callMethod('links', []);
  }

  /// Get or set the children accessor function.
  children([children]) {
    return _proxy.callMethod('children', []);
  }

  /// Control the order in which sibling nodes are traversed.
  sort([comparator]) {
    return _proxy.callMethod('sort', []);
  }

  /// Get or set the value accessor used to size circles.
  value([value]) {
    return _proxy.callMethod('value', []);
  }

  /// Specify the layout size in x and y.
  size([size]) {
    return _proxy.callMethod('size', []);
  }

  /// Specify the node radius, rather than deriving it from value.
  radius([radius]) {
    return _proxy.callMethod('radius', []);
  }

  /// Specify the layout padding in (approximate) pixels.
  padding([padding]) {
    return _proxy.callMethod('padding', []);
  }
}

/// Recursively partition a node tree into a sunburst or icicle.
Partition partition() {
  return _layout.callMethod('partition', []);
}

class Partition {
  final JsObject _proxy;

  Partition._(this._proxy);

  call(root) => partition(root);

  /// Alias for partition.nodes.
  partition(root) {
    return _proxy.callMethod('partition', []);
  }

  /// Compute the partition layout and return the array of nodes.
  nodes(root) {
    return _proxy.callMethod('nodes', []);
  }

  /// Compute the parent-child links between tree nodes.
  links(nodes) {
    return _proxy.callMethod('links', []);
  }

  /// Get or set the children accessor function.
  children([children]) {
    return _proxy.callMethod('children', []);
  }

  /// Control the order in which sibling nodes are traversed.
  sort([comparator]) {
    return _proxy.callMethod('sort', []);
  }

  /// Get or set the value accessor used to size circles.
  value([value]) {
    return _proxy.callMethod('value', []);
  }

  /// Specify the layout size in x and y.
  size([size]) {
    return _proxy.callMethod('size', []);
  }
}

/// Construct a new default pie layout.
Pie pie() {
  return _layout.callMethod('pie', []);
}

class Pie {
  final JsObject _proxy;

  Pie._(this._proxy);

  call(values, [index]) => pie(values, [index]);

  /// Compute the start and end angles for arcs in a pie or donut chart.
  pie(values, [index]) {
    return _proxy.callMethod('pie', []);
  }

  /// Get or set the value accessor function.
  value([accessor]) {
    return _proxy.callMethod('value', []);
  }

  /// Control the clockwise order of pie slices.
  sort([comparator]) {
    return _proxy.callMethod('sort', []);
  }

  /// Get or set the overall start angle of the pie.
  startAngle([angle]) {
    return _proxy.callMethod('startAngle', []);
  }

  /// Get or set the overall end angle of the pie.
  endAngle([angle]) {
    return _proxy.callMethod('endAngle', []);
  }

  /// Get or set the pad angle of the pie.
  padAngle([angle]) {
    return _proxy.callMethod('padAngle', []);
  }
}

/// Construct a new default stack layout.
Stack stack() {
  return _layout.callMethod('stack', []);
}

class Stack {
  final JsObject _proxy;

  Stack._(this._proxy);

  call(layers, [index]) => stack(layers, [index]);

  /// Compute the baseline for each series in a stacked bar or area chart.
  stack(layers, [index]) {
    return _proxy.callMethod('stack', []);
  }

  /// Get or set the values accessor function per series.
  values([accessor]) {
    return _proxy.callMethod('values', []);
  }

  /// Specify the overall baseline algorithm.
  offset([offset]) {
    return _proxy.callMethod('offset', []);
  }

  /// Control the order in which series are stacked.
  order([order]) {
    return _proxy.callMethod('order', []);
  }

  /// Get or set the x-dimension accessor function.
  x([accessor]) {
    return _proxy.callMethod('x', []);
  }

  /// Get or set the y-dimension accessor function.
  y([accessor]) {
    return _proxy.callMethod('y', []);
  }

  /// Get or set the output function for storing the baseline.
  out([setter]) {
    return _proxy.callMethod('out', []);
  }
}

/// Position a tree of nodes tidily.
Tree tree() {
  return _layout.callMethod('tree', []);
}

class Tree {
  final JsObject _proxy;

  Tree._(this._proxy);

  call(root) => tree(root);

  /// Alias for tree.nodes.
  tree(root) {
    return _proxy.callMethod('tree', []);
  }

  /// Compute the tree layout and return the array of nodes.
  nodes(root) {
    return _proxy.callMethod('nodes', []);
  }

  /// Compute the parent-child links between tree nodes.
  links(nodes) {
    return _proxy.callMethod('links', []);
  }

  /// Get or set the children accessor function.
  children([children]) {
    return _proxy.callMethod('children', []);
  }

  /// Get or set the spacing function between neighboring nodes.
  separation([separation]) {
    return _proxy.callMethod('separation', []);
  }

  /// Specify the layout size in x and y.
  size([size]) {
    return _proxy.callMethod('size', []);
  }

  /// Specify a fixed size for each node.
  nodeSize([nodeSize]) {
    return _proxy.callMethod('nodeSize', []);
  }

  /// Control the order in which sibling nodes are traversed.
  sort([comparator]) {
    return _proxy.callMethod('sort', []);
  }

  value([value]) {
    return _proxy.callMethod('value', []);
  }
}

/// Use recursive spatial subdivision to display a tree of nodes.
Treemap treemap() {
  return _layout.callMethod('treemap', []);
}

class Treemap {
  final JsObject _proxy;

  Treemap._(this._proxy);

  call(root) => treemap(root);

  /// Alias for treemap.nodes.
  treemap(root) {
    return _proxy.callMethod('treemap', []);
  }

  /// Compute the treemap layout and return the array of nodes.
  nodes(root) {
    return _proxy.callMethod('nodes', []);
  }

  /// Compute the parent-child links between tree nodes.
  links(nodes) {
    return _proxy.callMethod('links', []);
  }

  /// Get or set the children accessor function.
  children([children]) {
    return _proxy.callMethod('children', []);
  }

  /// Control the order in which sibling nodes are traversed.
  sort([comparator]) {
    return _proxy.callMethod('sort', []);
  }

  /// Get or set the value accessor used to size treemap cells.
  value([value]) {
    return _proxy.callMethod('value', []);
  }

  /// Specify the layout size in x and y.
  size([size]) {
    return _proxy.callMethod('size', []);
  }

  /// Specify the padding between a parent and its children.
  padding([padding]) {
    return _proxy.callMethod('padding', []);
  }

  /// Enable or disable rounding to exact pixels.
  round([round]) {
    return _proxy.callMethod('round', []);
  }

  /// Make the layout sticky for stable updates.
  sticky([sticky]) {
    return _proxy.callMethod('sticky', []);
  }

  /// Change the treemap layout algorithm.
  mode([mode]) {
    return _proxy.callMethod('mode', []);
  }

  ratio([ratio]) {
    return _proxy.callMethod('ratio', []);
  }
}
