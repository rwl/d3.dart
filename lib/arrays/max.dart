part of arrays;

max(List array, [Function f = null]) {
  int i = -1,
      n = array.length;
  var a,
      b;
  if (f == null) {
    while (++i < n && !((a = array[i]) != null && a <= a)) a = null;
    while (++i < n) if ((b = array[i]) != null && b > a) a = b;
  } else {
    while (++i < n && !((a = f.call(array, array[i], i)) != null && a <= a)) a = null;
    while (++i < n) if ((b = f.call(array, array[i], i)) != null && b > a) a = b;
  }
  return a;
}
