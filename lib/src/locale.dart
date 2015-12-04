@JS('d3')
library d3.src.locale;

import 'package:js/js.dart';

/// create a new locale using the specified strings.
external Locale locale(definition);

@JS()
class Locale {
  /// create a new number formatter.
  external numberFormat(specifier);

  /// create a new time formatter / parser.
  external timeFormat(specifier);

  @JS('utc.timeFormat')
  external timeFormatUtc(specifier);
}
