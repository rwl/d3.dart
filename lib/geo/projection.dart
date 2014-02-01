part of d3.geo;

projection(project) {
  return new ProjectionMutator(() { return project; })();
}

class ProjectionMutator {

  var project,
      rotate,
      projectRotate,
      projectResample,
      k = 150, // scale
      x = 480, y = 250, // translate
      lambda = 0, phi = 0, // center
      sigmalambda = 0, sigmaphi = 0, sigmagamma = 0, // rotate
      sigmax, sigmay, // center
      preclip = clipAntimeridian,
      postclip = core.identity,
      clipAngle = null,
      clipExtent = null,
      stream;

  var projectAt;

  ProjectionMutator(this.projectAt) {
    this.projectResample = resample((x, y) {
      x = project(x, y);
      return [x[0] * k + sigmax, sigmay - x[1] * k];
    });
  }

  projection(point) {
    point = projectRotate(point[0] * radians, point[1] * radians);
    return [point[0] * k + sigmax, sigmay - point[1] * k];
  }

  invert(point) {
    point = projectRotate.invert((point[0] - sigmax) / k, (sigmay - point[1]) / k);
    return point && [point[0] * degrees, point[1] * degrees];
  }

  stream(output) {
    if (stream) {
      stream.valid = false;
    }
    stream = projectionRadians(preclip(rotate, projectResample(postclip(output))));
    stream.valid = true; // allow caching by d3.geo.path
    return stream;
  }

  clipAngle([arg=unique]) {
    if (arg == unique) return clipAngle;
    if (arg == null) {
      clipAngle = clipAntimeridian;
    } else {
      clipCircle((clipAngle = toDouble(arg)) * radians);
    }
    return invalidate();
  }

  clipExtent([arg=null]) {
    if (arg == null) return clipExtent;
    clipExtent = arg;
    postclip = arg != null ? geo_clipExtent(arg[0][0], arg[0][1], arg[1][0], arg[1][1]) : core.identity;
    return invalidate();
  }

  scale([arg=null]) {
    if (arg == null) return k;
    k = toDouble(arg);
    return reset();
  }

  translate([arg=null]) {
    if (arg == null) return [x, y];
    x = toDouble(arg[0]);
    y = toDouble(arg[1]);
    return reset();
  }

  center([arg=null]) {
    if (arg == null) return [lambda * degrees, phi * degrees];
    lambda = _[0] % 360 * radians;
    phi = _[1] % 360 * radians;
    return reset();
  }

  rotate([arg=null]) {
    if (arg == null) return [sigmalambda * degrees, sigmaphi * degrees, sigmagamma * degrees];
    sigmalambda = arg[0] % 360 * radians;
    sigmaphi = arg[1] % 360 * radians;
    sigmagamma = arg.length > 2 ? arg[2] % 360 * radians : 0;
    return reset();
  }

//  d3.rebind(projection, projectResample, "precision");

  reset() {
    projectRotate = compose(rotate = rotation(sigmalambda, sigmaphi, sigmagamma), project);
    var center = project(lambda, phi);
    sigmax = x - center[0] * k;
    sigmay = y + center[1] * k;
    return invalidate();
  }

  invalidate() {
    if (stream != null) {
      stream.valid = false;
      stream = null;
    }
    return projection;
  }

  call() {
    project = projectAt.apply(this, arguments);
    projection.invert = project.invert && invert;
    return reset();
  }
}

projectionRadians(stream) {
  return transformPoint(stream, (x, y) {
    stream.point(x * radians, y * radians);
  });
}
