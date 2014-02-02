part of d3.geo;

// A composite projection for the United States, configured by default for
// 960×500. Also works quite well at 960×600 with scale 1285. The set of
// standard parallels for each region comes from USGS, which is published here:
// http://egsc.usgs.gov/isb/pubs/MapProjections/projections.html#albers
class AlbersUsa {
  var lower48 = albers();

  // EPSG:3338
  var alaska = conicEqualArea()
      .rotate([154, 0])
      .center([-2, 58.5])
      .parallels([55, 65]);

  // ESRI:102007
  var hawaii = conicEqualArea()
      .rotate([157, 0])
      .center([-3, 19.9])
      .parallels([8, 18]);

  var point,
      pointStream,
      lower48Point,
      alaskaPoint,
      hawaiiPoint;

  AlbersUsa() {
    this.pointStream = {'point': (x, y) { point = [x, y]; }};
    albersUsa.scale(1070);
  }

  albersUsa(coordinates) {
    var x = coordinates[0], y = coordinates[1];
    point = null;
    (lower48Point(x, y), point)
        || (alaskaPoint(x, y), point)
        || hawaiiPoint(x, y);
    return point;
  }

  invert(coordinates) {
    var k = lower48.scale(),
        t = lower48.translate(),
        x = (coordinates[0] - t[0]) / k,
        y = (coordinates[1] - t[1]) / k;
    return (y >= .120 && y < .234 && x >= -.425 && x < -.214 ? alaska
        : y >= .166 && y < .234 && x >= -.214 && x < -.115 ? hawaii
        : lower48).invert(coordinates);
  }

  // A naïve multi-projection stream.
  // The projections must have mutually exclusive clip regions on the sphere,
  // as this will avoid emitting interleaving lines and polygons.
  stream(stream) {
    var lower48Stream = lower48.stream(stream),
        alaskaStream = alaska.stream(stream),
        hawaiiStream = hawaii.stream(stream);
    return {
      'point': (x, y) {
        lower48Stream.point(x, y);
        alaskaStream.point(x, y);
        hawaiiStream.point(x, y);
      },
      'sphere': () {
        lower48Stream.sphere();
        alaskaStream.sphere();
        hawaiiStream.sphere();
      },
      'lineStart': () {
        lower48Stream.lineStart();
        alaskaStream.lineStart();
        hawaiiStream.lineStart();
      },
      'lineEnd': () {
        lower48Stream.lineEnd();
        alaskaStream.lineEnd();
        hawaiiStream.lineEnd();
      },
      'polygonStart': () {
        lower48Stream.polygonStart();
        alaskaStream.polygonStart();
        hawaiiStream.polygonStart();
      },
      'polygonEnd': () {
        lower48Stream.polygonEnd();
        alaskaStream.polygonEnd();
        hawaiiStream.polygonEnd();
      }
    };
  }

  precision([arg=null]) {
    if (arg == null) return lower48.precision();
    lower48.precision(arg);
    alaska.precision(arg);
    hawaii.precision(arg);
    return albersUsa;
  }

  scale([arg=null]) {
    if (arg == null) return lower48.scale();
    lower48.scale(arg);
    alaska.scale(arg * .35);
    hawaii.scale(arg);
    return albersUsa.translate(lower48.translate());
  }

  translate([arg=null]) {
    if (arg==null) return lower48.translate();
    var k = lower48.scale(), x = toDouble(arg[0]), y = toDouble(arg[1]);

    lower48Point = lower48
        .translate(arg)
        .clipExtent([[x - .455 * k, y - .238 * k], [x + .455 * k, y + .238 * k]])
        .stream(pointStream).point;

    alaskaPoint = alaska
        .translate([x - .307 * k, y + .201 * k])
        .clipExtent([[x - .425 * k + epsilon, y + .120 * k + epsilon], [x - .214 * k - epsilon, y + .234 * k - epsilon]])
        .stream(pointStream).point;

    hawaiiPoint = hawaii
        .translate([x - .205 * k, y + .212 * k])
        .clipExtent([[x - .214 * k + epsilon, y + .166 * k + epsilon], [x - .115 * k - epsilon, y + .234 * k - epsilon]])
        .stream(pointStream).point;

    return albersUsa;
  }
}