part of d3.event;

var dragSelect = null;//"onselectstart" in document ? null : d3_vendorSymbol(d3_documentElement.style, "userSelect");
var dragId = 0;

dragSuppress() {
  var name = ".dragsuppress-" + ++dragId;
  var click = "click" + name;
  var w = select(window)
          .on("touchmove" + name, eventPreventDefault)
          .on("dragstart" + name, eventPreventDefault)
          .on("selectstart" + name, eventPreventDefault);
  if (dragSelect != null) {
    var style = documentElement.style;
    var select = style[dragSelect];
    style[dragSelect] = "none";
  }
  return (suppressClick) {
    w.on(name, null);
    if (dragSelect) {
      style[dragSelect] = select;
    }
    if (suppressClick) { // suppress the next click, but only if it’s immediate
      off() { w.on(click, null); }
      w.on(click, () { eventPreventDefault(); off(); }, true);
      setTimeout(off, 0);
    }
  };
}
