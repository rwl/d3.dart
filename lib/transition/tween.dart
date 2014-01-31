part of d3.transition;

transition_tween(groups, name, value, tween) {
  var id = groupId(groups);
  if (value is Function) {
    return eachGroup(groups, (node, i, j) {
      nodeTransition(node)[id].tween.set(name, tween(value(node, nodeData(node), i, j)));
    });
  } else {
    value = tween(value);
    return eachGroup(groups, (node) {
      nodeTransition(node)[id].tween.set(name, value);
    });
  }
}
