part of d3.event;

mouse(container) {
  return mousePoint(container, eventSource());
}

// https://bugs.webkit.org/show_bug.cgi?id=44083
var mouse_bug44083 = r'WebKit'.contains(window.navigator.userAgent) ? -1 : 0;

mousePoint(container, e) {
  if (e.changedTouches) e = e.changedTouches[0];
  var svg = container.ownerSVGElement || container;
  if (svg.createSVGPoint) {
    var point = svg.createSVGPoint();
    if (mouse_bug44083 < 0 && (window.scrollX || window.scrollY)) {
      svg = select("body").append("svg").style({
        'position': "absolute",
        'top': 0,
        'left': 0,
        'margin': 0,
        'padding': 0,
        'border': "none"
      }, "important");
      var ctm = svg[0][0].getScreenCTM();
      mouse_bug44083 = !(ctm.f || ctm.e);
      svg.remove();
    }
    if (mouse_bug44083) {
      point.x = e.pageX;
      point.y = e.pageY;
    } else {
      point.x = e.clientX;
      point.y = e.clientY;
    }
    point = point.matrixTransform(container.getScreenCTM().inverse());
    return [point.x, point.y];
  }
  var rect = container.getBoundingClientRect();
  return [e.clientX - rect.left - container.clientLeft, e.clientY - rect.top - container.clientTop];
}
