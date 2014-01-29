part of core;

functor(v) {
  return v is Function ? v : () { return v; };
}
