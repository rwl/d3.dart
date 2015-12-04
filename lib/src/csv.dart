@JS('d3.csv')
library d3.src.csv;

import 'package:js/js.dart';

@JS('d3.csv')
external csv(url, [accessor, callback]);

external parse(string, [accessor]);
external parseRows(string, [accessor]);
external format(rows);
external formatRows(rows);
