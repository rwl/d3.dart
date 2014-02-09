part of core;

var nsPrefix = {
  "svg": "http://www.w3.org/2000/svg",
  "xhtml": "http://www.w3.org/1999/xhtml",
  "xlink": "http://www.w3.org/1999/xlink",
  "xml": "http://www.w3.org/XML/1998/namespace",
  "xmlns": "http://www.w3.org/2000/xmlns/"
};

Name qualify(name) {
  var i = name.indexOf(":"),
      prefix = name;
  if (i >= 0) {
    prefix = name.substring(0, i);
    name = name.substring(i + 1);
  }
  return nsPrefix.containsKey(prefix)
      ? new Name(nsPrefix[prefix], name)
      : new Name(null, name);
}

class Name {
  String space, local;
  Name(this.space, this.local);
}
