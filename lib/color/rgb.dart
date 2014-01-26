part of color;

rgb(r, [g = null, b = null]) {
  if (g == null && b == null) {
    if (r is Rgb) {
      return new Rgb.from(r);
    }
    return parse(r.toString(), new_rgb, hsl_rgb);
  }

  int rr = (r is int) ? r : (r is String) ? int.parse(r) : r.floor();
  int gg = (g is int) ? g : (g is String) ? int.parse(g) : g.floor();
  int bb = (b is int) ? b : (b is String) ? int.parse(b) : b.floor();
  return new Rgb(rr, gg, bb);
}

Rgb rgbNumber(int value) {
  return new Rgb(value >> 16, value >> 8 & 0xff, value & 0xff);
}

String rgbString(int value) {
  return rgbNumber(value).toString();
}

Rgb new_rgb(int r, int g, int b) {
  return new Rgb(r, g, b);
}

class Rgb extends Color {
  int r, g, b;

  Rgb(this.r, this.g, this.b);

  factory Rgb.from(Rgb other) {
    return new Rgb(other.r, other.g, other.b);
  }

  Rgb brighter([num k = 1]) {
    k = math.pow(0.7, k);
    var r = this.r,
        g = this.g,
        b = this.b,
        i = 30;
    if (r == 0 && g == 0 && b == 0) return new Rgb(i, i, i);
    if (r != 0 && r < i) r = i;
    if (g != 0 && g < i) g = i;
    if (b != 0 && b < i) b = i;
    return new Rgb(math.min(255, (r / k).floor()), math.min(255, (g / k).floor()), math.min(255, (b / k).floor()));
  }

  Rgb darker([num k = 1]) {
    k = math.pow(0.7, k);
    return new Rgb((k * this.r).floor(), (k * this.g).floor(), (k * this.b).floor());
  }

  Hsl hsl() {
    return rgb_hsl(this.r, this.g, this.b);
  }

  String toString() {
    return "#" + rgb_hex(this.r) + rgb_hex(this.g) + rgb_hex(this.b);
  }
}

String rgb_hex(int v) {
  return v < 0x10
      ? "0" + math.max(0, v).toInt().toRadixString(16)
          : math.min(255, v).toInt().toRadixString(16);
}

final color_expr = new RegExp(r"([a-z]+)\((.*)\)", caseSensitive:true);

parse(format, Function rgbFn, Function hslFn) {
  var r = 0, // red channel; int in [0, 255]
      g = 0, // green channel; int in [0, 255]
      b = 0, // blue channel; int in [0, 255]
      m1, // CSS color specification match
      m2, // CSS color specification type (e.g., rgb)
      name;

  /* Handle hsl, rgb. */
  m1 = color_expr.firstMatch(format);
  if (m1 != null) {
    m2 = m1[2].split(",");
    switch (m1[1]) {
      case "hsl":
        return hslFn(
          double.parse(m2[0]), // degrees
          parseNumberPct(m2[1]) / 100.0, // percentage
          parseNumberPct(m2[2]) / 100.0 // percentage
        );
      case "rgb":
        return rgbFn(
          parseNumber(m2[0]),
          parseNumber(m2[1]),
          parseNumber(m2[2])
        );
    }
  }

  /* Named colors. */
  if (rgb_names.containsKey(format)) {
    Rgb named = rgb_names[format];
    return rgbFn(named.r, named.g, named.b);
  }

  /* Hexadecimal colors: #rgb and #rrggbb. */
  if (format != null && format[0] == "#") {
    if (format.length == 4) {
      r = format[1]; r += r;
      g = format[2]; g += g;
      b = format[3]; b += b;
    } else if (format.length == 7) {
      r = format.substring(1, 3);
      g = format.substring(3, 5);
      b = format.substring(5, 7);
    }
    r = int.parse(r, radix:16);
    g = int.parse(g, radix:16);
    b = int.parse(b, radix:16);
  }

  return rgbFn(r, g, b);
}

Hsl rgb_hsl(r, g, b) {
  var min = math.min(r /= 255, math.min(g /= 255, b /= 255)),
      max = math.max(r, math.max(g, b)),
      d = max - min,
      h,
      s,
      l = (max + min) / 2;
  if (d != 0) {
    s = l < .5 ? d / (max + min) : d / (2 - max - min);
    if (r == max) h = (g - b) / d + (g < b ? 6 : 0);
    else if (g == max) h = (b - r) / d + 2;
    else h = (r - g) / d + 4;
    h *= 60;
  } else {
    h = double.NAN;
    s = l > 0 && l < 1 ? 0 : h;
  }
  return new Hsl(h, s, l);
}

int parseNumber(String c) { // either integer or percentage
  if (c[c.length - 1] == "%") {
    return (double.parse(c.substring(0, c.length - 1)) * 2.55).round();
  } else {
    return double.parse(c).round();
  }
}

parseNumberPct(String c) {
  if (c[c.length - 1] == "%") {
    return double.parse(c.substring(0, c.length - 1));
  } else {
    return double.parse(c);
  }
}

final Map<String, Rgb> rgb_names = {
  "aliceblue": rgbNumber(0xf0f8ff),
  "antiquewhite": rgbNumber(0xfaebd7),
  "aqua": rgbNumber(0x00ffff),
  "aquamarine": rgbNumber(0x7fffd4),
  "azure": rgbNumber(0xf0ffff),
  "beige": rgbNumber(0xf5f5dc),
  "bisque": rgbNumber(0xffe4c4),
  "black": rgbNumber(0x000000),
  "blanchedalmond": rgbNumber(0xffebcd),
  "blue": rgbNumber(0x0000ff),
  "blueviolet": rgbNumber(0x8a2be2),
  "brown": rgbNumber(0xa52a2a),
  "burlywood": rgbNumber(0xdeb887),
  "cadetblue": rgbNumber(0x5f9ea0),
  "chartreuse": rgbNumber(0x7fff00),
  "chocolate": rgbNumber(0xd2691e),
  "coral": rgbNumber(0xff7f50),
  "cornflowerblue": rgbNumber(0x6495ed),
  "cornsilk": rgbNumber(0xfff8dc),
  "crimson": rgbNumber(0xdc143c),
  "cyan": rgbNumber(0x00ffff),
  "darkblue": rgbNumber(0x00008b),
  "darkcyan": rgbNumber(0x008b8b),
  "darkgoldenrod": rgbNumber(0xb8860b),
  "darkgray": rgbNumber(0xa9a9a9),
  "darkgreen": rgbNumber(0x006400),
  "darkgrey": rgbNumber(0xa9a9a9),
  "darkkhaki": rgbNumber(0xbdb76b),
  "darkmagenta": rgbNumber(0x8b008b),
  "darkolivegreen": rgbNumber(0x556b2f),
  "darkorange": rgbNumber(0xff8c00),
  "darkorchid": rgbNumber(0x9932cc),
  "darkred": rgbNumber(0x8b0000),
  "darksalmon": rgbNumber(0xe9967a),
  "darkseagreen": rgbNumber(0x8fbc8f),
  "darkslateblue": rgbNumber(0x483d8b),
  "darkslategray": rgbNumber(0x2f4f4f),
  "darkslategrey": rgbNumber(0x2f4f4f),
  "darkturquoise": rgbNumber(0x00ced1),
  "darkviolet": rgbNumber(0x9400d3),
  "deeppink": rgbNumber(0xff1493),
  "deepskyblue": rgbNumber(0x00bfff),
  "dimgray": rgbNumber(0x696969),
  "dimgrey": rgbNumber(0x696969),
  "dodgerblue": rgbNumber(0x1e90ff),
  "firebrick": rgbNumber(0xb22222),
  "floralwhite": rgbNumber(0xfffaf0),
  "forestgreen": rgbNumber(0x228b22),
  "fuchsia": rgbNumber(0xff00ff),
  "gainsboro": rgbNumber(0xdcdcdc),
  "ghostwhite": rgbNumber(0xf8f8ff),
  "gold": rgbNumber(0xffd700),
  "goldenrod": rgbNumber(0xdaa520),
  "gray": rgbNumber(0x808080),
  "green": rgbNumber(0x008000),
  "greenyellow": rgbNumber(0xadff2f),
  "grey": rgbNumber(0x808080),
  "honeydew": rgbNumber(0xf0fff0),
  "hotpink": rgbNumber(0xff69b4),
  "indianred": rgbNumber(0xcd5c5c),
  "indigo": rgbNumber(0x4b0082),
  "ivory": rgbNumber(0xfffff0),
  "khaki": rgbNumber(0xf0e68c),
  "lavender": rgbNumber(0xe6e6fa),
  "lavenderblush": rgbNumber(0xfff0f5),
  "lawngreen": rgbNumber(0x7cfc00),
  "lemonchiffon": rgbNumber(0xfffacd),
  "lightblue": rgbNumber(0xadd8e6),
  "lightcoral": rgbNumber(0xf08080),
  "lightcyan": rgbNumber(0xe0ffff),
  "lightgoldenrodyellow": rgbNumber(0xfafad2),
  "lightgray": rgbNumber(0xd3d3d3),
  "lightgreen": rgbNumber(0x90ee90),
  "lightgrey": rgbNumber(0xd3d3d3),
  "lightpink": rgbNumber(0xffb6c1),
  "lightsalmon": rgbNumber(0xffa07a),
  "lightseagreen": rgbNumber(0x20b2aa),
  "lightskyblue": rgbNumber(0x87cefa),
  "lightslategray": rgbNumber(0x778899),
  "lightslategrey": rgbNumber(0x778899),
  "lightsteelblue": rgbNumber(0xb0c4de),
  "lightyellow": rgbNumber(0xffffe0),
  "lime": rgbNumber(0x00ff00),
  "limegreen": rgbNumber(0x32cd32),
  "linen": rgbNumber(0xfaf0e6),
  "magenta": rgbNumber(0xff00ff),
  "maroon": rgbNumber(0x800000),
  "mediumaquamarine": rgbNumber(0x66cdaa),
  "mediumblue": rgbNumber(0x0000cd),
  "mediumorchid": rgbNumber(0xba55d3),
  "mediumpurple": rgbNumber(0x9370db),
  "mediumseagreen": rgbNumber(0x3cb371),
  "mediumslateblue": rgbNumber(0x7b68ee),
  "mediumspringgreen": rgbNumber(0x00fa9a),
  "mediumturquoise": rgbNumber(0x48d1cc),
  "mediumvioletred": rgbNumber(0xc71585),
  "midnightblue": rgbNumber(0x191970),
  "mintcream": rgbNumber(0xf5fffa),
  "mistyrose": rgbNumber(0xffe4e1),
  "moccasin": rgbNumber(0xffe4b5),
  "navajowhite": rgbNumber(0xffdead),
  "navy": rgbNumber(0x000080),
  "oldlace": rgbNumber(0xfdf5e6),
  "olive": rgbNumber(0x808000),
  "olivedrab": rgbNumber(0x6b8e23),
  "orange": rgbNumber(0xffa500),
  "orangered": rgbNumber(0xff4500),
  "orchid": rgbNumber(0xda70d6),
  "palegoldenrod": rgbNumber(0xeee8aa),
  "palegreen": rgbNumber(0x98fb98),
  "paleturquoise": rgbNumber(0xafeeee),
  "palevioletred": rgbNumber(0xdb7093),
  "papayawhip": rgbNumber(0xffefd5),
  "peachpuff": rgbNumber(0xffdab9),
  "peru": rgbNumber(0xcd853f),
  "pink": rgbNumber(0xffc0cb),
  "plum": rgbNumber(0xdda0dd),
  "powderblue": rgbNumber(0xb0e0e6),
  "purple": rgbNumber(0x800080),
  "red": rgbNumber(0xff0000),
  "rosybrown": rgbNumber(0xbc8f8f),
  "royalblue": rgbNumber(0x4169e1),
  "saddlebrown": rgbNumber(0x8b4513),
  "salmon": rgbNumber(0xfa8072),
  "sandybrown": rgbNumber(0xf4a460),
  "seagreen": rgbNumber(0x2e8b57),
  "seashell": rgbNumber(0xfff5ee),
  "sienna": rgbNumber(0xa0522d),
  "silver": rgbNumber(0xc0c0c0),
  "skyblue": rgbNumber(0x87ceeb),
  "slateblue": rgbNumber(0x6a5acd),
  "slategray": rgbNumber(0x708090),
  "slategrey": rgbNumber(0x708090),
  "snow": rgbNumber(0xfffafa),
  "springgreen": rgbNumber(0x00ff7f),
  "steelblue": rgbNumber(0x4682b4),
  "tan": rgbNumber(0xd2b48c),
  "teal": rgbNumber(0x008080),
  "thistle": rgbNumber(0xd8bfd8),
  "tomato": rgbNumber(0xff6347),
  "turquoise": rgbNumber(0x40e0d0),
  "violet": rgbNumber(0xee82ee),
  "wheat": rgbNumber(0xf5deb3),
  "white": rgbNumber(0xffffff),
  "whitesmoke": rgbNumber(0xf5f5f5),
  "yellow": rgbNumber(0xffff00),
  "yellowgreen": rgbNumber(0x9acd32)
};
