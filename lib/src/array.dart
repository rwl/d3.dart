@JS('d3')
library d3.src.array;

import 'package:js/js.dart';

/// compare two values for sorting.
external ascending(a, b);

/// compare two values for sorting.
external descending(a, b);

/// find the minimum value in an array.
external min(array, [accessor]);

/// find the maximum value in an array.
external max(array, [accessor]);

/// find the minimum and maximum value in an array.
external extent(array, [accessor]);

/// compute the sum of an array of numbers.
external sum(array, [accessor]);

/// compute the arithmetic mean of an array of numbers.
external mean(array, [accessor]);

/// compute the median of an array of numbers (the 0.5-quantile).
external median(array, [accessor]);

/// compute a quantile for a sorted array of numbers.
external quantile(numbers, p);

/// compute the variance of an array of numbers.
external variance(array, [accessor]);

/// compute the standard deviation of an array of numbers.
external deviation(array, [accessor]);

/// search for a value in a sorted array.
external bisectLeft(array, x, [lo, hi]);

/// search for a value in a sorted array.
external bisect(array, x, [lo, hi]);

/// search for a value in a sorted array.
external bisectRight(array, x, [lo, hi]);

/// bisect using an accessor or comparator.
external bisector(accessor);

/// randomize the order of an array.
external shuffle(array, [lo, hi]);

/// list the keys of an associative array.
external keys(object);

/// list the values of an associated array.
external values(object);

/// list the key-value entries of an associative array.
external entries(object);

/// merge multiple arrays into one array.
external merge(arrays);

/// generate a range of numeric values.
external range([start, stop, step]);

/// reorder an array of elements according to an array of indexes.
external permute(array, indexes);

/// transpose a variable number of arrays.
external zip(arrays);

/// transpose an array of arrays.
external transpose(matrix);

/// returns an array of adjacent pairs of elements.
external pairs(array);

/// group array elements hierarchically.
external Nest nest();

@JS()
class Nest {
  /// add a level to the nest hierarchy.
  external key(function);

  /// sort the current nest level by key.
  external sortKeys(comparator);

  /// sort the leaf nest level by value.
  external sortValues(comparator);

  /// specify a rollup function for leaf values.
  external rollup(function);

  /// evaluate the nest operator, returning an associative array.
  external map(array, [mapType]);

  /// evaluate the nest operator, returning an array of key-values tuples.
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
