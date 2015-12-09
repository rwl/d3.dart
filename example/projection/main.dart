import 'dart:async';
import 'dart:math' as math;
import 'package:d3/d3.dart';

final r = new math.Random();

main() {
  var width = 960, height = 500;

  var options = [
    {
      'name': "Albers",
      'projection': albers().scale(145).parallels([20, 50])
    },
    {
      'name': "Albers USA",
      'projection': albersUsa().scale(145).parallels([20, 50])
    },
    {
      'name': "Azimuthal Equal-Area",
      'projection': azimuthalEqualArea().scale(100)
    },
    {
      'name': "Azimuthal Equidistant",
      'projection': azimuthalEquidistant().scale(100)
    },
    {'name': "Conic Conformal", 'projection': conicConformal().scale(100)},
    {
      'name': "Conic Equal-Area (a.k.a. Albers)",
      'projection': conicEqualArea().scale(100)
    },
    {'name': "Conic Equidistant", 'projection': conicEquidistant().scale(100)},
    {'name': "Equirectangular (Plate Carrée)", 'projection': equirectangular()},
    {'name': "Gnomonic", 'projection': gnomonic()},
    {'name': "Mercator", 'projection': mercator().scale(490 / 2 / math.PI)},
    {'name': "Azimuthal Orthographic", 'projection': orthographic()},
    {'name': "Azimuthal Stereographic", 'projection': stereographic()},
    {
      'name': "Transverse Mercator",
      'projection': transverseMercator().scale(490 / 2 / math.PI)
    }
  ];

  options.forEach((o) {
    o.projection.rotate([0, 0]).center([0, 0]);
  });

  var i = 0, n = options.length - 1;

  var projection = options[i].projection;

  var path = new Path().projection(projection);

  var graticule = new Graticule();

  var svg = new Selection("body")
      .append("svg")
      .attr("width", width)
      .attr("height", height);

  svg.append("defs").append("path").datum({'type': "Sphere"})
      .attr("id", "sphere")
      .attr("d", path);

  svg.append("use").attr("class", "stroke").attr("xlink:href", "#sphere");

  svg.append("use").attr("class", "fill").attr("xlink:href", "#sphere");

  svg
      .append("path")
      .datum(graticule)
      .attr("class", "graticule")
      .attr("d", path);

  new Xhr.json("world-110m.json", (error, world) {
    if (error) throw error;

    svg
        .insert("path", ".graticule")
        .datum(topojson.feature(world, world.objects.land))
        .attr("class", "land")
        .attr("d", path);
  });

  var menu = new Selection("#projection-menu");

  menu
      .selectAll("option")
      .data(options)
      .enter()
      .append("option")
      .text((d) => d.name);

  projectionTween(projection0, projection1) {
    return (d) {
      var t = 0;

      project(lmbda, phi) {
        lmbda *= 180 / math.PI;
        phi *= 180 / math.PI;
        var p0 = projection0([lmbda, phi]);
        var p1 = projection1([lmbda, phi]);
        return [(1 - t) * p0[0] + t * p1[0], (1 - t) * -p0[1] + t * -p1[1]];
      }

      var projection =
          new Projection(project).scale(1).translate([width / 2, height / 2]);

      var path = new Path().projection(projection);

      return (_) {
        t = _;
        return path(d);
      };
    };
  }

  update(option) {
    svg.selectAll("path").transition().duration(750).attrTween(
        "d", projectionTween(projection, projection = option.projection));
  }

  var timer = new Timer.periodic(const Duration(milliseconds: 1500), (_) {
    var j = (r.nextDouble() * n).floor();
    menu.property("selectedIndex", i = j + (j >= i));
    update(options[i]);
  });

  menu.on("change", (elem, data, i) {
    timer.cancel();
    update(options[elem.selectedIndex]);
  });
}
