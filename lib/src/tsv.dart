@JS('d3.tsv')
library d3.src.tsv;

import 'package:js/js.dart';

/// Request a tab-separated values (TSV) file.
@JS('d3.tsv')
external tsv(url, [accessor, callback]);

/// Parse a TSV string into objects using the header row.
external parse(string, [accessor]);

/// Parse a TSV string into tuples, ignoring the header row.
external parseRows(string, [accessor]);

/// Format an array of objects into a TSV string.
external format(rows);

/// Format an array of tuples into a TSV string.
external formatRows(rows);
