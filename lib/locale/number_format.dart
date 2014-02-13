part of d3.locale;

// [[fill]align][sign][symbol][0][width][,][.precision][type]
var format_re = new RegExp(r"(?:([^{])?([<>=^]))?([+\- ])?([$#])?(0)?(\d+)?(,)?(\.-?\d+)?([a-z%])?",
    caseSensitive:false);
