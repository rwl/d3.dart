part of d3.svg;

class Axis {
  var scale = scale.linear(),
      orient = axisDefaultOrient,
      innerTickSize = 6,
      outerTickSize = 6,
      tickPadding = 3,
      tickArguments_ = [10],
      tickValues = null,
      tickFormat_;

  axis(var g) {
    g.each(() {
      var g = selection.select(this);

      // Stash a snapshot of the new scale, and retrieve the old snapshot.
      var scale0 = this.__chart__ || scale,
          scale1 = this.__chart__ = scale.copy();

      // Ticks, or domain values for ordinal scales.
      var ticks = tickValues == null ? (scale1.ticks ? scale1.ticks.apply(scale1, tickArguments_) : scale1.domain()) : tickValues,
          tickFormat = tickFormat_ == null ? (scale1.tickFormat ? scale1.tickFormat.apply(scale1, tickArguments_) : core.identity) : tickFormat_,
          tick = g.selectAll(".tick").data(ticks, scale1),
          tickEnter = tick.enter().insert("g", ".domain").attr("class", "tick").style("opacity", epsilon),
          tickExit = transition.transition(tick.exit()).style("opacity", epsilon).remove(),
          tickUpdate = transition.transition(tick).style("opacity", 1),
          tickTransform;

      // Domain.
      var range = scaleRange(scale1),
          path = g.selectAll(".domain").data([0]);
      path.enter().append("path").attr("class", "domain");
      var pathUpdate = transition.transition(path);

      tickEnter.append("line");
      tickEnter.append("text");

      var lineEnter = tickEnter.select("line"),
          lineUpdate = tickUpdate.select("line"),
          text = tick.select("text").text(tickFormat),
          textEnter = tickEnter.select("text"),
          textUpdate = tickUpdate.select("text");

      switch (orient) {
        case "bottom": {
          tickTransform = axisX;
          lineEnter.attr("y2", innerTickSize);
          textEnter.attr("y", math.max(innerTickSize, 0) + tickPadding);
          lineUpdate.attr("x2", 0).attr("y2", innerTickSize);
          textUpdate.attr("x", 0).attr("y", math.max(innerTickSize, 0) + tickPadding);
          text.attr("dy", ".71em").style("text-anchor", "middle");
          pathUpdate.attr("d", "M" + range[0] + "," + outerTickSize + "V0H" + range[1] + "V" + outerTickSize);
          break;
        }
        case "top": {
          tickTransform = axisX;
          lineEnter.attr("y2", -innerTickSize);
          textEnter.attr("y", -(math.max(innerTickSize, 0) + tickPadding));
          lineUpdate.attr("x2", 0).attr("y2", -innerTickSize);
          textUpdate.attr("x", 0).attr("y", -(math.max(innerTickSize, 0) + tickPadding));
          text.attr("dy", "0em").style("text-anchor", "middle");
          pathUpdate.attr("d", "M" + range[0] + "," + -outerTickSize + "V0H" + range[1] + "V" + -outerTickSize);
          break;
        }
        case "left": {
          tickTransform = axisY;
          lineEnter.attr("x2", -innerTickSize);
          textEnter.attr("x", -(math.max(innerTickSize, 0) + tickPadding));
          lineUpdate.attr("x2", -innerTickSize).attr("y2", 0);
          textUpdate.attr("x", -(math.max(innerTickSize, 0) + tickPadding)).attr("y", 0);
          text.attr("dy", ".32em").style("text-anchor", "end");
          pathUpdate.attr("d", "M" + -outerTickSize + "," + range[0] + "H0V" + range[1] + "H" + -outerTickSize);
          break;
        }
        case "right": {
          tickTransform = axisY;
          lineEnter.attr("x2", innerTickSize);
          textEnter.attr("x", math.max(innerTickSize, 0) + tickPadding);
          lineUpdate.attr("x2", innerTickSize).attr("y2", 0);
          textUpdate.attr("x", math.max(innerTickSize, 0) + tickPadding).attr("y", 0);
          text.attr("dy", ".32em").style("text-anchor", "start");
          pathUpdate.attr("d", "M" + outerTickSize + "," + range[0] + "H0V" + range[1] + "H" + outerTickSize);
          break;
        }
      }

      // If either the new or old scale is ordinal,
      // entering ticks are undefined in the old scale,
      // and so can fade-in in the new scale’s position.
      // Exiting ticks are likewise undefined in the new scale,
      // and so can fade-out in the old scale’s position.
      if (scale1.rangeBand) {
        var x = scale1, dx = x.rangeBand() / 2;
        scale0 = scale1 = (d) { return x(d) + dx; };
      } else if (scale0.rangeBand) {
        scale0 = scale1;
      } else {
        tickExit.call(tickTransform, scale1);
      }

      tickEnter.call(tickTransform, scale0);
      tickUpdate.call(tickTransform, scale1);
    });
  }

  void set orient(x) {
    orient = axisOrients.contains(x) ? x.toString() : axisDefaultOrient;
  }

  void set ticks(args) {
    tickArguments_ = args;
  }

  get tickSize {
    return innerTickSize;
  }

  void set tickSize(x) {
    var n = arguments.length;
    innerTickSize = toDouble(x);
    outerTickSize = toDouble(arguments[n - 1]);
  }

  tickSubdivide() {
    return arguments.length && axis;
  }
}

var axisDefaultOrient = "bottom",
    axisOrients = {'top': 1, 'right': 1, 'bottom': 1, 'left': 1};

axisX(selection, x) {
  selection.attr("transform", (d) { return "translate(" + x(d) + ",0)"; });
}

axisY(selection, y) {
  selection.attr("transform", (d) { return "translate(0," + y(d) + ")"; });
}
