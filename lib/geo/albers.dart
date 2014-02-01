part of d3.geo;

// ESRI:102003
albers() {
  return conicEqualArea()
      .rotate([96, 0])
      .center([-.6, 38.7])
      .parallels([29.5, 45.5])
      .scale(1070);
}
