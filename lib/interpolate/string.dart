part of interpolate;

interpolateString(a, b) {
  int i, // current index
      j, // current index (for coalescing)
      s0 = 0, // start index of current string prefix
      s1 = 0, // end index of current string prefix
      n; // q.length;
  var m, // current match
      s = [], // string constants and placeholders
      q = [], // number interpolators
      o;

  // Coerce inputs to strings.
  a = a.toString(); b = b.toString();

  // Reset our regular expression!
  interpolate_number.lastIndex = 0;

  // Find all numbers in b.
  for (i = 0; m = interpolate_number.exec(b); ++i) {
    if (m.index) {
      s1 = m.index;
      s.add(b.substring(s0, s1));
    }
    q.add(new interpolator(s.length, m[0]));
    s.add(null);
    s0 = interpolate_number.lastIndex;
  }
  if (s0 < b.length) s.add(b.substring(s0));

  // Find all numbers in a.
  n = q.length;
  for (i = 0; (m = interpolate_number.exec(a)) && i < n; ++i) {
    o = q[i];
    if (o.x == m[0]) { // The numbers match, so coalesce.
      if (o.i) {
        if (s[o.i + 1] == null) { // This match is followed by another number.
          s[o.i - 1] += o.x;
          s.removeRange(o.i, o.i + 1);
          for (j = i + 1; j < n; ++j) q[j].i--;
        } else { // This match is followed by a string, so coalesce twice.
          s[o.i - 1] += o.x + s[o.i + 1];
          s.removeRange(o.i, o.i + 2);
          for (j = i + 1; j < n; ++j) q[j].i -= 2;
        }
      } else {
          if (s[o.i + 1] == null) { // This match is followed by another number.
          s[o.i] = o.x;
        } else { // This match is followed by a string, so coalesce twice.
          s[o.i] = o.x + s[o.i + 1];
          s.removeRange(o.i + 1, o.i + 2);
          for (j = i + 1; j < n; ++j) q[j].i--;
        }
      }
      q.removeRange(i, i + 1);
      n--;
      i--;
    } else {
      o.x = interpolateNumber(double.parse(m[0]), double.parse(o.x));
    }
  }

  // Remove any numbers in b not found in a.
  while (i < n) {
    o = q.removeLast();
    if (s[o.i + 1] == null) { // This match is followed by another number.
      s[o.i] = o.x;
    } else { // This match is followed by a string, so coalesce twice.
      s[o.i] = o.x + s[o.i + 1];
      s.removeRange(o.i + 1, o.i + 2);
    }
    n--;
  }

  // Special optimization for only a single match.
  if (s.length == 1) {
    if (s[0] == null) {
      o = q[0].x;
      return (t) { return o(t) + ""; };
    }
    return () { return b; };
  }

  // Otherwise, interpolate each of the numbers and rejoin the string.
  return (t) {
    for (i = 0; i < n; ++i) s[(o = q[i]).i] = o.x(t);
    return s.join("");
  };
}

var interpolate_number = "[-+]?(?:\d+\.?\d*|\.?\d+)(?:[eE][-+]?\d+)?"/*g*/;

class interpolator {
  int i;
  var x;
  interpolator(this.i, this.x);
}