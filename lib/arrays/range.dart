part of arrays;

List range(num start, [num stop=null, num step=1]) {
  if (stop == null) {
    stop = start;
    start = 0;
  }
  if ((stop - start) / step == double.INFINITY) {
    throw new Error();//"infinite range");
  }
  final range = [];
  int k = integerScale(step.abs());
  int i = -1;
  int j;
  start *= k; stop *= k; step *= k;
  if (step < 0) {
    while ((j = start + step * ++i) > stop) range.add(j / k);
  } else {
    while ((j = start + step * ++i) < stop) range.add(j / k);
  }
  return range;
}

int integerScale(x) {
  int k = 1;
  while (x * k % 1 != 0) k *= 10;
  return k;
}
