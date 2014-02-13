part of arrays;

range(start, [stop=null, step=1]) {
  if (stop == null) {
    stop = start;
    start = 0;
  }
  if ((stop - start) / step == double.INFINITY) {
    throw new Error();//"infinite range");
  }
  var range = [],
       k = integerScale(step.abs()),
       i = -1,
       j;
  start *= k; stop *= k; step *= k;
  if (step < 0) {
    while ((j = start + step * ++i) > stop) range.add(j / k);
  } else {
    while ((j = start + step * ++i) < stop) range.add(j / k);
  }
  return range;
}

integerScale(x) {
  var k = 1;
  while (x * k % 1 != 0) k *= 10;
  return k;
}
