part of selection;

selector(s) {
  if (s is Function) {
    return s;
  }
  return (node, data, i, j) {
    return selectNode(s, node);
  };
}
