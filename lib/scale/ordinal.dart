part of scale;

ordinal() {
  return new Ordinal([], new Ranger("range", [[]]));
}

class Ordinal {
  List domain;
  Ranger ranger;

  List _index, _range;
  int _rangeBand;
  
  Ordinal(this.domain, this.ranger);

  /*scale(x) {
    return _range[((_index[x] || ranger.t == "range" && _index[x] = _domain.add(x)) - 1) % range.length];
  }

  List get range => _range;
  
  void set range(List x) {
    _range = x;
    _rangeBand = 0;
    ranger = new Ranger("range", x);
    return scale;
  }*/
}

class Ranger {
  String t;
  List a;
  
  Ranger(this.t, this.a); 
}