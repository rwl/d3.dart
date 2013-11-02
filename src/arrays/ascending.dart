part of arrays;

//ascending(a, b) {
//}

int ascendingInt(int a, int b) {
  return a < b ? -1 : a > b ? 1 : 0;
}

double ascendingDouble(double a, double b) {
  if (a == null || b == null) {
    return double.NAN;
  }
  if (a.isNaN || b.isNaN) {
    return double.NAN;
  }
  return a < b ? -1.0 : a > b ? 1.0 : 0.0;
}

int ascendingString(String a, String b) {
  return a.compareTo(b);
}
