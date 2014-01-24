part of selection;

creator(name) {
  if (name is Function) {
    return utils.relaxFn4Args(name);
  } else {
    name = core.qualify(name);
    if (name is core.Name) {
      return (Element node, data, int i, int j) {
        return node.ownerDocument.createElementNS(name.space, name.local);
      };
    }
    return (Element node, data, int i, int j) {
      return node.ownerDocument.createElementNS(node.namespaceUri, name);
    };
  }
}
