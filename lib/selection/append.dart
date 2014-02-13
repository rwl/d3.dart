part of selection;

elementFunction creator(String name) {
  final qualified = core.qualify(name);
  elementFunction fn;
  if (qualified.space != null) {
    fn = (final Element node, _d, _i, _j) {
      return node.ownerDocument.createElementNS(qualified.space, qualified.local);
    };
  } else {
    fn = (final Element node, _d, _i, _j) {
      return node.ownerDocument.createElementNS(node.namespaceUri, qualified.local);
    };
  }
  return fn;
}