part of d3.event;

touches(container, [touches=null]) {
  if (touches == null) {
    touches = eventSource().touches;
  }
  return touches != null ? new List.from(touches).map((touch) {
    var point = mousePoint(container, touch);
    point.identifier = touch.identifier;
    return point;
  }) : [];
}
