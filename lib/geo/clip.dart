part of d3.geo;

class Clip {
  Function point = _point;
  Function lineStart = _lineStart;
  Function lineEnd = _lineEnd;

  polygonStart() {
    this.point = _pointRing;
    this.lineStart = _ringStart;
    this.lineEnd = _ringEnd;
    segments = [];
    polygon = [];
    listener.polygonStart();
  }

  polygonEnd() {
    this.point = _point;
    this.lineStart = _lineStart;
    this.lineEnd = _lineEnd;

    segments = arrays.merge(segments);
    var clipStartInside = pointInPolygon(rotatedClipStart, polygon);
    if (segments.length) {
      clipPolygon(segments, clipSort, clipStartInside, interpolate, listener);
    } else if (clipStartInside) {
      listener.lineStart();
      interpolate(null, null, 1, listener);
      listener.lineEnd();
    }
    listener.polygonEnd();
    segments = polygon = null;
  }

  sphere() {
    listener.polygonStart();
    listener.lineStart();
    interpolate(null, null, 1, listener);
    listener.lineEnd();
    listener.polygonEnd();
  }
}

geo_clip(pointVisible, clipLine, interpolate, clipStart) {
  return (rotate, listener) {
    var line = clipLine(listener);
    var rotatedClipStart = rotate.invert(clipStart[0], clipStart[1]);

    var clip = new Clip();

    point(lambda, phi) {
      var point = rotate(lambda, phi);
      if (pointVisible(lambda = point[0], phi = point[1])) listener.point(lambda, phi);
    }

    pointLine(lambda, phi) {
      var point = rotate(lambda, phi);
      line.point(point[0], point[1]);
    }

    lineStart() {
      clip.point = pointLine;
      line.lineStart();
    }

    lineEnd() {
      clip.point = point;
      line.lineEnd();
    }

    var segments;

    var buffer = clipBufferListener(),
        ringListener = clipLine(buffer),
        polygon,
        ring;

    pointRing(lambda, phi) {
      ring.push([lambda, phi]);
      var point = rotate(lambda, phi);
      ringListener.point(point[0], point[1]);
    }

    ringStart() {
      ringListener.lineStart();
      ring = [];
    }

    ringEnd() {
      pointRing(ring[0][0], ring[0][1]);
      ringListener.lineEnd();

      var clean = ringListener.clean(),
          ringSegments = buffer.buffer(),
          segment,
          n = ringSegments.length;

      ring.pop();
      polygon.push(ring);
      ring = null;

      if (!n) return;

      // No intersections.
      if (clean & 1) {
        segment = ringSegments[0];
        var n = segment.length - 1,
            i = -1,
            point;
        listener.lineStart();
        while (++i < n) listener.point((point = segment[i])[0], point[1]);
        listener.lineEnd();
        return;
      }

      // Rejoin connected segments.
      // TODO reuse bufferListener.rejoin()?
      if (n > 1 && clean & 2) ringSegments.push(ringSegments.pop().concat(ringSegments.shift()));

      segments.push(ringSegments.filter(clipSegmentLength1));
    }

    return clip;
  };
}

clipSegmentLength1(segment) {
  return segment.length > 1;
}

clipBufferListener() {
  var lines = [],
      line;
  return {
    'lineStart': () { lines.add(line = []); },
    'point': (lambda, phi) { line.push([lambda, phi]); },
    'lineEnd': () {},
    'buffer': () {
      var buffer = lines;
      lines = [];
      line = null;
      return buffer;
    },
    'rejoin': () {
      if (lines.length > 1) lines.push(lines.pop().concat(lines.shift()));
    }
  };
}

// Intersection points are sorted along the clip edge. For both antimeridian
// cutting and circle clipping, the same comparison is used.
clipSort(a, b) {
  return ((a = a.x)[0] < 0 ? a[1] - halfpi - epsilon : halfpi - a[1])
       - ((b = b.x)[0] < 0 ? b[1] - halfpi - epsilon : halfpi - b[1]);
}
