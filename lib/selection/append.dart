part of selection;

creator(name) {
  if (name is Function) {
    return utils.relaxFnArgs(name);
  } else {
    name = core.qualify(name);
    if (name is core.Name) {
      return (node, data, i, j) { return node.ownerDocument.createElementNS(name.space, name.local); };
    }
    return (node, data, i, j) { return node.ownerDocument.createElementNS(node.namespaceUri, name); };
  }
}
