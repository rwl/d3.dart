part of arrays;

typedef maxAccessor(d, int i);

max(final List array, [final maxAccessor fn]) {
  Object m = null;
  int i = 0;
  array.forEach((element) {
    if (fn != null) {
      element = fn(element, i);
    }
    i++;
    if (element == null) {
      return;
    } else if (element is num && element.isNaN) {
      return;
    }
    if (m == null || element.compareTo(m) > 0) {
      m = element;
    }
  });
  /*var m = array.reduce((value, element) {
    if (f != null) {
      element = f(element);
    }
    if (element.compareTo(value) > 0) {
      return element;
    }
    return value;
  });*/
  return m;
}
