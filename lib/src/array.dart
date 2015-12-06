library d3.src.array;

import 'dart:js';
import 'd3.dart';

JsObject _d3 = context['d3'];

/// Compare two values for sorting.
ascending(a, b) => _d3.callMethod('ascending', [a, b]);

/// Compare two values for sorting.
descending(a, b) => _d3.callMethod('descending', [a, b]);

/// Find the minimum value in an array.
min(array, [accessor(v) = undefined]) {
  var args = [array];
  if (accessor != undefined) {
    args.add(accessor);
  }
  return _d3.callMethod('min', args);
}

/// Find the maximum value in an array.
max(array, [accessor = undefined]) {
  var args = [array];
  if (accessor != undefined) {
    args.add(accessor);
  }
  return _d3.callMethod('max', args);
}

/// Find the minimum and maximum value in an array.
extent(array, [accessor]) {
  return _d3.callMethod('extent', []);
}

/// Compute the sum of an array of numbers.
sum(array, [accessor]) {
  return _d3.callMethod('sum', []);
}

/// Compute the arithmetic mean of an array of numbers.
mean(array, [accessor]) {
  return _d3.callMethod('mean', []);
}

/// Compute the median of an array of numbers (the 0.5-quantile).
median(array, [accessor]) {
  return _d3.callMethod('median', []);
}

/// Compute a quantile for a sorted array of numbers.
quantile(numbers, p) {
  return _d3.callMethod('quantile', []);
}

/// Compute the variance of an array of numbers.
variance(array, [accessor]) {
  return _d3.callMethod('variance', []);
}

/// Compute the standard deviation of an array of numbers.
deviation(array, [accessor]) {
  return _d3.callMethod('deviation', []);
}

/// Search for a value in a sorted array.
bisectLeft(array, x, [lo, hi]) {
  return _d3.callMethod('bisectLeft', []);
}

/// Search for a value in a sorted array.
bisect(array, x, [lo, hi]) {
  return _d3.callMethod('bisect', []);
}

/// Search for a value in a sorted array.
bisectRight(array, x, [lo, hi]) {
  return _d3.callMethod('bisectRight', []);
}

/// Bisect using an accessor or comparator.
bisector(accessor) {
  return _d3.callMethod('bisector', []);
}

/// Randomize the order of an array.
shuffle(array, [lo, hi]) {
  return _d3.callMethod('shuffle', []);
}

/// List the keys of an associative array.
keys(object) {
  return _d3.callMethod('keys', []);
}

/// List the values of an associated array.
values(object) {
  return _d3.callMethod('values', []);
}

/// List the key-value entries of an associative array.
entries(object) {
  return _d3.callMethod('entries', []);
}

/// Merge multiple arrays into one array.
merge(arrays) {
  return _d3.callMethod('merge', []);
}

/// Generate a range of numeric values.
range([start, stop, step]) {
  return _d3.callMethod('range', []);
}

/// Reorder an array of elements according to an array of indexes.
permute(array, indexes) {
  return _d3.callMethod('permute', []);
}

/// Transpose a variable number of arrays.
zip(arrays) {
  return _d3.callMethod('zip', []);
}

/// Transpose an array of arrays.
transpose(matrix) {
  return _d3.callMethod('transpose', []);
}

/// Returns an array of adjacent pairs of elements.
pairs(array) {
  return _d3.callMethod('pairs', []);
}

/// Group array elements hierarchically.
Nest nest() {
  return _d3.callMethod('nest', []);
}

class Nest {
  final JsObject _proxy;

  Nest._(this._proxy);

  /// Add a level to the nest hierarchy.
  key(function) {
    return _proxy.callMethod('key', []);
  }

  /// Sort the current nest level by key.
  sortKeys(comparator) {
    return _proxy.callMethod('sortKeys', []);
  }

  /// Sort the leaf nest level by value.
  sortValues(comparator) {
    return _proxy.callMethod('sortValues', []);
  }

  /// Specify a rollup function for leaf values.
  rollup(function) {
    return _proxy.callMethod('rollup', []);
  }

  /// Evaluate the nest operator, returning an associative array.
  map(array, [mapType]) {
    return _proxy.callMethod('map', []);
  }

  /// Evaluate the nest operator, returning an array of key-values tuples.
  entries(array) {
    return _proxy.callMethod('entries', []);
  }
}
/*
D3Map map([object, key]) {
  return _d3.callMethod('map', []);
}

class D3Map {
  final JsObject _proxy;

  has(key) {
    return _proxy.callMethod('', []);
  }

  get(key) {
    return _proxy.callMethod('', []);
  }

  set(key, value) {
    return _proxy.callMethod('', []);
  }

  remove(key) {
    return _proxy.callMethod('', []);
  }

  keys() {
    return _proxy.callMethod('', []);
  }

  values() {
    return _proxy.callMethod('', []);
  }

  entries() {
    return _proxy.callMethod('', []);
  }

  forEach(function) {
    return _proxy.callMethod('', []);
  }

  bool empty() {
    return _proxy.callMethod('', []);
  }

  int size() {
    return _proxy.callMethod('', []);
  }
}

D3Set set([array]) {
  return _d3.callMethod('', []);
}

class D3Set {
  final JsObject _proxy;

  has(value) {
    return _proxy.callMethod('', []);
  }

  add(value) {
    return _proxy.callMethod('', []);
  }

  remove(value) {
    return _proxy.callMethod('', []);
  }

  values() {
    return _proxy.callMethod('', []);
  }

  forEach(function) {
    return _proxy.callMethod('', []);
  }

  bool empty() {
    return _proxy.callMethod('', []);
  }

  int size() {
    return _proxy.callMethod('', []);
  }
}
*/
