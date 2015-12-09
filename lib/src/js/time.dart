library d3.src.js.time;

import 'dart:js';
import 'd3.dart';

JsObject _time = context['d3']['time'];

/// Create a new local time formatter for a given specifier.
Format format(String specifier) {
  return new Format._(_time.callMethod('format', [specifier]));
}

class Format {
  final JsObject _proxy;

  Format._(this._proxy);

  factory Format(String specifier) => format(specifier);

  factory Format.multi(List formats) => multi(formats);

  factory Format.utc(String specifier) => utcFormat(specifier);

  /// Format a date into a string.
  String call(DateTime date) => _proxy.callMethod('call', [_proxy, date]);

  /// Parse a string into a date.
  DateTime parse(String string) => _proxy.callMethod('parse', [string]);
}

/// Create a new local multi-resolution time formatter.
Format multi(List formats) {
  return new Format._(_time['format'].callMethod('multi', [formats]));
}

/// Create a new UTC time formatter for a given specifier.
Format utcFormat(String specifier) {
  return new Format._(_time['format'].callMethod('utc', [specifier]));
}

/// The ISO 8601 UTC time formatter.
Format get iso => new Format._(_time['format']['iso']);

/// Construct a linear time scale.
TimeScale scale() => new TimeScale._(_time.callMethod('scale'));

TimeScale utcScale() => new TimeScale._(_time['scale'].callMethod('utc'));

class TimeScale {
  final JsObject _proxy;

  TimeScale._(this._proxy);

  factory TimeScale() => scale();

  factory TimeScale.utc() => utcScale();

  /// Get the range value corresponding to a given domain value.
  call(x) => _proxy.callMethod('call', [_proxy, x]);

  /// Get the domain value corresponding to a given range value.
  invert(y) => _proxy.callMethod('invert', [y]);

  /// Get or set the scale's input domain.
  domain([List dates = undefinedList]) {
    var args = [];
    if (dates != undefinedList) {
      args.add(dates);
    }
    var retval = _proxy.callMethod('domain', args);
    if (dates == undefinedList) {
      return retval;
    } else {
      return new TimeScale._(retval);
    }
  }

  /// Extend the scale domain to nice round numbers.
  TimeScale nice([interval_or_count = undefined, step = undefined]) {
    var args = [];
    if (interval_or_count != undefined) {
      args.add(interval_or_count);
    }
    if (step != undefined) {
      args.add(step);
    }
    return new TimeScale._(_proxy.callMethod('nice', args));
  }

  /// Get or set the scale's output range.
  range([List values = undefinedList]) {
    var args = [];
    if (values != undefinedList) {
      args.add(values);
    }
    var retval = _proxy.callMethod('range', args);
    if (values == undefinedList) {
      return retval;
    } else {
      return new TimeScale._(retval);
    }
  }

  /// Set the scale's output range, and enable rounding.
  rangeRound([List values = undefinedList]) {
    var args = [];
    if (values != undefinedList) {
      args.add(values);
    }
    var retval = _proxy.callMethod('rangeRound', args);
    if (values == undefinedList) {
      return retval;
    } else {
      return new TimeScale._(retval);
    }
  }

  /// Get or set the scale's output interpolator.
  interpolate([Function factory = undefinedFn]) {
    var args = [];
    if (factory != undefinedFn) {
      args.add(factory);
    }
    var retval = _proxy.callMethod('interpolate', args);
    if (factory == undefinedFn) {
      return retval;
    } else {
      return new TimeScale._(retval);
    }
  }

  /// Enable or disable clamping of the output range.
  clamp([/*bool*/ boolean = undefined]) {
    var args = [];
    if (boolean != undefined) {
      args.add(boolean);
    }
    var retval = _proxy.callMethod('clamp', args);
    if (boolean == undefined) {
      return retval;
    } else {
      return new TimeScale._(retval);
    }
  }

  /// Get representative values from the input domain.
  ticks([interval_or_count = undefined, num step = undefined]) {
    var args = [];
    if (interval_or_count != undefined) {
      args.add(interval_or_count);
    }
    if (step != undefined) {
      args.add(step);
    }
    return _proxy.callMethod('ticks', args);
  }

  /// Get a formatter for displaying tick values.
  Function tickFormat() => _proxy.callMethod('tickFormat');

  /// Create a new scale from an existing scale.
  TimeScale copy() => new TimeScale._(_proxy.callMethod('copy'));
}

/// A time interval in local time.
Interval interval() => new Interval._(_time.callMethod('interval'));

class Interval {
  final JsObject _proxy;

  Interval._(this._proxy);

  factory Interval() => interval();

  /// Alias for interval.floor.
  DateTime call(DateTime date) {
    return _proxy.callMethod('call', [_proxy, date]);
  }

  /// Rounds down to the nearest interval.
  DateTime floor(DateTime date) {
    return _proxy.callMethod('floor', [date]);
  }

  /// Rounds up or down to the nearest interval.
  DateTime round(DateTime date) {
    return _proxy.callMethod('round', [date]);
  }

  /// Rounds up to the nearest interval.
  DateTime ceil(DateTime date) {
    return _proxy.callMethod('ceil', [date]);
  }

  /// Returns dates within the specified range.
  range(start, stop, [num step = undefinedNum]) {
    var args = [start, stop];
    if (step != undefinedNum) {
      args.add(step);
    }
    return _proxy.callMethod('range', args);
  }

  /// Returns a date offset by some interval.
  DateTime offset(DateTime date, num step) {
    return _proxy.callMethod('offset', [date, step]);
  }

  /// Returns the UTC-equivalent time interval.
  Interval get utc => new Interval._(_proxy['utc']);
}

/// Every second (e.g., 1:02:03 AM).
Interval get second => new Interval._(_time['second']);

/// Every minute (e.g., 1:02 AM).
Interval get minute => new Interval._(_time['minute']);

/// Every hour (e.g., 1:00 AM).
Interval get hour => new Interval._(_time['hour']);

/// Every day (12:00 AM).
Interval get day => new Interval._(_time['day']);

/// Alias for sunday.
Interval get week => new Interval._(_time['week']);

/// Every Sunday (e.g., February 5, 12:00 AM).
Interval get sunday => new Interval._(_time['sunday']);

/// Every Monday (e.g., February 5, 12:00 AM).
Interval get monday => new Interval._(_time['monday']);

/// Every Tuesday (e.g., February 5, 12:00 AM).
Interval get tuesday => new Interval._(_time['tuesday']);

/// Every Wednesday (e.g., February 5, 12:00 AM).
Interval get wednesday => new Interval._(_time['wednesday']);

/// Every Thursday (e.g., February 5, 12:00 AM).
Interval get thursday => new Interval._(_time['thursday']);

/// Every Friday (e.g., February 5, 12:00 AM).
Interval get friday => new Interval._(_time['friday']);

/// Every Saturday (e.g., February 5, 12:00 AM).
Interval get saturday => new Interval._(_time['saturday']);

/// Every month (e.g., February 1, 12:00 AM).
Interval get month => new Interval._(_time['month']);

/// Every year (e.g., January 1, 12:00 AM).
Interval get year => new Interval._(_time['year']);

/// Alias for second.range.
List seconds(start, stop, [num step = undefinedNum]) {
  var args = [start, stop];
  if (step != undefinedNum) {
    args.add(step);
  }
  return _time.callMethod('seconds', args);
}

/// Alias for minute.range.
List minutes(start, stop, [num step = undefinedNum]) {
  var args = [start, stop];
  if (step != undefinedNum) {
    args.add(step);
  }
  return _time.callMethod('minutes', args);
}

/// Alias for hour.range.
List hours(start, stop, [num step = undefinedNum]) {
  var args = [start, stop];
  if (step != undefinedNum) {
    args.add(step);
  }
  return _time.callMethod('hours', args);
}

/// Alias for day.range.
List days(start, stop, [num step = undefinedNum]) {
  var args = [start, stop];
  if (step != undefinedNum) {
    args.add(step);
  }
  return _time.callMethod('days', args);
}

/// Alias for sunday.range.
List weeks(start, stop, [num step = undefinedNum]) {
  var args = [start, stop];
  if (step != undefinedNum) {
    args.add(step);
  }
  return _time.callMethod('weeks', args);
}

/// Alias for sunday.range.
List sundays(start, stop, [num step = undefinedNum]) {
  var args = [start, stop];
  if (step != undefinedNum) {
    args.add(step);
  }
  return _time.callMethod('sundays', args);
}

/// Alias for monday.range.
List mondays(start, stop, [num step = undefinedNum]) {
  var args = [start, stop];
  if (step != undefinedNum) {
    args.add(step);
  }
  return _time.callMethod('mondays', args);
}

/// Alias for tuesday.range.
List tuesdays(start, stop, [num step = undefinedNum]) {
  var args = [start, stop];
  if (step != undefinedNum) {
    args.add(step);
  }
  return _time.callMethod('tuesdays', args);
}

/// Alias for wednesday.range.
List wednesdays(start, stop, [num step = undefinedNum]) {
  var args = [start, stop];
  if (step != undefinedNum) {
    args.add(step);
  }
  return _time.callMethod('wednesdays', args);
}

/// Alias for thursday.range.
List thursdays(start, stop, [num step = undefinedNum]) {
  var args = [start, stop];
  if (step != undefinedNum) {
    args.add(step);
  }
  return _time.callMethod('thursdays', args);
}

/// Alias for friday.range.
List fridays(start, stop, [num step = undefinedNum]) {
  var args = [start, stop];
  if (step != undefinedNum) {
    args.add(step);
  }
  return _time.callMethod('fridays', args);
}

/// Alias for saturday.range.
List saturdays(start, stop, [num step = undefinedNum]) {
  var args = [start, stop];
  if (step != undefinedNum) {
    args.add(step);
  }
  return _time.callMethod('saturdays', args);
}

/// Alias for month.range.
List months(start, stop, [num step = undefinedNum]) {
  var args = [start, stop];
  if (step != undefinedNum) {
    args.add(step);
  }
  return _time.callMethod('months', args);
}

/// Alias for year.range.
List years(start, stop, [num step = undefinedNum]) {
  var args = [start, stop];
  if (step != undefinedNum) {
    args.add(step);
  }
  return _time.callMethod('years', args);
}

/// Computes the day number.
int dayOfYear(DateTime date) {
  return _time.callMethod('dayOfYear', [date]);
}

/// Alias for sundayOfYear.
int weekOfYear(DateTime date) {
  return _time.callMethod('weekOfYear', [date]);
}

/// Computes the sunday-based week number.
int sundayOfYear(DateTime date) {
  return _time.callMethod('sundayOfYear', [date]);
}

/// Computes the monday-based week number.
int mondayOfYear(DateTime date) {
  return _time.callMethod('mondayOfYear', [date]);
}

/// Computes the tuesday-based week number.
int tuesdayOfYear(DateTime date) {
  return _time.callMethod('tuesdayOfYear', [date]);
}

/// Computes the wednesday-based week number.
int wednesdayOfYear(DateTime date) {
  return _time.callMethod('wednesdayOfYear', [date]);
}

/// Computes the thursday-based week number.
int thursdayOfYear(DateTime date) {
  return _time.callMethod('thursdayOfYear', [date]);
}

/// Computes the friday-based week number.
int fridayOfYear(DateTime date) {
  return _time.callMethod('fridayOfYear', [date]);
}

/// Computes the saturday-based week number.
int saturdayOfYear(DateTime date) {
  return _time.callMethod('saturdayOfYear', [date]);
}
