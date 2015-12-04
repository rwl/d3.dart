@JS('d3.tsv')
library d3.src.tsv;

import 'package:js/js.dart';

/// request a tab-separated values (TSV) file.
@JS('d3.tsv')
external tsv(url, [accessor, callback]);

/// parse a TSV string into objects using the header row.
external parse(string, [accessor]);

/// parse a TSV string into tuples, ignoring the header row.
external parseRows(string, [accessor]);

/// format an array of objects into a TSV string.
external format(rows);

/// format an array of tuples into a TSV string.
external formatRows(rows);
