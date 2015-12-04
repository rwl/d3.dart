@JS('d3.time')
library d3.src.time;

import 'package:js/js.dart';

/// Create a new local time formatter for a given specifier.
external Format format(specifier);

@JS()
class Format {
  /// Format a date into a string.
  external format(date);

  /// Parse a string into a date.
  external parse(string);
}

/// Create a new local multi-resolution time formatter.
@JS('format.multi')
external multi(formats);

/// Create a new UTC time formatter for a given specifier.
@JS('format.utc')
external utcFormat(specifier);

/// The ISO 8601 UTC time formatter.
@JS('format.iso')
external Format get iso;

/// Construct a linear time scale.
external TimeScale scale();

@JS('scale.utc')
external TimeScale utcScale();

@JS()
class TimeScale {
  /// Get the range value corresponding to a given domain value.
  external scale(x);

  /// Get the domain value corresponding to a given range value.
  external invert(y);

  /// Get or set the scale's input domain.
  external domain([dates]);

  /// Extend the scale domain to nice round numbers.
  external nice([interval_or_count, step]);

  /// Get or set the scale's output range.
  external range([values]);

  /// Set the scale's output range, and enable rounding.
  external rangeRound([values]);

  /// Get or set the scale's output interpolator.
  external interpolate([factory]);

  /// Enable or disable clamping of the output range.
  external clamp([boolean]);

  /// Get representative values from the input domain.
  external ticks([interval_or_count, step]);

  /// Get a formatter for displaying tick values.
  external tickFormat();

  /// Create a new scale from an existing scale.
  external copy();
}

/// A time interval in local time.
external Interval interval();

@JS()
class Interval {
  /// Alias for interval.floor.
  external interval(date);

  /// Rounds down to the nearest interval.
  external floor(date);

  /// Rounds up or down to the nearest interval.
  external round(date);

  /// Rounds up to the nearest interval.
  external ceil(date);

  /// Returns dates within the specified range.
  external range(start, stop, [step]);

  /// Returns a date offset by some interval.
  external offset(date, step);

  /// Returns the UTC-equivalent time interval.
  external get utc;
}

/// Every second (e.g., 1:02:03 AM).
external Interval get second;

/// Every minute (e.g., 1:02 AM).
external Interval get minute;

/// Every hour (e.g., 1:00 AM).
external Interval get hour;

/// Every day (12:00 AM).
external Interval get day;

/// Alias for sunday.
external Interval get week;

/// Every Sunday (e.g., February 5, 12:00 AM).
external Interval get sunday;

/// Every Monday (e.g., February 5, 12:00 AM).
external Interval get monday;

/// Every Tuesday (e.g., February 5, 12:00 AM).
external Interval get tuesday;

/// Every Wednesday (e.g., February 5, 12:00 AM).
external Interval get wednesday;

/// Every Thursday (e.g., February 5, 12:00 AM).
external Interval get thursday;

/// Every Friday (e.g., February 5, 12:00 AM).
external Interval get friday;

/// Every Saturday (e.g., February 5, 12:00 AM).
external Interval get saturday;

/// Every month (e.g., February 1, 12:00 AM).
external Interval get month;

/// Every year (e.g., January 1, 12:00 AM).
external Interval get year;

/// Alias for second.range.
external seconds(start, stop, [step]);

/// Alias for minute.range.
external minutes(start, stop, [step]);

/// Alias for hour.range.
external hours(start, stop, [step]);

/// Alias for day.range.
external days(start, stop, [step]);

/// Alias for sunday.range.
external weeks(start, stop, [step]);

/// Alias for sunday.range.
external sundays(start, stop, [step]);

/// Alias for monday.range.
external mondays(start, stop, [step]);

/// Alias for tuesday.range.
external tuesdays(start, stop, [step]);

/// Alias for wednesday.range.
external wednesdays(start, stop, [step]);

/// Alias for thursday.range.
external thursdays(start, stop, [step]);

/// Alias for friday.range.
external fridays(start, stop, [step]);

/// Alias for saturday.range.
external saturdays(start, stop, [step]);

/// Alias for month.range.
external months(start, stop, [step]);

/// Alias for year.range.
external years(start, stop, [step]);

/// Computes the day number.
external dayOfYear(date);

/// Alias for sundayOfYear.
external weekOfYear(date);

/// Computes the sunday-based week number.
external sundayOfYear(date);

/// Computes the monday-based week number.
external mondayOfYear(date);

/// Computes the tuesday-based week number.
external tuesdayOfYear(date);

/// Computes the wednesday-based week number.
external wednesdayOfYear(date);

/// Computes the thursday-based week number.
external thursdayOfYear(date);

/// Computes the friday-based week number.
external fridayOfYear(date);

/// Computes the saturday-based week number.
external saturdayOfYear(date);
