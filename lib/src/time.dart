@JS('d3.time')
library d3.src.time;

import 'package:js/js.dart';

external Format format(specifier);

@JS()
class Format {
  external format(date);
  external parse(string);
}

@JS('format.multi')
external multi(formats);

@JS('format.utc')
external utcFormat(specifier);

@JS('format.iso')
external Format get iso;

external TimeScale scale();

@JS('scale.utc')
external TimeScale utcScale();

@JS()
class TimeScale {
  external scale(x);
  external invert(y);
  external domain([dates]);
  external nice([interval_or_count, step]);
  external range([values]);
  external rangeRound([values]);
  external interpolate([factory]);
  external clamp([boolean]);
  external ticks([interval_or_count, step]);
  external tickFormat();
  external copy();
}

external Interval interval();

@JS()
class Interval {
  external interval(date);
  external floor(date);
  external round(date);
  external ceil(date);
  external range(start, stop, [step]);
  external offset(date, step);
  external get utc;
}

external Interval get second;
external Interval get minute;
external Interval get hour;
external Interval get day;
external Interval get week;
external Interval get sunday;
external Interval get monday;
external Interval get tuesday;
external Interval get wednesday;
external Interval get thursday;
external Interval get friday;
external Interval get saturday;
external Interval get month;
external Interval get year;

external seconds(start, stop, [step]);
external minutes(start, stop, [step]);
external hours(start, stop, [step]);
external days(start, stop, [step]);
external weeks(start, stop, [step]);
external sundays(start, stop, [step]);
external mondays(start, stop, [step]);
external tuesdays(start, stop, [step]);
external wednesdays(start, stop, [step]);
external thursdays(start, stop, [step]);
external fridays(start, stop, [step]);
external saturdays(start, stop, [step]);
external months(start, stop, [step]);
external years(start, stop, [step]);

external dayOfYear(date);
external weekOfYear(date);
external sundayOfYear(date);
external mondayOfYear(date);
external tuesdayOfYear(date);
external wednesdayOfYear(date);
external thursdayOfYear(date);
external fridayOfYear(date);
external saturdayOfYear(date);
