part of selection;

selector(s) {
  if (s is Function) {
    return utils.relaxFn4Args(s);
  }
  return (node, data, i, j) {
    return node.querySelector(s);
  };
}

selectorAll(s) {
  return s is Function ? utils.relaxFn4Args(s) : (node, d, i, j) {
    return node.querySelectorAll(s);
  };
}
