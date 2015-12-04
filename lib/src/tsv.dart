@JS('d3.tsv')
library d3.src.tsv;

import 'package:js/js.dart';

@JS('d3.tsv')
external tsv(url, [accessor, callback]);

external parse(string, [accessor]);
external parseRows(string, [accessor]);
external format(rows);
external formatRows(rows);
