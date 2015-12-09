library d3.src.js.layout;

import 'dart:js';
import 'd3.dart';

JsObject _layout = context['d3']['layout'];

/// Construct a new default bundle layout.
Bundle bundle() => new Bundle._(_layout.callMethod('bundle'));

class Bundle {
  final JsObject _proxy;

  Bundle._(this._proxy);

  factory Bundle() => bundle();

  /// Apply Holten's hierarchical bundling algorithm to edges.
  call(links) => _proxy.callMethod('call', [_proxy, new JsObject.jsify(links)]);
}

/// Produce a chord diagram from a matrix of relationships.
Chord chord() => new Chord._(_layout.callMethod('chord'));

class Chord {
  final JsObject _proxy;

  Chord._(this._proxy);

  factory Chord() => chord();

  /// Get or set the matrix data backing the layout.
  matrix([List<List> matrix = undefinedList]) {
    var args = [];
    if (matrix != undefinedList) {
      args.add(matrix);
    }
    var retval = _proxy.callMethod('matrix', args);
    if (matrix == undefinedList) {
      return retval;
    } else {
      return new Chord._(retval);
    }
  }

  /// Get or set the angular padding between chord segments.
  padding([num padding = undefinedNum]) {
    var args = [];
    if (padding != undefinedNum) {
      args.add(padding);
    }
    var retval = _proxy.callMethod('padding', args);
    if (padding == undefinedNum) {
      return retval;
    } else {
      return new Chord._(retval);
    }
  }

  /// Get or set the comparator function for groups.
  sortGroups([Function comparator = undefinedFn]) {
    var args = [];
    if (comparator != undefinedFn) {
      args.add(comparator);
    }
    var retval = _proxy.callMethod('sortGroups', args);
    if (comparator == undefinedFn) {
      return retval;
    } else {
      return new Chord._(retval);
    }
  }

  /// Get or set the comparator function for subgroups.
  sortSubgroups([Function comparator = undefinedFn]) {
    var args = [];
    if (comparator != undefinedFn) {
      args.add(comparator);
    }
    var retval = _proxy.callMethod('sortSubgroups', args);
    if (comparator == undefinedFn) {
      return retval;
    } else {
      return new Chord._(retval);
    }
  }

  /// Get or set the comparator function for chords (z-order).
  sortChords([Function comparator = undefinedFn]) {
    var args = [];
    if (comparator != undefinedFn) {
      args.add(comparator);
    }
    var retval = _proxy.callMethod('sortChords', args);
    if (comparator == undefinedFn) {
      return retval;
    } else {
      return new Chord._(retval);
    }
  }

  /// Retrieve the computed chord angles.
  chords() => _proxy.callMethod('chords');

  /// Retrieve the computed group angles.
  groups() => _proxy.callMethod('groups');
}

/// Cluster entities into a dendrogram.
Cluster cluster() => new Cluster._(_layout.callMethod('cluster'));

class Cluster {
  final JsObject _proxy;

  Cluster._(this._proxy);

  factory Cluster() => cluster();

  /// Alias for cluster.nodes.
  call(root) => _proxy.callMethod('call', [_proxy, root]);

  /// Compute the cluster layout and return the array of nodes.
  List nodes(root) => _proxy.callMethod('nodes', [root]);

  /// Compute the parent-child links between tree nodes.
  List links(nodes) => _proxy.callMethod('links', [nodes]);

  /// Get or set the accessor function for child nodes.
  children([Function children = undefinedFn]) {
    var args = [];
    if (children != undefinedFn) {
      args.add(children);
    }
    var retval = _proxy.callMethod('children', args);
    if (children == undefinedFn) {
      return retval;
    } else {
      return new Cluster._(retval);
    }
  }

  /// Get or set the comparator function for sibling nodes.
  sort([Function comparator = undefinedFn]) {
    var args = [];
    if (comparator != undefinedFn) {
      args.add(comparator);
    }
    var retval = _proxy.callMethod('sort', args);
    if (comparator == undefinedFn) {
      return retval;
    } else {
      return new Cluster._(retval);
    }
  }

  /// Get or set the spacing function between neighboring nodes.
  separation([Function separation = undefinedFn]) {
    var args = [];
    if (separation != undefinedFn) {
      args.add(separation);
    }
    var retval = _proxy.callMethod('separation', args);
    if (separation == undefinedFn) {
      return retval;
    } else {
      return new Cluster._(retval);
    }
  }

  /// Get or set the layout size in x and y.
  size([List size = undefinedList]) {
    var args = [];
    if (size != undefinedList) {
      args.add(size);
    }
    var retval = _proxy.callMethod('size', args);
    if (size == undefinedList) {
      return retval;
    } else {
      return new Cluster._(retval);
    }
  }

  nodeSize([List nodeSize = undefinedList]) {
    var args = [];
    if (nodeSize != undefinedList) {
      args.add(nodeSize);
    }
    var retval = _proxy.callMethod('nodeSize', args);
    if (nodeSize == undefinedList) {
      return retval;
    } else {
      return new Cluster._(retval);
    }
  }

  /// Specify a fixed size for each node.
  value([Function value = undefinedFn]) {
    var args = [];
    if (value != undefinedFn) {
      args.add(value);
    }
    var retval = _proxy.callMethod('value', args);
    if (value == undefinedFn) {
      return retval;
    } else {
      return new Cluster._(retval);
    }
  }
}

/// Position linked nodes using physical simulation.
Force force() => new Force._(_layout.callMethod('force'));

class Force {
  final JsObject _proxy;

  Force._(this._proxy);

  factory Force() => force();

  /// Get or set the layout size in x and y.
  size([List size = undefinedList]) {
    var args = [];
    if (size != undefinedList) {
      args.add(size);
    }
    var retval = _proxy.callMethod('size', args);
    if (size == undefinedList) {
      return retval;
    } else {
      return new Force._(retval);
    }
  }

  /// Get or set the link distance.
  linkDistance([distance = undefined]) {
    var args = [];
    if (distance is Function) {
      args.add(func4VarArgs(distance));
    } else if (distance != undefined) {
      args.add(distance);
    }
    var retval = _proxy.callMethod('linkDistance', args);
    if (distance == undefined) {
      return retval;
    } else {
      return new Force._(retval);
    }
  }

  /// Get or set the link strength.
  linkStrength([strength = undefined]) {
    var args = [];
    if (strength is Function) {
      args.add(func4VarArgs(strength));
    } else if (strength != undefined) {
      args.add(strength);
    }
    var retval = _proxy.callMethod('linkStrength', args);
    if (strength == undefined) {
      return retval;
    } else {
      return new Force._(retval);
    }
  }

  /// Get or set the friction coefficient.
  friction([num friction = undefinedNum]) {
    var args = [];
    if (friction != undefinedNum) {
      args.add(friction);
    }
    var retval = _proxy.callMethod('friction', args);
    if (friction == undefinedNum) {
      return retval;
    } else {
      return new Force._(retval);
    }
  }

  /// Get or set the charge strength.
  charge([charge = undefined]) {
    var args = [];
    if (charge is Function) {
      args.add(func4VarArgs(charge));
    } else if (charge != undefined) {
      args.add(charge);
    }
    var retval = _proxy.callMethod('charge', args);
    if (charge == undefined) {
      return retval;
    } else {
      return new Force._(retval);
    }
  }

  /// Get or set the maximum charge distance.
  chargeDistance([num distance = undefinedNum]) {
    var args = [];
    if (distance != undefinedNum) {
      args.add(distance);
    }
    var retval = _proxy.callMethod('chargeDistance', args);
    if (distance == undefinedNum) {
      return retval;
    } else {
      return new Force._(retval);
    }
  }

  /// Get or set the accuracy of the charge interaction.
  theta([num theta = undefinedNum]) {
    var args = [];
    if (theta != undefinedNum) {
      args.add(theta);
    }
    var retval = _proxy.callMethod('theta', args);
    if (theta == undefinedNum) {
      return retval;
    } else {
      return new Force._(retval);
    }
  }

  /// Get or set the gravity strength.
  gravity([num gravity = undefinedNum]) {
    var args = [];
    if (gravity != undefinedNum) {
      args.add(gravity);
    }
    var retval = _proxy.callMethod('gravity', args);
    if (gravity == undefinedNum) {
      return retval;
    } else {
      return new Force._(retval);
    }
  }

  /// Get or set the array of nodes to layout.
  nodes([List nodes = undefinedList]) {
    var args = [];
    if (nodes != undefinedList) {
      args.add(nodes);
    }
    var retval = _proxy.callMethod('nodes', args);
    if (nodes == undefinedList) {
      return retval;
    } else {
      return new Force._(retval);
    }
  }

  /// Get or set the array of links between nodes.
  links([List links = undefinedList]) {
    var args = [];
    if (links != undefinedList) {
      args.add(new JsObject.jsify(links));
    }
    var retval = _proxy.callMethod('links', args);
    if (links == undefinedList) {
      return retval;
    } else {
      return new Force._(retval);
    }
  }

  /// Start or restart the simulation when the nodes change.
  Force start() => new Force._(_proxy.callMethod('start'));

  /// Get or set the layout's cooling parameter.
  alpha([num value = undefinedNum]) {
    var args = [];
    if (value != undefinedNum) {
      args.add(value);
    }
    var retval = _proxy.callMethod('alpha', args);
    if (value == undefinedNum) {
      return retval;
    } else {
      return new Force._(retval);
    }
  }

  /// Reheat the cooling parameter and restart simulation.
  Force resume() => new Force._(_proxy.callMethod('resume'));

  /// Immediately terminate the simulation.
  Force stop() => new Force._(_proxy.callMethod('stop'));

  /// Run the layout simulation one step.
  Force tick() => new Force._(_proxy.callMethod('tick'));

  /// Listen to updates in the computed layout positions.
  Force on(String type, Function listener) {
    return new Force._(_proxy.callMethod('on', [type, listener]));
  }

  /// Bind a behavior to nodes to allow interactive dragging.
  drag() => new Force._(_proxy.callMethod('drag'));
}

/// Derive a custom hierarchical layout implementation.
Hierarchy hierarchy() => new Hierarchy._(_layout.callMethod('hierarchy'));

class Hierarchy {
  final JsObject _proxy;

  Hierarchy._(this._proxy);

  factory Hierarchy() => hierarchy();

  /// Alias for hierarchy.nodes.
  call(root) => _proxy.callMethod('call', [_proxy, root]);

  /// Compute the layout and return the array of nodes.
  List nodes(root) => _proxy.callMethod('nodes', [root]);

  /// Compute the parent-child links between tree nodes.
  List links(nodes) => _proxy.callMethod('links', [nodes]);

  /// Get or set the accessor function for child nodes.
  children([Function accessor = undefinedFn]) {
    var args = [];
    if (accessor != undefinedFn) {
      args.add(accessor);
    }
    var retval = _proxy.callMethod('children', args);
    if (accessor == undefinedFn) {
      return retval;
    } else {
      return new Hierarchy._(retval);
    }
  }

  /// Get or set the comparator function for sibling nodes.
  sort([Function comparator = undefinedFn]) {
    var args = [];
    if (comparator != undefinedFn) {
      args.add(comparator);
    }
    var retval = _proxy.callMethod('sort', args);
    if (comparator == undefinedFn) {
      return retval;
    } else {
      return new Hierarchy._(retval);
    }
  }

  /// Get or set the value accessor function.
  value([Function value = undefinedFn]) {
    var args = [];
    if (value != undefinedFn) {
      args.add(value);
    }
    var retval = _proxy.callMethod('value', args);
    if (value == undefinedFn) {
      return retval;
    } else {
      return new Hierarchy._(retval);
    }
  }

  /// Recompute the hierarchy values.
  revalue(root) => new Hierarchy._(_proxy.callMethod('revalue', [root]));
}

/// Construct a new default histogram layout.
Histogram histogram() => new Histogram._(_layout.callMethod('histogram'));

class Histogram {
  final JsObject _proxy;

  Histogram._(this._proxy);

  factory Histogram() => histogram();

  /// Compute the distribution of data using quantized bins.
  List<List> call(List values, [int index = undefinedInt]) {
    var args = [_proxy, values];
    if (index != undefinedInt) {
      args.add(index);
    }
    return _proxy.callMethod('call', args);
  }

  /// Get or set the value accessor function.
  value([Function accessor = undefinedFn]) {
    var args = [];
    if (accessor != undefinedFn) {
      args.add(accessor);
    }
    var retval = _proxy.callMethod('value', args);
    if (accessor == undefinedFn) {
      return retval;
    } else {
      return new Histogram._(retval);
    }
  }

  /// Get or set the considered value range.
  range([range = undefined]) {
    var args = [];
    if (range is Function) {
      args.add(func4VarArgs(range));
    } else if (range != undefined) {
      args.add(range);
    }
    var retval = _proxy.callMethod('range', args);
    if (range == undefined) {
      return retval;
    } else {
      return new Histogram._(retval);
    }
  }

  /// Specify how values are organized into bins.
  bins([count_thresholds_function = undefined]) {
    var args = [];
    if (count_thresholds_function != undefined) {
      args.add(count_thresholds_function);
    }
    var retval = _proxy.callMethod('bins', args);
    if (count_thresholds_function == undefined) {
      return retval;
    } else {
      return new Histogram._(retval);
    }
  }

  /// Compute the distribution as counts or probabilities.
  frequency([/*bool*/ frequency = undefined]) {
    var args = [];
    if (frequency != undefined) {
      args.add(frequency);
    }
    var retval = _proxy.callMethod('frequency', args);
    if (frequency == undefined) {
      return retval;
    } else {
      return new Histogram._(retval);
    }
  }
}

/// Produce a hierarchical layout using recursive circle-packing.
Pack pack() => new Pack._(_layout.callMethod('pack'));

class Pack {
  final JsObject _proxy;

  Pack._(this._proxy);

  factory Pack() => pack();

  /// Alias for pack.nodes.
  call(root) => new Pack._(_proxy.callMethod('call', [_proxy, root]));

  /// Compute the pack layout and return the array of nodes.
  List nodes(root) => _proxy.callMethod('nodes', [root]);

  /// Compute the parent-child links between tree nodes.
  List links(nodes) => _proxy.callMethod('links', [nodes]);

  /// Get or set the children accessor function.
  children([Function children = undefinedFn]) {
    var args = [];
    if (children != undefinedFn) {
      args.add(children);
    }
    var retval = _proxy.callMethod('children', args);
    if (children == undefinedFn) {
      return retval;
    } else {
      return new Pack._(retval);
    }
  }

  /// Control the order in which sibling nodes are traversed.
  sort([Function comparator = undefinedFn]) {
    var args = [];
    if (comparator != undefinedFn) {
      args.add(comparator);
    }
    var retval = _proxy.callMethod('sort', args);
    if (comparator == undefinedFn) {
      return retval;
    } else {
      return new Pack._(retval);
    }
  }

  /// Get or set the value accessor used to size circles.
  value([Function value = undefinedFn]) {
    var args = [];
    if (value != undefinedFn) {
      args.add(value);
    }
    var retval = _proxy.callMethod('value', args);
    if (value == undefinedFn) {
      return retval;
    } else {
      return new Pack._(retval);
    }
  }

  /// Specify the layout size in x and y.
  size([List size = undefinedList]) {
    var args = [];
    if (size != undefinedList) {
      args.add(size);
    }
    var retval = _proxy.callMethod('size', args);
    if (size == undefinedList) {
      return retval;
    } else {
      return new Pack._(retval);
    }
  }

  /// Specify the node radius, rather than deriving it from value.
  radius([radius = undefined]) {
    var args = [];
    if (radius != undefined) {
      args.add(radius);
    }
    var retval = _proxy.callMethod('radius', args);
    if (radius == undefined) {
      return retval;
    } else {
      return new Pack._(retval);
    }
  }

  /// Specify the layout padding in (approximate) pixels.
  padding([num padding = undefinedNum]) {
    var args = [];
    if (padding != undefinedNum) {
      args.add(padding);
    }
    var retval = _proxy.callMethod('padding', args);
    if (padding == undefinedNum) {
      return retval;
    } else {
      return new Pack._(retval);
    }
  }
}

/// Recursively partition a node tree into a sunburst or icicle.
Partition partition() => new Partition._(_layout.callMethod('partition'));

class Partition {
  final JsObject _proxy;

  Partition._(this._proxy);

  factory Partition() => partition();

  /// Alias for partition.nodes.
  call(root) => _proxy.callMethod('call', [_proxy, root]);

  /// Compute the partition layout and return the array of nodes.
  List nodes(root) => _proxy.callMethod('nodes', [root]);

  /// Compute the parent-child links between tree nodes.
  List links(nodes) => _proxy.callMethod('links', [nodes]);

  /// Get or set the children accessor function.
  children([Function children = undefinedFn]) {
    var args = [];
    if (children != undefinedFn) {
      args.add(children);
    }
    var retval = _proxy.callMethod('children', args);
    if (children == undefinedFn) {
      return retval;
    } else {
      return new Partition._(retval);
    }
  }

  /// Control the order in which sibling nodes are traversed.
  sort([Function comparator = undefinedFn]) {
    var args = [];
    if (comparator != undefinedFn) {
      args.add(comparator);
    }
    var retval = _proxy.callMethod('sort', args);
    if (comparator == undefinedFn) {
      return retval;
    } else {
      return new Partition._(retval);
    }
  }

  /// Get or set the value accessor used to size circles.
  value([Function value = undefinedFn]) {
    var args = [];
    if (value != undefinedFn) {
      args.add(value);
    }
    var retval = _proxy.callMethod('value', args);
    if (value == undefinedFn) {
      return retval;
    } else {
      return new Partition._(retval);
    }
  }

  /// Specify the layout size in x and y.
  size([List size = undefinedList]) {
    var args = [];
    if (size != undefinedList) {
      args.add(size);
    }
    var retval = _proxy.callMethod('size', args);
    if (size == undefinedList) {
      return retval;
    } else {
      return new Partition._(retval);
    }
  }
}

/// Construct a new default pie layout.
Pie pie() => new Pie._(_layout.callMethod('pie'));

class Pie {
  final JsObject _proxy;

  Pie._(this._proxy);

  factory Pie() => pie();

  /// Compute the start and end angles for arcs in a pie or donut chart.
  call(List values, [int index = undefinedInt]) {
    var args = [_proxy, values];
    if (index != undefinedInt) {
      args.add(index);
    }
    return _proxy.callMethod('call', args);
  }

  /// Get or set the value accessor function.
  value([Function accessor = undefinedFn]) {
    var args = [];
    if (accessor != undefinedFn) {
      args.add(accessor);
    }
    var retval = _proxy.callMethod('value', args);
    if (accessor == undefinedFn) {
      return retval;
    } else {
      return new Pie._(retval);
    }
  }

  /// Control the clockwise order of pie slices.
  sort([Function comparator = undefinedFn]) {
    var args = [];
    if (comparator != undefinedFn) {
      args.add(comparator);
    }
    var retval = _proxy.callMethod('sort', args);
    if (comparator == undefinedFn) {
      return retval;
    } else {
      return new Pie._(retval);
    }
  }

  /// Get or set the overall start angle of the pie.
  startAngle([angle = undefined]) {
    var args = [];
    if (angle is Function) {
      args.add(func4VarArgs(angle));
    } else if (angle != undefined) {
      args.add(angle);
    }
    var retval = _proxy.callMethod('startAngle', args);
    if (angle == undefined) {
      return retval;
    } else {
      return new Pie._(retval);
    }
  }

  /// Get or set the overall end angle of the pie.
  endAngle([angle = undefined]) {
    var args = [];
    if (angle is Function) {
      args.add(func4VarArgs(angle));
    } else if (angle != undefined) {
      args.add(angle);
    }
    var retval = _proxy.callMethod('endAngle', args);
    if (angle == undefined) {
      return retval;
    } else {
      return new Pie._(retval);
    }
  }

  /// Get or set the pad angle of the pie.
  padAngle([angle = undefined]) {
    var args = [];
    if (angle is Function) {
      args.add(func4VarArgs(angle));
    } else if (angle != undefined) {
      args.add(angle);
    }
    var retval = _proxy.callMethod('padAngle', args);
    if (angle == undefined) {
      return retval;
    } else {
      return new Pie._(retval);
    }
  }
}

/// Construct a new default stack layout.
Stack stack() => new Stack._(_layout.callMethod('stack'));

class Stack {
  final JsObject _proxy;

  Stack._(this._proxy);

  factory Stack() => stack();

  /// Compute the baseline for each series in a stacked bar or area chart.
  call(List layers, [int index = undefinedInt]) {
    var args = [_proxy, values];
    if (index != undefinedInt) {
      args.add(index);
    }
    return _proxy.callMethod('call', args);
  }

  /// Get or set the values accessor function per series.
  values([Function accessor = undefinedFn]) {
    var args = [];
    if (accessor != undefinedFn) {
      args.add(accessor);
    }
    var retval = _proxy.callMethod('values', args);
    if (accessor == undefinedFn) {
      return retval;
    } else {
      return new Stack._(retval);
    }
  }

  /// Specify the overall baseline algorithm.
  offset([String offset = undefinedString]) {
    var args = [];
    if (offset != undefinedString) {
      args.add(offset);
    }
    var retval = _proxy.callMethod('offset', args);
    if (offset == undefinedString) {
      return retval;
    } else {
      return new Stack._(retval);
    }
  }

  /// Control the order in which series are stacked.
  order([String order = undefinedString]) {
    var args = [];
    if (order != undefinedString) {
      args.add(order);
    }
    var retval = _proxy.callMethod('order', args);
    if (order == undefinedString) {
      return retval;
    } else {
      return new Stack._(retval);
    }
  }

  /// Get or set the x-dimension accessor function.
  x([Function accessor = undefinedFn]) {
    var args = [];
    if (accessor != undefinedFn) {
      args.add(accessor);
    }
    var retval = _proxy.callMethod('x', args);
    if (accessor == undefinedFn) {
      return retval;
    } else {
      return new Stack._(retval);
    }
  }

  /// Get or set the y-dimension accessor function.
  y([Function accessor = undefinedFn]) {
    var args = [];
    if (accessor != undefinedFn) {
      args.add(accessor);
    }
    var retval = _proxy.callMethod('y', args);
    if (accessor == undefinedFn) {
      return retval;
    } else {
      return new Stack._(retval);
    }
  }

  /// Get or set the output function for storing the baseline.
  out([Function setter = undefinedFn]) {
    var args = [];
    if (setter != undefinedFn) {
      args.add(setter);
    }
    var retval = _proxy.callMethod('out', args);
    if (setter == undefinedFn) {
      return retval;
    } else {
      return new Stack._(retval);
    }
  }
}

/// Position a tree of nodes tidily.
Tree tree() => new Tree._(_layout.callMethod('tree'));

class Tree {
  final JsObject _proxy;

  Tree._(this._proxy);

  factory Tree() => tree();

  /// Alias for tree.nodes.
  call(root) => _proxy.callMethod('call', [_proxy, root]);

  /// Compute the tree layout and return the array of nodes.
  List nodes(root) => _proxy.callMethod('nodes', [root]);

  /// Compute the parent-child links between tree nodes.
  List links(nodes) => _proxy.callMethod('links', [nodes]);

  /// Get or set the children accessor function.
  children([Function children = undefinedFn]) {
    var args = [];
    if (children != undefinedFn) {
      args.add(children);
    }
    var retval = _proxy.callMethod('children', args);
    if (children == undefinedFn) {
      return retval;
    } else {
      return new Tree._(retval);
    }
  }

  /// Get or set the spacing function between neighboring nodes.
  separation([Function separation = undefinedFn]) {
    var args = [];
    if (separation != undefinedFn) {
      args.add(separation);
    }
    var retval = _proxy.callMethod('separation', args);
    if (separation == undefinedFn) {
      return retval;
    } else {
      return new Tree._(retval);
    }
  }

  /// Specify the layout size in x and y.
  size([List size = undefinedList]) {
    var args = [];
    if (size != undefinedList) {
      args.add(size);
    }
    var retval = _proxy.callMethod('size', args);
    if (size == undefinedList) {
      return retval;
    } else {
      return new Tree._(retval);
    }
  }

  /// Specify a fixed size for each node.
  nodeSize([List nodeSize = undefinedList]) {
    var args = [];
    if (nodeSize != undefinedList) {
      args.add(nodeSize);
    }
    var retval = _proxy.callMethod('nodeSize', args);
    if (nodeSize == undefinedList) {
      return retval;
    } else {
      return new Tree._(retval);
    }
  }

  /// Control the order in which sibling nodes are traversed.
  sort([Function comparator = undefinedFn]) {
    var args = [];
    if (comparator != undefinedFn) {
      args.add(comparator);
    }
    var retval = _proxy.callMethod('sort', args);
    if (comparator == undefinedFn) {
      return retval;
    } else {
      return new Tree._(retval);
    }
  }

  value([Function value = undefinedFn]) {
    var args = [];
    if (value != undefinedFn) {
      args.add(value);
    }
    var retval = _proxy.callMethod('value', args);
    if (value == undefinedFn) {
      return retval;
    } else {
      return new Tree._(retval);
    }
  }
}

/// Use recursive spatial subdivision to display a tree of nodes.
Treemap treemap() => new Treemap._(_layout.callMethod('treemap'));

class Treemap {
  final JsObject _proxy;

  Treemap._(this._proxy);

  factory Treemap() => treemap();

  /// Alias for treemap.nodes.
  call(root) => _proxy.callMethod('call', [_proxy, root]);

  /// Compute the treemap layout and return the array of nodes.
  List nodes(root) => _proxy.callMethod('nodes', [root]);

  /// Compute the parent-child links between tree nodes.
  List links(nodes) => _proxy.callMethod('links', [nodes]);

  /// Get or set the children accessor function.
  children([Function children = undefinedFn]) {
    var args = [];
    if (children != undefinedFn) {
      args.add(children);
    }
    var retval = _proxy.callMethod('children', args);
    if (children == undefinedFn) {
      return retval;
    } else {
      return new Treemap._(retval);
    }
  }

  /// Control the order in which sibling nodes are traversed.
  sort([Function comparator = undefinedFn]) {
    var args = [];
    if (comparator != undefinedFn) {
      args.add(comparator);
    }
    var retval = _proxy.callMethod('sort', args);
    if (comparator == undefinedFn) {
      return retval;
    } else {
      return new Treemap._(retval);
    }
  }

  /// Get or set the value accessor used to size treemap cells.
  value([Function value = undefinedFn]) {
    var args = [];
    if (value != undefinedFn) {
      args.add(value);
    }
    var retval = _proxy.callMethod('value', args);
    if (value == undefinedFn) {
      return retval;
    } else {
      return new Treemap._(retval);
    }
  }

  /// Specify the layout size in x and y.
  size([List size = undefinedList]) {
    var args = [];
    if (size != undefinedList) {
      args.add(size);
    }
    var retval = _proxy.callMethod('size', args);
    if (size == undefinedList) {
      return retval;
    } else {
      return new Treemap._(retval);
    }
  }

  /// Specify the padding between a parent and its children.
  padding([padding = undefined]) {
    var args = [];
    if (padding != undefined) {
      args.add(padding);
    }
    var retval = _proxy.callMethod('padding', args);
    if (padding == undefined) {
      return retval;
    } else {
      return new Treemap._(retval);
    }
  }

  /// Enable or disable rounding to exact pixels.
  round([/*bool*/ round = undefined]) {
    var args = [];
    if (round != undefined) {
      args.add(round);
    }
    var retval = _proxy.callMethod('round', args);
    if (round == undefined) {
      return retval;
    } else {
      return new Treemap._(retval);
    }
  }

  /// Make the layout sticky for stable updates.
  sticky([/*bool*/ sticky = undefined]) {
    var args = [];
    if (sticky != undefined) {
      args.add(sticky);
    }
    var retval = _proxy.callMethod('sticky', args);
    if (sticky == undefined) {
      return retval;
    } else {
      return new Treemap._(retval);
    }
  }

  /// Change the treemap layout algorithm.
  mode([String mode = undefinedString]) {
    var args = [];
    if (mode != undefinedString) {
      args.add(mode);
    }
    var retval = _proxy.callMethod('mode', args);
    if (mode == undefinedString) {
      return retval;
    } else {
      return new Treemap._(retval);
    }
  }

  ratio([num ratio = undefinedNum]) {
    var args = [];
    if (ratio != undefinedNum) {
      args.add(ratio);
    }
    var retval = _proxy.callMethod('ratio', args);
    if (ratio == undefinedNum) {
      return retval;
    } else {
      return new Treemap._(retval);
    }
  }
}
