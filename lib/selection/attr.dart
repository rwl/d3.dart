part of selection;

attrFunc(name, value) {
  name = core.qualify(name);

  // For attr(string, null), remove the attribute with the specified name.
  attrNull(node, data, i, j) {
    node.attributes.remove(name);
  }
  attrNullNS(node, data, i, j) {
    node.getNamespacedAttributes(name.space).remove(name.local);
  }

  // For attr(string, string), set the attribute with the specified name.
  attrConstant(node, data, i, j) {
    node.setAttribute(name, value.toString());
  }
  attrConstantNS(node, data, i, j) {
    node.setAttributeNS(name.space, name.local, value.toString());
  }

  // For attr(string, function), evaluate the function for each element, and set
  // or remove the attribute as appropriate.
  attrFunction(node, data, i, j) {
    var x = value(node, data, i, j);
    if (x == null) node.attributes.remove(name);
    else node.setAttribute(name, x);
  }
  attrFunctionNS(node, data, i, j) {
    var x = value(node, data, i, j);
    if (x == null) node.getNamespacedAttributes(name.space).remove(name.local);
    else node.setAttributeNS(name.space, name.local, x);
  }

  return value == null
      ? (name is core.Name ? attrNullNS : attrNull) : (value is Function
      ? (name is core.Name ? attrFunctionNS : attrFunction)
      : (name is core.Name ? attrConstantNS : attrConstant));
}
