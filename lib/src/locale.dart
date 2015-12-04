@JS('d3')
library d3.src.locale;

import 'package:js/js.dart';

external Locale locale(definition);

class Locale {
  external numberFormat(specifier);
  external timeFormat(specifier);
  @JS('utc.timeFormat')
  external timeFormatUtc(specifier);
}
