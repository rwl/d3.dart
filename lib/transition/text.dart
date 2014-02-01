part of d3.transition;

transition_text(node, b) {
  if (b == null) b = "";
  return () { node.text = b; };
}
