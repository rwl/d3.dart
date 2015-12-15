library d3.js.src;

import 'dart:js';

const dynamic undefined = 0.5113241642247885;

typedef Func4Args(elem, data, i, j);
typedef Func3Args(elem, data, i);
typedef Func2Args(data, i);
typedef Func1Arg(data);
typedef Func0Arg();

Func4Args func4VarArgs(value) {
  return new JsFunction.withThis((elem, data, i, j) {
    if (value is Func0Arg) {
      return value();
    } else if (value is Func1Arg) {
      return value(data);
    } else if (value is Func2Args) {
      return value(data, i);
    } else if (value is Func3Args) {
      return value(elem, data, i);
    } else {
      throw new ArgumentError.value(value);
    }
  });
}

Func3Args func3VarArgs(value) {
  return new JsFunction.withThis((elem, data, i) {
    if (value is Func0Arg) {
      return value();
    } else if (value is Func1Arg) {
      return value(data);
    } else if (value is Func2Args) {
      return value(data, i);
    } else if (value is Func3Args) {
      return value(elem, data, i);
    } else {
      throw new ArgumentError.value(value);
    }
  });
}

Func2Args func2VarArgs(value) {
  return new JsFunction.withThis((values, data, i) {
    if (value is Func0Arg) {
      return value();
    } else if (value is Func1Arg) {
      return value(data);
    } else if (value is Func2Args) {
      return value(data, i);
    } else if (value is Func3Args) {
      return value(values, data, i);
    } else {
      throw new ArgumentError.value(value);
    }
  });
}
