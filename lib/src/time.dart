library d3.src.time;

import 'dart:js';

JsObject _time = context['d3']['time'];

/// Create a new local time formatter for a given specifier.
Format format(specifier) {
  return _time.callMethod('format', []);
}

class Format {
  final JsObject _proxy;

  Format._(this._proxy);

  call(date) => format(date);

  /// Format a date into a string.
  format(date) {
    return _proxy.callMethod('format', []);
  }

  /// Parse a string into a date.
  parse(string) {
    return _proxy.callMethod('parse', []);
  }
}

/// Create a new local multi-resolution time formatter.
multi(formats) {
  return _time['format'].callMethod('multi', []);
}

/// Create a new UTC time formatter for a given specifier.
utcFormat(specifier) {
  return _time['format'].callMethod('utc', []);
}

/// The ISO 8601 UTC time formatter.
Format get iso {
  return _time['format'].callMethod('iso', []);
}

/// Construct a linear time scale.
TimeScale scale() {
  return _time.callMethod('scale', []);
}

TimeScale utcScale() {
  return _time['scale'].callMethod('utc', []);
}

class TimeScale {
  final JsObject _proxy;

  TimeScale._(this._proxy);

  call(x) => scale(x);

  /// Get the range value corresponding to a given domain value.
  scale(x) {
    return _proxy.callMethod('scale', []);
  }

  /// Get the domain value corresponding to a given range value.
  invert(y) {
    return _proxy.callMethod('invert', []);
  }

  /// Get or set the scale's input domain.
  domain([dates]) {
    return _proxy.callMethod('domain', []);
  }

  /// Extend the scale domain to nice round numbers.
  nice([interval_or_count, step]) {
    return _proxy.callMethod('nice', []);
  }

  /// Get or set the scale's output range.
  range([values]) {
    return _proxy.callMethod('range', []);
  }

  /// Set the scale's output range, and enable rounding.
  rangeRound([values]) {
    return _proxy.callMethod('rangeRound', []);
  }

  /// Get or set the scale's output interpolator.
  interpolate([factory]) {
    return _proxy.callMethod('interpolate', []);
  }

  /// Enable or disable clamping of the output range.
  clamp([boolean]) {
    return _proxy.callMethod('clamp', []);
  }

  /// Get representative values from the input domain.
  ticks([interval_or_count, step]) {
    return _proxy.callMethod('ticks', []);
  }

  /// Get a formatter for displaying tick values.
  tickFormat() {
    return _proxy.callMethod('tickFormat', []);
  }

  /// Create a new scale from an existing scale.
  copy() {
    return _proxy.callMethod('copy', []);
  }
}

/// A time interval in local time.
Interval interval() {
  return _time.callMethod('interval', []);
}

class Interval {
  final JsObject _proxy;

  Interval._(this._proxy);

  call(date) => interval(date);

  /// Alias for interval.floor.
  interval(date) {
    return _proxy.callMethod('interval', []);
  }

  /// Rounds down to the nearest interval.
  floor(date) {
    return _proxy.callMethod('floor', []);
  }

  /// Rounds up or down to the nearest interval.
  round(date) {
    return _proxy.callMethod('round', []);
  }

  /// Rounds up to the nearest interval.
  ceil(date) {
    return _proxy.callMethod('ceil', []);
  }

  /// Returns dates within the specified range.
  range(start, stop, [step]) {
    return _proxy.callMethod('range', []);
  }

  /// Returns a date offset by some interval.
  offset(date, step) {
    return _proxy.callMethod('offset', []);
  }

  /// Returns the UTC-equivalent time interval.
  get utc {
    return _proxy['utc'];
  }
}

/// Every second (e.g., 1:02:03 AM).
Interval get second {
  return _time['second'];
}

/// Every minute (e.g., 1:02 AM).
Interval get minute {
  return _time['minute'];
}

/// Every hour (e.g., 1:00 AM).
Interval get hour {
  return _time['hour'];
}

/// Every day (12:00 AM).
Interval get day {
  return _time['day'];
}

/// Alias for sunday.
Interval get week {
  return _time['week'];
}

/// Every Sunday (e.g., February 5, 12:00 AM).
Interval get sunday {
  return _time['sunday'];
}

/// Every Monday (e.g., February 5, 12:00 AM).
Interval get monday {
  return _time['monday'];
}

/// Every Tuesday (e.g., February 5, 12:00 AM).
Interval get tuesday {
  return _time['tuesday'];
}

/// Every Wednesday (e.g., February 5, 12:00 AM).
Interval get wednesday {
  return _time['wednesday'];
}

/// Every Thursday (e.g., February 5, 12:00 AM).
Interval get thursday {
  return _time['thursday'];
}

/// Every Friday (e.g., February 5, 12:00 AM).
Interval get friday {
  return _time['friday'];
}

/// Every Saturday (e.g., February 5, 12:00 AM).
Interval get saturday {
  return _time['saturday'];
}

/// Every month (e.g., February 1, 12:00 AM).
Interval get month {
  return _time['month'];
}

/// Every year (e.g., January 1, 12:00 AM).
Interval get year {
  return _time['year'];
}

/// Alias for second.range.
seconds(start, stop, [step]) {
  return _time.callMethod('seconds', []);
}

/// Alias for minute.range.
minutes(start, stop, [step]) {
  return _time.callMethod('minutes', []);
}

/// Alias for hour.range.
hours(start, stop, [step]) {
  return _time.callMethod('hours', []);
}

/// Alias for day.range.
days(start, stop, [step]) {
  return _time.callMethod('days', []);
}

/// Alias for sunday.range.
weeks(start, stop, [step]) {
  return _time.callMethod('weeks', []);
}

/// Alias for sunday.range.
sundays(start, stop, [step]) {
  return _time.callMethod('sundays', []);
}

/// Alias for monday.range.
mondays(start, stop, [step]) {
  return _time.callMethod('mondays', []);
}

/// Alias for tuesday.range.
tuesdays(start, stop, [step]) {
  return _time.callMethod('tuesdays', []);
}

/// Alias for wednesday.range.
wednesdays(start, stop, [step]) {
  return _time.callMethod('wednesdays', []);
}

/// Alias for thursday.range.
thursdays(start, stop, [step]) {
  return _time.callMethod('thursdays', []);
}

/// Alias for friday.range.
fridays(start, stop, [step]) {
  return _time.callMethod('fridays', []);
}

/// Alias for saturday.range.
saturdays(start, stop, [step]) {
  return _time.callMethod('saturdays', []);
}

/// Alias for month.range.
months(start, stop, [step]) {
  return _time.callMethod('months', []);
}

/// Alias for year.range.
years(start, stop, [step]) {
  return _time.callMethod('years', []);
}

/// Computes the day number.
dayOfYear(date) {
  return _time.callMethod('dayOfYear', []);
}

/// Alias for sundayOfYear.
weekOfYear(date) {
  return _time.callMethod('weekOfYear', []);
}

/// Computes the sunday-based week number.
sundayOfYear(date) {
  return _time.callMethod('sundayOfYear', []);
}

/// Computes the monday-based week number.
mondayOfYear(date) {
  return _time.callMethod('mondayOfYear', []);
}

/// Computes the tuesday-based week number.
tuesdayOfYear(date) {
  return _time.callMethod('tuesdayOfYear', []);
}

/// Computes the wednesday-based week number.
wednesdayOfYear(date) {
  return _time.callMethod('wednesdayOfYear', []);
}

/// Computes the thursday-based week number.
thursdayOfYear(date) {
  return _time.callMethod('thursdayOfYear', []);
}

/// Computes the friday-based week number.
fridayOfYear(date) {
  return _time.callMethod('fridayOfYear', []);
}

/// Computes the saturday-based week number.
saturdayOfYear(date) {
  return _time.callMethod('saturdayOfYear', []);
}
