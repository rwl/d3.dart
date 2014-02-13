part of d3.svg;

class Axis {
  var scale = new Linear();
  AxisOrient orient = AxisOrient.BOTTOM;
  num innerTickSize = 6;
  num outerTickSize = 6;
  num tickPadding = 3;
  List tickArguments_ = [10];
  var tickValues = null;
  var tickFormat_;

  axis(final Selection g) {
    g.each((node, data, _i, _j) {
      final g = new Selection.selector(node);

      // Stash a snapshot of the new scale, and retrieve the old snapshot.
      var scale0 = this.__chart__ || scale;
      var scale1 = this.__chart__ = scale.copy();

      // Ticks, or domain values for ordinal scales.
      var ticks = tickValues == null ? (scale1.ticks ? scale1.ticks.apply(scale1, tickArguments_) : scale1.domain()) : tickValues;
      var tickFormat = tickFormat_ == null ? (scale1.tickFormat ? scale1.tickFormat.apply(scale1, tickArguments_) : core.identity) : tickFormat_;
      final Selection tick = g.selectAll(".tick").data(ticks, scale1);
      var tickEnter = tick.enter().insert("g", ".domain").attr("class", "tick").style("opacity", epsilon);
      var tickExit = new Transition(tick.exit()).style("opacity", epsilon).remove();
      var tickUpdate = new Transition(tick).style("opacity", 1);
      var tickTransform;

      // Domain.
      var range = scaleRange(scale1);
      final Selection path = g.selectAll(".domain").data([0]);
      path.enter().append("path").attr("class", "domain");
      var pathUpdate = new Transition(path);

      tickEnter.append("line");
      tickEnter.append("text");

      var lineEnter = tickEnter.select("line"),
          lineUpdate = tickUpdate.select("line"),
          text = tick.select("text").text(tickFormat),
          textEnter = tickEnter.select("text"),
          textUpdate = tickUpdate.select("text");

      switch (orient) {
        case AxisOrient.BOTTOM:
          tickTransform = axisX;
          lineEnter.attr("y2", innerTickSize);
          textEnter.attr("y", math.max(innerTickSize, 0) + tickPadding);
          lineUpdate.attr("x2", 0).attr("y2", innerTickSize);
          textUpdate.attr("x", 0).attr("y", math.max(innerTickSize, 0) + tickPadding);
          text.attr("dy", ".71em").style("text-anchor", "middle");
          pathUpdate.attr("d", "M${range[0]},${outerTickSize}V0H${range[1]}V${outerTickSize}");
          break;
        case AxisOrient.TOP:
          tickTransform = axisX;
          lineEnter.attr("y2", -innerTickSize);
          textEnter.attr("y", -(math.max(innerTickSize, 0) + tickPadding));
          lineUpdate.attr("x2", 0).attr("y2", -innerTickSize);
          textUpdate.attr("x", 0).attr("y", -(math.max(innerTickSize, 0) + tickPadding));
          text.attr("dy", "0em").style("text-anchor", "middle");
          pathUpdate.attr("d", "M${range[0]},${-outerTickSize}V0H${range[1]}V${-outerTickSize}");
          break;
        case AxisOrient.LEFT:
          tickTransform = axisY;
          lineEnter.attr("x2", -innerTickSize);
          textEnter.attr("x", -(math.max(innerTickSize, 0) + tickPadding));
          lineUpdate.attr("x2", -innerTickSize).attr("y2", 0);
          textUpdate.attr("x", -(math.max(innerTickSize, 0) + tickPadding)).attr("y", 0);
          text.attr("dy", ".32em").style("text-anchor", "end");
          pathUpdate.attr("d", "M${-outerTickSize},${range[0]}H0V${range[1]}H${-outerTickSize}");
          break;
        case AxisOrient.RIGHT:
          tickTransform = axisY;
          lineEnter.attr("x2", innerTickSize);
          textEnter.attr("x", math.max(innerTickSize, 0) + tickPadding);
          lineUpdate.attr("x2", innerTickSize).attr("y2", 0);
          textUpdate.attr("x", math.max(innerTickSize, 0) + tickPadding).attr("y", 0);
          text.attr("dy", ".32em").style("text-anchor", "start");
          pathUpdate.attr("d", "M${outerTickSize},${range[0]}H0V${range[1]}H${outerTickSize}");
          break;
      }

      // If either the new or old scale is ordinal,
      // entering ticks are undefined in the old scale,
      // and so can fade-in in the new scale’s position.
      // Exiting ticks are likewise undefined in the new scale,
      // and so can fade-out in the old scale’s position.
      if (scale1 is Ordinal) {
        var x = scale1, dx = x.rangeBand / 2;
        scale0 = scale1 = (d) { return x(d) + dx; };
      } else if (scale0 is Ordinal) {
        scale0 = scale1;
      } else {
        tickExit.call(tickTransform, scale1);
      }

      tickEnter.call(tickTransform, scale0);
      tickUpdate.call(tickTransform, scale1);
    });
  }

//  void set orient(AxisOrient x) {
//    orient = axisOrients.contains(x) ? x.toString() : axisDefaultOrient;
//  }

  void set ticks(args) {
    tickArguments_ = args;
  }

  get tickSize {
    return innerTickSize;
  }

  setTickSize(inner, outer) {
    innerTickSize = toDouble(inner);
    outerTickSize = toDouble(outer);
  }

//  tickSubdivide() {
//    return arguments.length && axis;
//  }
}

//AxisOrient axisDefaultOrient = AxisOrient.BOTTOM;
//    axisOrients = {'top': 1, 'right': 1, 'bottom': 1, 'left': 1};


class AxisOrient {
  final _value;
  const AxisOrient._internal(this._value);
  toString() => 'Enum.$_value';

  static const TOP = const AxisOrient._internal('top');
  static const RIGHT = const AxisOrient._internal('right');
  static const BOTTOM = const AxisOrient._internal('bottom');
  static const LEFT = const AxisOrient._internal('left');
}

axisX(selection, x) {
  selection.attr("transform", (d) { return "translate(" + x(d) + ",0)"; });
}

axisY(selection, y) {
  selection.attr("transform", (d) { return "translate(0," + y(d) + ")"; });
}
