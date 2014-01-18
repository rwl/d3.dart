part of arrays;

max(List array, [Function f = null]) {
  var m = array.reduce((value, element) {
    if (element.compareTo(value) > 0) {
      return element;
    }
    return value;
  });
  return m;
}
