# D3.dart

A [Dart](https://www.dartlang.org/) API for [D3.js](http://d3js.org/)
using `dart:js`.

## Usage

```dart
var data = [4, 8, 15, 16, 23, 42];

var x = new LinearScale<num>()
  ..domain = [0, max(data)]
  ..range = [0, 420];

new Selection('.chart').selectAll('div').data(data).enter().append("div")
  ..styleFn["width"] = ((d) => "${x(d)}px")
  ..textFn = (d) => d;
```