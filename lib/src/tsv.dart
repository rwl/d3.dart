@JS('d3')
library d3.src.tsv;

import 'package:js/js.dart';

/// Request a tab-separated values (TSV) file.
@JS('d3')
external tsv(url, [accessor, callback]);

/// Parse a TSV string into objects using the header row.
@JS('d3.tsv.parse')
external parse(string, [accessor]);

/// Parse a TSV string into tuples, ignoring the header row.
@JS('d3.tsv.parseRows')
external parseRows(string, [accessor]);

/// Format an array of objects into a TSV string.
@JS('d3.tsv.format')
external format(rows);

/// Format an array of tuples into a TSV string.
@JS('d3.tsv.formatRows')
external formatRows(rows);
