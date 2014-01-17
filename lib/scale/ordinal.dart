part of scale;

ordinal() {
  return new Ordinal([], new Ranger("range", [[]]));
}

class Ordinal {
  List domain;
  Ranger ranger;
  
  Ordinal(this.domain, this.ranger);
  
  range(x) {
    if (!arguments.length) return range;
    range = x;
    rangeBand = 0;
    ranger = new Ranger("range", arguments);
    return scale;
  }
}

class Ranger {
  String t;
  List a;
  
  Ranger(this.t, this.a); 
}