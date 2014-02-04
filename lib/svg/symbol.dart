part of d3.svg;

class Symbol {
  Function type = symbolType;

  // size of symbol in square pixels
  Function size = symbolSize;

  symbol(d, i) {
    return (symbols.get(type(this, d, i)) || symbolCircle)
        (size.call(this, d, i));
  }
}

symbolSize() {
  return 64;
}

symbolType() {
  return "circle";
}

symbolCircle(size) {
  var r = math.sqrt(size / pi);
  return "M0," + r
      + "A" + r + "," + r + " 0 1,1 0," + (-r)
      + "A" + r + "," + r + " 0 1,1 0," + r
      + "Z";
}

final symbols = {
  "circle": symbolCircle,
  "cross": (size) {
    var r = math.sqrt(size / 5) / 2;
    return "M" + -3 * r + "," + -r
        + "H" + -r
        + "V" + -3 * r
        + "H" + r
        + "V" + -r
        + "H" + 3 * r
        + "V" + r
        + "H" + r
        + "V" + 3 * r
        + "H" + -r
        + "V" + r
        + "H" + -3 * r
        + "Z";
  },
  "diamond": (size) {
    var ry = math.sqrt(size / (2 * symbolTan30)),
        rx = ry * symbolTan30;
    return "M0," + -ry
        + "L" + rx + ",0"
        + " 0," + ry
        + " " + -rx + ",0"
        + "Z";
  },
  "square": (size) {
    var r = math.sqrt(size) / 2;
    return "M" + -r + "," + -r
        + "L" + r + "," + -r
        + " " + r + "," + r
        + " " + -r + "," + r
        + "Z";
  },
  "triangle-down": (size) {
    var rx = math.sqrt(size / symbolSqrt3),
        ry = rx * symbolSqrt3 / 2;
    return "M0," + ry
        + "L" + rx +"," + -ry
        + " " + -rx + "," + -ry
        + "Z";
  },
  "triangle-up": (size) {
    var rx = math.sqrt(size / symbolSqrt3),
        ry = rx * symbolSqrt3 / 2;
    return "M0," + -ry
        + "L" + rx +"," + ry
        + " " + -rx + "," + ry
        + "Z";
  }
};

final symbolTypes = symbols.keys;

var symbolSqrt3 = math.sqrt(3),
    symbolTan30 = math.tan(30 * radians);
