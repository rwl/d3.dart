@JS('d3')
library d3.src.locale;

import 'package:js/js.dart';

/// Create a new locale using the specified strings.
external Locale locale(definition);

@JS()
class Locale {
  /// Create a new number formatter.
  external numberFormat(specifier);

  /// Create a new time formatter / parser.
  external timeFormat(specifier);

  @JS('utc.timeFormat')
  external timeFormatUtc(specifier);
}
