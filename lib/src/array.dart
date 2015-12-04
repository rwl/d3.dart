@JS('d3')
library d3.src.array;

import 'package:js/js.dart';

/// Compare two values for sorting.
external ascending(a, b);

/// Compare two values for sorting.
external descending(a, b);

/// Find the minimum value in an array.
external min(array, [accessor]);

/// Find the maximum value in an array.
external max(array, [accessor]);

/// Find the minimum and maximum value in an array.
external extent(array, [accessor]);

/// Compute the sum of an array of numbers.
external sum(array, [accessor]);

/// Compute the arithmetic mean of an array of numbers.
external mean(array, [accessor]);

/// Compute the median of an array of numbers (the 0.5-quantile).
external median(array, [accessor]);

/// Compute a quantile for a sorted array of numbers.
external quantile(numbers, p);

/// Compute the variance of an array of numbers.
external variance(array, [accessor]);

/// Compute the standard deviation of an array of numbers.
external deviation(array, [accessor]);

/// Search for a value in a sorted array.
external bisectLeft(array, x, [lo, hi]);

/// Search for a value in a sorted array.
external bisect(array, x, [lo, hi]);

/// Search for a value in a sorted array.
external bisectRight(array, x, [lo, hi]);

/// Bisect using an accessor or comparator.
external bisector(accessor);

/// Randomize the order of an array.
external shuffle(array, [lo, hi]);

/// List the keys of an associative array.
external keys(object);

/// List the values of an associated array.
external values(object);

/// List the key-value entries of an associative array.
external entries(object);

/// Merge multiple arrays into one array.
external merge(arrays);

/// Generate a range of numeric values.
external range([start, stop, step]);

/// Reorder an array of elements according to an array of indexes.
external permute(array, indexes);

/// Transpose a variable number of arrays.
external zip(arrays);

/// Transpose an array of arrays.
external transpose(matrix);

/// Returns an array of adjacent pairs of elements.
external pairs(array);

/// Group array elements hierarchically.
external Nest nest();

@JS()
class Nest {
  /// Add a level to the nest hierarchy.
  external key(function);

  /// Sort the current nest level by key.
  external sortKeys(comparator);

  /// Sort the leaf nest level by value.
  external sortValues(comparator);

  /// Specify a rollup function for leaf values.
  external rollup(function);

  /// Evaluate the nest operator, returning an associative array.
  external map(array, [mapType]);

  /// Evaluate the nest operator, returning an array of key-values tuples.
  external entries(array);
}

external D3Map map([object, key]);

@JS()
class D3Map {
  external has(key);
  external get(key);
  external set(key, value);
  external remove(key);
  external keys();
  external values();
  external entries();
  external forEach(function);
  external bool empty();
  external int size();
}

external D3Set set([array]);

@JS()
class D3Set {
  external has(value);
  external add(value);
  external remove(value);
  external values();
  external forEach(function);
  external bool empty();
  external int size();
}
