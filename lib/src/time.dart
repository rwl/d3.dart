@JS('d3.time')
library d3.src.time;

import 'package:js/js.dart';

/// create a new local time formatter for a given specifier.
external Format format(specifier);

@JS()
class Format {
  /// format a date into a string.
  external format(date);

  /// parse a string into a date.
  external parse(string);
}

/// create a new local multi-resolution time formatter.
@JS('format.multi')
external multi(formats);

/// create a new UTC time formatter for a given specifier.
@JS('format.utc')
external utcFormat(specifier);

/// the ISO 8601 UTC time formatter.
@JS('format.iso')
external Format get iso;

/// construct a linear time scale.
external TimeScale scale();

@JS('scale.utc')
external TimeScale utcScale();

@JS()
class TimeScale {
  /// get the range value corresponding to a given domain value.
  external scale(x);

  /// get the domain value corresponding to a given range value.
  external invert(y);

  /// get or set the scale's input domain.
  external domain([dates]);

  /// extend the scale domain to nice round numbers.
  external nice([interval_or_count, step]);

  /// get or set the scale's output range.
  external range([values]);

  /// set the scale's output range, and enable rounding.
  external rangeRound([values]);

  /// get or set the scale's output interpolator.
  external interpolate([factory]);

  /// enable or disable clamping of the output range.
  external clamp([boolean]);

  /// get representative values from the input domain.
  external ticks([interval_or_count, step]);

  /// get a formatter for displaying tick values.
  external tickFormat();

  /// create a new scale from an existing scale.
  external copy();
}

/// a time interval in local time.
external Interval interval();

@JS()
class Interval {
  /// alias for interval.floor.
  external interval(date);

  /// rounds down to the nearest interval.
  external floor(date);

  /// rounds up or down to the nearest interval.
  external round(date);

  /// rounds up to the nearest interval.
  external ceil(date);

  /// returns dates within the specified range.
  external range(start, stop, [step]);

  /// returns a date offset by some interval.
  external offset(date, step);

  /// returns the UTC-equivalent time interval.
  external get utc;
}

/// every second (e.g., 1:02:03 AM).
external Interval get second;

/// every minute (e.g., 1:02 AM).
external Interval get minute;

/// every hour (e.g., 1:00 AM).
external Interval get hour;

/// every day (12:00 AM).
external Interval get day;

/// alias for sunday.
external Interval get week;

/// every Sunday (e.g., February 5, 12:00 AM).
external Interval get sunday;

/// every Monday (e.g., February 5, 12:00 AM).
external Interval get monday;

/// every Tuesday (e.g., February 5, 12:00 AM).
external Interval get tuesday;

/// every Wednesday (e.g., February 5, 12:00 AM).
external Interval get wednesday;

/// every Thursday (e.g., February 5, 12:00 AM).
external Interval get thursday;

/// every Friday (e.g., February 5, 12:00 AM).
external Interval get friday;

/// every Saturday (e.g., February 5, 12:00 AM).
external Interval get saturday;

/// every month (e.g., February 1, 12:00 AM).
external Interval get month;

/// every year (e.g., January 1, 12:00 AM).
external Interval get year;

/// alias for second.range.
external seconds(start, stop, [step]);

/// alias for minute.range.
external minutes(start, stop, [step]);

/// alias for hour.range.
external hours(start, stop, [step]);

/// alias for day.range.
external days(start, stop, [step]);

/// alias for sunday.range.
external weeks(start, stop, [step]);

/// alias for sunday.range.
external sundays(start, stop, [step]);

/// alias for monday.range.
external mondays(start, stop, [step]);

/// alias for tuesday.range.
external tuesdays(start, stop, [step]);

/// alias for wednesday.range.
external wednesdays(start, stop, [step]);

/// alias for thursday.range.
external thursdays(start, stop, [step]);

/// alias for friday.range.
external fridays(start, stop, [step]);

/// alias for saturday.range.
external saturdays(start, stop, [step]);

/// alias for month.range.
external months(start, stop, [step]);

/// alias for year.range.
external years(start, stop, [step]);

/// computes the day number.
external dayOfYear(date);

/// alias for sundayOfYear.
external weekOfYear(date);

/// computes the sunday-based week number.
external sundayOfYear(date);

/// computes the monday-based week number.
external mondayOfYear(date);

/// computes the tuesday-based week number.
external tuesdayOfYear(date);

/// computes the wednesday-based week number.
external wednesdayOfYear(date);

/// computes the thursday-based week number.
external thursdayOfYear(date);

/// computes the friday-based week number.
external fridayOfYear(date);

/// computes the saturday-based week number.
external saturdayOfYear(date);
