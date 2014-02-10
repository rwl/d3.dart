part of arrays;

max(List array, [Function f = null]) {
  Object m = null;
  array.forEach((element) {
    if (f != null) {
      element = f(element);
    }
    if (m == null || (element != null && element.compareTo(m) > 0)) {
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
