@JS('d3.csv')
library d3.src.csv;

import 'package:js/js.dart';

/// request a comma-separated values (CSV) file.
@JS('d3.csv')
external csv(url, [accessor, callback]);

/// parse a CSV string into objects using the header row.
external parse(string, [accessor]);

/// parse a CSV string into tuples, ignoring the header row.
external parseRows(string, [accessor]);

/// format an array of objects into a CSV string.
external format(rows);

/// format an array of tuples into a CSV string.
external formatRows(rows);
