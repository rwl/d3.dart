@JS('d3')
library d3.src.array;

import 'package:js/js.dart';

external ascending(a, b);
external descending(a, b);
external min(array, [accessor]);
external max(array, [accessor]);
external extent(array, [accessor]);
external sum(array, [accessor]);
external mean(array, [accessor]);
external median(array, [accessor]);
external quantile(numbers, p);
external variance(array, [accessor]);
external deviation(array, [accessor]);
external bisectLeft(array, x, [lo, hi]);
external bisect(array, x, [lo, hi]);
external bisectRight(array, x, [lo, hi]);
external bisector(accessor);
external shuffle(array, [lo, hi]);
external keys(object);
external values(object);
external entries(object);

external D3Map map([object, key]);

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

class D3Set {
  external has(value);
  external add(value);
  external remove(value);
  external values();
  external forEach(function);
  external bool empty();
  external int size();
}

external merge(arrays);
external range([start, stop, step]);
external permute(array, indexes);
external zip(arrays);
external transpose(matrix);
external pairs(array);

external Nest nest();

class Nest {
  external key(function);
  external sortKeys(comparator);
  external sortValues(comparator);
  external rollup(function);
  external map(array, [mapType]);
  external entries(array);
}
