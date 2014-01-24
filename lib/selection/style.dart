part of selection;

styleNode(name, value, priority) {

  // For style(name, null) or style(name, null, priority), remove the style
  // property with the specified name. The priority is ignored.
  styleNull(node) {
    node.style.removeProperty(name);
  }

  // For style(name, string) or style(name, string, priority), set the style
  // property with the specified name, using the specified priority.
  styleConstant(node) {
    node.style.setProperty(name, value, priority);
  }

  // For style(name, function) or style(name, function, priority), evaluate the
  // function for each element, and set or remove the style property as
  // appropriate. When setting, use the specified priority.
  styleFunction(node, data, i, j) {
    utils.FnWith4Args fnWith4Args = utils.relaxFn4Args(value);
    var x = fnWith4Args(node, data, i, j);
    if (x == null) {
      node.style.removeProperty(name);
    } else {
      node.style.setProperty(name, x, priority);
    }
  }

  return value == null
      ? styleNull : (value is Function
      ? styleFunction : styleConstant);
}
