part of arrays;

bisectLeft(List a, x, {int lo: 0, int hi: null, f(List a, x, int mid): null}) {
  if (hi == null) {
    hi = a.length;
  }
  if (f == null) {
    f = (List a, x, int mid) { return x; };
  }
  while (lo < hi) {
    var mid = lo + hi >> 1;
    if (f(a, a[mid], mid) < x) {
      lo = mid + 1;
    } else {
      hi = mid;
    }
  }
  return lo;
}

bisectRight(a, x, {int lo: 0, int hi: null, f(List a, x, int mid): null}) {
  if (hi == null) {
    hi = a.length;
  }
  if (f == null) {
    f = (List a, x, int mid) { return x; };
  }
  while (lo < hi) {
    var mid = lo + hi >> 1;
    if (x < f(a, a[mid], mid)) {
      hi = mid;
    } else {
      lo = mid + 1;
    }
  }
  return lo;
}

bisect(a, x, {int lo: 0, int hi: null, f(List a, x, int mid): null}) {
  return bisectRight(a, x, lo: lo, hi: hi, f: f);
}