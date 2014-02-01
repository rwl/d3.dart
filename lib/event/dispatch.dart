part of d3.event;

dispatch() {
  var dispatch = new Dispatch();
  int i = -1;
  int n = arguments.length;
  while (++i < n) {
    dispatch[arguments[i]] = dispatch_event(dispatch);
  }
  return dispatch;
}

class Dispatch {
  on(type, [listener=unique]) {
    int i = type.indexOf(".");
    String name = "";

    // Extract optional namespace, e.g., "click.foo"
    if (i >= 0) {
      name = type.substring(i + 1);
      type = type.substring(0, i);
    }

    if (type) {
      if (listener == null) {
        return this[type].on(name);
      } else {
        return this[type].on(name, listener);
      }
    }

    if (listener != unique) {
      if (listener == null) {
        for (type in this) {
          if (this.hasOwnProperty(type)) {
            this[type].on(name, null);
          }
        }
      }
      return this;
    }
  }
}

dispatch_event(dispatch) {
  var listeners = [],
      listenerByName = new Map();

  event(thiz) {
    var z = listeners, // defensive reference
        i = -1,
        n = z.length,
        l;
    while (++i < n) {
      l = z[i].on;
      if (l != null) {
        l.apply(thiz, arguments);
      }
    }
    return dispatch;
  }

  event.on = (name, [listener=null]) {
    var l = listenerByName.get(name);
    int i;

    // return the current listener, if any
    if (listener == null) {
      return l && l.on;
    }

    // remove the old listener, if any (with copy-on-write)
    if (l) {
      l.on = null;
      listeners = listeners.slice(0, i = listeners.indexOf(l)).concat(listeners.slice(i + 1));
      listenerByName.remove(name);
    }

    // add the new listener, if any
    if (listener) listeners.add(listenerByName.set(name, {'on': listener}));

    return dispatch;
  };

  return event;
}
