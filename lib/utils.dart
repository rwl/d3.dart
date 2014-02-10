library d3.utils;

import 'package:intl/intl.dart';

typedef FnWith0Args();
typedef FnWith1Args(a0);
typedef FnWith2Args(a0, a1);
typedef FnWith3Args(a0, a1, a2);
typedef FnWith4Args(a0, a1, a2, a3);


FnWith4Args relaxFn4Args(Function fn) {
  if (fn is FnWith4Args) {
    return (a0, a1, a2, a3) => fn(a0, a1, a2, a3);
  } else if (fn is FnWith3Args) {
    return (a0, a1, a2, a3) => fn(a0, a1, a2);
  } else if (fn is FnWith2Args) {
    return (a0, a1, a2, a3) => fn(a0, a1);
  } else if (fn is FnWith1Args) {
    return (a0, a1, a2, a3) => fn(a0);
  } else if (fn is FnWith0Args) {
    return (a0, a1, a2, a3) => fn();
  } else {
    return (a0, a1, a2, a3) {
      throw "Unknown function type, expecting 0 to 4 args.";
    };
  }
}

/*FnWith3Args relaxFn3Args(Function fn) {
  if (fn is FnWith3Args) {
    return fn;
  } else if (fn is FnWith2Args) {
    return (a0, a1, a2) => fn(a0, a1);
  } else if (fn is FnWith1Args) {
    return (a0, a1, a2) => fn(a0);
  } else if (fn is FnWith0Args) {
    return (a0, a1, a2) => fn();
  } else {
    return (a0, a1, a2) {
      throw "Unknown function type, expecting 0 to 3 args.";
    };
  }
}*/

toDouble(x) {
  if (x is int) {
    return x.toDouble();
  } else if (x is double) {
    return x;
  } else if (x is String) {
    return double.parse(x, (source) => double.NAN);
  } else if (x is DateTime) {
    return x.millisecondsSinceEpoch;
  }
  return double.NAN;//x.toDouble();
}

const pattern = "#.###";

final formatter = new NumberFormat(pattern);

String fmt(num x) {
  return formatter.format(x);
}
