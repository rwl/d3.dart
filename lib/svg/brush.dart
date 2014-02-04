part of d3.svg;

class Brush {
  var event,
      x = null, // x-scale, optional
      y = null, // y-scale, optional
      xExtent = [0, 0], // [x0, x1] in integer pixels
      yExtent = [0, 0], // [y0, y1] in integer pixels
      xExtentDomain, // x-extent in data space
      yExtentDomain, // y-extent in data space
      xClamp = true, // whether to clamp the x-extent to the range
      yClamp = true, // whether to clamp the y-extent to the range
      resizes = brushResizes[0];

  Brush() {
    var event = eventDispatch(this, "brushstart", "brush", "brushend");

    d3.rebind(brush, event, "on");
  }

  brush(g) {
    g.each(() {

      // Prepare the brush container for events.
      var g = selection.select(this)
          .style("pointer-events", "all")
          .style("-webkit-tap-highlight-color", "rgba(0,0,0,0)")
          .on("mousedown.brush", brushstart)
          .on("touchstart.brush", brushstart);

      // An invisible, mouseable area for starting a new brush.
      var background = g.selectAll(".background")
          .data([0]);

      background.enter().append("rect")
          .attr("class", "background")
          .style("visibility", "hidden")
          .style("cursor", "crosshair");

      // The visible brush extent; style this as you like!
      g.selectAll(".extent")
          .data([0])
        .enter().append("rect")
          .attr("class", "extent")
          .style("cursor", "move");

      // More invisible rects for resizing the extent.
      var resize = g.selectAll(".resize")
          .data(resizes, identity);

      // Remove any superfluous resizers.
      resize.exit().remove();

      resize.enter().append("g")
          .attr("class", (d) { return "resize " + d; })
          .style("cursor", (d) { return brushCursor[d]; })
        .append("rect")
          .attr("x", (d) { return r"[ew]$".test(d) ? -3 : null; })
          .attr("y", (d) { return r"^[ns]".test(d) ? -3 : null; })
          .attr("width", 6)
          .attr("height", 6)
          .style("visibility", "hidden");

      // Show or hide the resizers.
      resize.style("display", brush.empty() ? "none" : null);

      // When called on a transition, use a transition to update.
      var gUpdate = transition.transition(g),
          backgroundUpdate = transition.transition(background),
          range;

      // Initialize the background to fill the defined range.
      // If the range isn't defined, you can post-process.
      if (x) {
        range = scale.scaleRange(x);
        backgroundUpdate.attr("x", range[0]).attr("width", range[1] - range[0]);
        redrawX(gUpdate);
      }
      if (y) {
        range = scale.scaleRange(y);
        backgroundUpdate.attr("y", range[0]).attr("height", range[1] - range[0]);
        redrawY(gUpdate);
      }
      redraw(gUpdate);
    });
  }

  event(g) {
    g.each((thiz) {
      var event_ = event.of(thiz, arguments),
          extent1 = {'x': xExtent, 'y': yExtent, 'i': xExtentDomain, 'j': yExtentDomain},
          extent0 = thiz.__chart__ || extent1;
      thiz.__chart__ = extent1;
      if (transitionInheritId) {
        selection.select(thiz).transition()
            .each("start.brush", () {
              xExtentDomain = extent0.i; // pre-transition state
              yExtentDomain = extent0.j;
              xExtent = extent0.x;
              yExtent = extent0.y;
              event_({'type': "brushstart"});
            })
            .tween("brush:brush", () {
              var xi = interpolateArray(xExtent, extent1.x),
                  yi = interpolateArray(yExtent, extent1.y);
              xExtentDomain = yExtentDomain = null; // transition state
              return (t) {
                xExtent = extent1.x = xi(t);
                yExtent = extent1.y = yi(t);
                event_({'type': "brush", 'mode': "resize"});
              };
            })
            .each("end.brush", () {
              xExtentDomain = extent1.i; // post-transition state
              yExtentDomain = extent1.j;
              event_({'type': "brush", 'mode': "resize"});
              event_({'type': "brushend"});
            });
      } else {
        event_({'type': "brushstart"});
        event_({'type': "brush", 'mode': "resize"});
        event_({'type': "brushend"});
      }
    });
  }

  redraw(g) {
    g.selectAll(".resize").attr("transform", (d) {
      return "translate(" + xExtent[/*+*/r"e$".test(d)] + "," + yExtent[/*+*/r"^s".test(d)] + ")";
    });
  }

  redrawX(g) {
    g.select(".extent").attr("x", xExtent[0]);
    g.selectAll(".extent,.n>rect,.s>rect").attr("width", xExtent[1] - xExtent[0]);
  }

  redrawY(g) {
    g.select(".extent").attr("y", yExtent[0]);
    g.selectAll(".extent,.e>rect,.w>rect").attr("height", yExtent[1] - yExtent[0]);
  }

  brushstart() {
    var target = this,
        eventTarget = selection.select(d3_event.target),
        event_ = d3_event.of(target, arguments),
        g = selection.select(target),
        resizing = eventTarget.datum(),
        resizingX = /*!*/r"^(n|s)$".test(resizing) && x,
        resizingY = /*!*/r"^(e|w)$".test(resizing) && y,
        dragging = eventTarget.classed("extent"),
        dragRestore = d3_event.dragSuppress(),
        center,
        origin = d3_event.mouse(target),
        offset;

    var w = selection.select(window)
        .on("keydown.brush", keydown)
        .on("keyup.brush", keyup);

    if (d3_event.changedTouches) {
      w.on("touchmove.brush", brushmove).on("touchend.brush", brushend);
    } else {
      w.on("mousemove.brush", brushmove).on("mouseup.brush", brushend);
    }

    // Interrupt the transition, if any.
    g.interrupt().selectAll("*").interrupt();

    // If the extent was clicked on, drag rather than brush;
    // store the point between the mouse and extent origin instead.
    if (dragging) {
      origin[0] = xExtent[0] - origin[0];
      origin[1] = yExtent[0] - origin[1];
    }

    // If a resizer was clicked on, record which side is to be resized.
    // Also, set the origin to the opposite side.
    else if (resizing) {
      var ex = /*+*/r"w$".test(resizing),
          ey = /*+*/r"^n".test(resizing);
      offset = [xExtent[1 - ex] - origin[0], yExtent[1 - ey] - origin[1]];
      origin[0] = xExtent[ex];
      origin[1] = yExtent[ey];
    }

    // If the ALT key is down when starting a brush, the center is at the mouse.
    else if (d3_event.altKey) center = origin.slice();

    // Propagate the active cursor to the body for the drag duration.
    g.style("pointer-events", "none").selectAll(".resize").style("display", null);
    selection.select("body").style("cursor", eventTarget.style("cursor"));

    // Notify listeners.
    event_({'type': "brushstart"});
    brushmove();

    keydown() {
      if (d3_event.keyCode == 32) {
        if (!dragging) {
          center = null;
          origin[0] -= xExtent[1];
          origin[1] -= yExtent[1];
          dragging = 2;
        }
        d3_event.eventPreventDefault();
      }
    }

    keyup() {
      if (d3.event.keyCode == 32 && dragging == 2) {
        origin[0] += xExtent[1];
        origin[1] += yExtent[1];
        dragging = 0;
        d3_event.eventPreventDefault();
      }
    }

    brushmove() {
      var point = d3_event.mouse(target),
          moved = false;

      // Preserve the offset for thick resizers.
      if (offset) {
        point[0] += offset[0];
        point[1] += offset[1];
      }

      if (!dragging) {

        // If needed, determine the center from the current extent.
        if (d3_event.event.altKey) {
          if (!center) center = [(xExtent[0] + xExtent[1]) / 2, (yExtent[0] + yExtent[1]) / 2];

          // Update the origin, for when the ALT key is released.
          origin[0] = xExtent[toDouble(point[0] < center[0])];
          origin[1] = yExtent[toDouble(point[1] < center[1])];
        }

        // When the ALT key is released, we clear the center.
        else center = null;
      }

      // Update the brush extent for each dimension.
      if (resizingX && move1(point, x, 0)) {
        redrawX(g);
        moved = true;
      }
      if (resizingY && move1(point, y, 1)) {
        redrawY(g);
        moved = true;
      }

      // Final redraw and notify listeners.
      if (moved) {
        redraw(g);
        event_({'type': "brush", 'mode': dragging ? "move" : "resize"});
      }
    }

    move1(point, scale, i) {
      var range = scale.scaleRange(scale),
          r0 = range[0],
          r1 = range[1],
          position = origin[i],
          extent = i ? yExtent : xExtent,
          size = extent[1] - extent[0],
          min,
          max;

      // When dragging, reduce the range by the extent size and position.
      if (dragging) {
        r0 -= position;
        r1 -= size + position;
      }

      // Clamp the point (unless clamp set to false) so that the extent fits within the range extent.
      min = (i ? yClamp : xClamp) ? math.max(r0, math.min(r1, point[i])) : point[i];

      // Compute the new extent bounds.
      if (dragging) {
        max = (min += position) + size;
      } else {

        // If the ALT key is pressed, then preserve the center of the extent.
        if (center) position = math.max(r0, math.min(r1, 2 * center[i] - min));

        // Compute the min and max of the position and point.
        if (position < min) {
          max = min;
          min = position;
        } else {
          max = position;
        }
      }

      // Update the stored bounds.
      if (extent[0] != min || extent[1] != max) {
        if (i) yExtentDomain = null;
        else xExtentDomain = null;
        extent[0] = min;
        extent[1] = max;
        return true;
      }
    }

    brushend() {
      brushmove();

      // reset the cursor styles
      g.style("pointer-events", "all").selectAll(".resize").style("display", brush.empty() ? "none" : null);
      selection.select("body").style("cursor", null);

      w .on("mousemove.brush", null)
        .on("mouseup.brush", null)
        .on("touchmove.brush", null)
        .on("touchend.brush", null)
        .on("keydown.brush", null)
        .on("keyup.brush", null);

      dragRestore();
      event_({'type': "brushend"});
    }
  }

  void set x(z) {
    x = z;
    resizes = brushResizes[!x << 1 | !y]; // fore!
  }

  void y(z) {
    y = z;
    resizes = brushResizes[!x << 1 | !y]; // fore!
  }

  get clamp {
    return x && y ? [xClamp, yClamp] : x ? xClamp : y ? yClamp : null;
  }

  void set clamp(z) {
    if (x && y) {
      xClamp = !!z[0];
      yClamp = !!z[1];
    } else if (x) {
      xClamp = !!z;
    } else if (y) {
      yClamp = !!z;
    }
  }

  get extent {
    var x0, x1, y0, y1, t;

    // Invert the pixel extent to data-space.
    if (x) {
      if (xExtentDomain) {
        x0 = xExtentDomain[0]; x1 = xExtentDomain[1];
      } else {
        x0 = xExtent[0]; x1 = xExtent[1];
        if (x.invert) {
          x0 = x.invert(x0);
          x1 = x.invert(x1);
        }
        if (x1 < x0) {
          t = x0;
          x0 = x1;
          x1 = t;
        }
      }
    }
    if (y) {
      if (yExtentDomain) {
        y0 = yExtentDomain[0];
        y1 = yExtentDomain[1];
      } else {
        y0 = yExtent[0];
        y1 = yExtent[1];
        if (y.invert) {
          y0 = y.invert(y0);
          y1 = y.invert(y1);
        }
        if (y1 < y0) {
          t = y0;
          y0 = y1;
          y1 = t;
        }
      }
    }
    return x && y ? [[x0, y0], [x1, y1]] : x ? [x0, x1] : y && [y0, y1];
  }

  void set extent(z) {
    var x0, x1, y0, y1, t;
    // Scale the data-space extent to pixels.
    if (x) {
      x0 = z[0];
      x1 = z[1];
      if (y) {
        x0 = x0[0];
        x1 = x1[0];
      }
      xExtentDomain = [x0, x1];
      if (x.invert) {
        x0 = x(x0);
        x1 = x(x1);
      }
      if (x1 < x0) {
        t = x0;
        x0 = x1;
        x1 = t;
      }
      if (x0 != xExtent[0] || x1 != xExtent[1]) xExtent = [x0, x1]; // copy-on-write
    }
    if (y) {
      y0 = z[0];
      y1 = z[1];
      if (x) {
        y0 = y0[1];
        y1 = y1[1];
      }
      yExtentDomain = [y0, y1];
      if (y.invert) {
        y0 = y(y0);
        y1 = y(y1);
      }
      if (y1 < y0) {
        t = y0;
        y0 = y1;
        y1 = t;
      }
      if (y0 != yExtent[0] || y1 != yExtent[1]) {
        yExtent = [y0, y1]; // copy-on-write
      }
    }
  }

  clear() {
    if (!brush.empty()) {
      xExtent = [0, 0];
      yExtent = [0, 0]; // copy-on-write
      xExtentDomain = yExtentDomain = null;
    }
    return brush;
  }

  bool empty() {
    return !!x && xExtent[0] == xExtent[1]
        || !!y && yExtent[0] == yExtent[1];
  }
}

final brushCursor = {
  'n': "ns-resize",
  'e': "ew-resize",
  's': "ns-resize",
  'w': "ew-resize",
  'nw': "nwse-resize",
  'ne': "nesw-resize",
  'se': "nwse-resize",
  'sw': "nesw-resize"
};

final brushResizes = [
  ["n", "e", "s", "w", "nw", "ne", "se", "sw"],
  ["e", "w"],
  ["n", "s"],
  []
];
