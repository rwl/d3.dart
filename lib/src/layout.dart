@JS('d3.layout')
library d3.src.layout;

import 'package:js/js.dart';

external Bundle bundle();

@JS()
class Bundle {
  external bundle(links);
}

external Chord chord();

@JS()
class Chord {
  external matrix([matrix]);
  external padding([padding]);
  external sortGroups([comparator]);
  external sortSubgroups([comparator]);
  external sortChords([comparator]);
  external chords();
  external groups();
}

external Cluster cluster();

@JS()
class Cluster {
  external cluster(root);
  external nodes(root);
  external links(nodes);
  external children([children]);
  external sort([comparator]);
  external separation([separation]);
  external size([size]);
  external nodeSize([nodeSize]);
  external value([value]);
}

external Force force();

@JS()
class Force {
  external size([width, height]);
  external linkDistance([distance]);
  external linkStrength([strength]);
  external friction([friction]);
  external charge([charge]);
  external chargeDistance([distance]);
  external theta([theta]);
  external gravity([gravity]);
  external nodes([nodes]);
  external links([links]);
  external start();
  external alpha([value]);
  external resume();
  external stop();
  external tick();
  external drag();
}

external Hierarchy hierarchy();

@JS()
class Hierarchy {
  external hierarchy(root);
  external links(nodes);
  external children([accessor]);
  external sort([comparator]);
  external value([value]);
  external revalue(root);
}

external Histogram histogram();

@JS()
class Histogram {
  external histogram(values, [index]);
  external value([accessor]);
  external range([range]);
  external bins([count_or_thresholds_or_function]);
  external frequency([frequency]);
}

external Pack pack();

@JS()
class Pack {
  external pack(root);
  external nodes(root);
  external links(nodes);
  external children([children]);
  external sort([comparator]);
  external value([value]);
  external size([size]);
  external radius([radius]);
  external padding([padding]);
}

external Partition partition();

@JS()
class Partition {
  external partition(root);
  external nodes(root);
  external links(nodes);
  external children([children]);
  external sort([comparator]);
  external value([value]);
  external size([size]);
}

external Pie pie();

@JS()
class Pie {
  external pie(values, [index]);
  external value([accessor]);
  external sort([comparator]);
  external startAngle([angle]);
  external endAngle([angle]);
  external padAngle([angle]);
}

external Stack stack();

@JS()
class Stack {
  external stack(layers, [index]);
  external values([accessor]);
  external offset([offset]);
  external order([order]);
  external x([accessor]);
  external y([accessor]);
  external out([setter]);
}

external Tree tree();

@JS()
class Tree {
  external tree(root);
  external nodes(root);
  external links(nodes);
  external children([children]);
  external separation([separation]);
  external size([size]);
  external nodeSize([nodeSize]);
  external sort([comparator]);
  external value([value]);
}

external Treemap treemap();

@JS()
class Treemap {
  external treemap(root);
  external nodes(root);
  external links(nodes);
  external children([children]);
  external sort([comparator]);
  external value([value]);
  external size([size]);
  external padding([padding]);
  external round([round]);
  external sticky([sticky]);
  external mode([mode]);
  external ratio([ratio]);
}
