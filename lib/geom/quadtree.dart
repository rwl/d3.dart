part of d3.geom;

class QuadTree {
  var x = (d) { return d[0]; };
  var y = (d) { return d[1]; };
  var points, x1, y1, x2, y2;

  QuadTree(this.points, this.x1, this.y1, this.x2, this.y2);

  quadtree(data) {
    var d,
        fx = functor(x),
        fy = functor(y),
        xs,
        ys,
        i,
        n,
        x1_,
        y1_,
        x2_,
        y2_;

    if (x1 != null) {
      x1_ = x1; y1_ = y1; x2_ = x2; y2_ = y2;
    } else {
      // Compute bounds, and cache points temporarily.
      x2_ = y2_ = -(x1_ = y1_ = double.INFINITY);
      xs = []; ys = [];
      n = data.length;
      /*if (compat) for (i = 0; i < n; ++i) {
        d = data[i];
        if (d.x < x1_) x1_ = d.x;
        if (d.y < y1_) y1_ = d.y;
        if (d.x > x2_) x2_ = d.x;
        if (d.y > y2_) y2_ = d.y;
        xs.push(d.x);
        ys.push(d.y);
      } else */for (i = 0; i < n; ++i) {
        var x_ = toDouble(fx(d = data[i], i)),
            y_ = toDouble(fy(d, i));
        if (x_ < x1_) x1_ = x_;
        if (y_ < y1_) y1_ = y_;
        if (x_ > x2_) x2_ = x_;
        if (y_ > y2_) y2_ = y_;
        xs.add(x_);
        ys.add(y_);
      }
    }

    // Squarify the bounds.
    var dx = x2_ - x1_,
        dy = y2_ - y1_;
    if (dx > dy) y2_ = y1_ + dx;
    else x2_ = x1_ + dy;

    Function insertChild;

    // Recursively inserts the specified point p at the node n or one of its
    // descendants. The bounds are defined by [x1, x2] and [y1, y2].
    insert(n, d, x, y, x1, y1, x2, y2) {
      if (x.isNaN || y.isNaN) return; // ignore invalid points
      if (n.leaf) {
        var nx = n.x,
            ny = n.y;
        if (nx != null) {
          // If the point at this leaf node is at the same position as the new
          // point we are adding, we leave the point associated with the
          // internal node while adding the new point to a child node. This
          // avoids infinite recursion.
          if ((abs(nx - x) + (ny - y).abs()) < .01) {
            insertChild(n, d, x, y, x1, y1, x2, y2);
          } else {
            var nPoint = n.point;
            n.x = n.y = n.point = null;
            insertChild(n, nPoint, nx, ny, x1, y1, x2, y2);
            insertChild(n, d, x, y, x1, y1, x2, y2);
          }
        } else {
          n.x = x; n.y = y; n.point = d;
        }
      } else {
        insertChild(n, d, x, y, x1, y1, x2, y2);
      }
    }

    // Recursively inserts the specified point [x, y] into a descendant of node
    // n. The bounds are defined by [x1, x2] and [y1, y2].
    insertChild = (n, d, x, y, x1, y1, x2, y2) {
      // Compute the split point, and the quadrant in which to insert p.
      var sx = (x1 + x2) * .5,
          sy = (y1 + y2) * .5,
          right = x >= sx,
          bottom = y >= sy,
          i = (bottom << 1) + right;

      // Recursively insert into the child node.
      n.leaf = false;
      n = n.nodes[i] || (n.nodes[i] = quadtreeNode());

      // Update the bounds as we recurse.
      if (right) x1 = sx; else x2 = sx;
      if (bottom) y1 = sy; else y2 = sy;
      insert(n, d, x, y, x1, y1, x2, y2);
    };

    // Create the root node.
    var root = quadtreeNode();

    root.add = (d) {
      insert(root, d, toDouble(fx(d, ++i)), toDouble(fy(d, i)), x1_, y1_, x2_, y2_);
    };

    root.visit = (f) {
      quadtreeVisit(f, root, x1_, y1_, x2_, y2_);
    };

    // Insert all points.
    i = -1;
    if (x1 == null) {
      while (++i < n) {
        insert(root, data[i], xs[i], ys[i], x1_, y1_, x2_, y2_);
      }
      --i; // index of last insertion
    } else {
      data.forEach(root.add);
    }

    // Discard captured fields.
    xs = ys = data = d = null;

    return root;
  }

  extent([arg=unique]) {
    if (arg == unique) {
      return x1 == null ? null : [[x1, y1], [x2, y2]];
    }
    if (arg == null) {
      x1 = y1 = x2 = y2 = null;
    } else {
      x1 = toDouble(arg[0][0]);
      y1 = toDouble(arg[0][1]);
      x2 = toDouble(arg[1][0]);
      y2 = toDouble(arg[1][1]);
    }
    return this;
  }

  size([arg=unique]) {
    if (arg == unique) {
      return x1 == null ? null : [x2 - x1, y2 - y1];
    }
    if (arg == null) {
      x1 = y1 = x2 = y2 = null;
    } else {
      x1 = y1 = 0;
      x2 = toDouble(arg[0]);
      y2 = toDouble(arg[1]);
    }
    return quadtree;
  }
}

quadtreeNode() {
  return {
    'leaf': true,
    'nodes': [],
    'point': null,
    'x': null,
    'y': null
  };
}

quadtreeVisit(f, node, x1, y1, x2, y2) {
  if (!f(node, x1, y1, x2, y2)) {
    var sx = (x1 + x2) * .5,
        sy = (y1 + y2) * .5,
        children = node.nodes;
    if (children[0]) quadtreeVisit(f, children[0], x1, y1, sx, sy);
    if (children[1]) quadtreeVisit(f, children[1], sx, y1, x2, sy);
    if (children[2]) quadtreeVisit(f, children[2], x1, sy, sx, y2);
    if (children[3]) quadtreeVisit(f, children[3], sx, sy, x2, y2);
  }
}
