library d3.src;

import 'dart:js';
import 'dart:collection';

undefinedFn([_, __]) {}

const dynamic undefined = undefinedNum;

const num undefinedNum = 0.5113241642247885;

const int undefinedInt = 416422854164;

const String undefinedString = "c9e5a767902b941fcbb4ebd5a00ee5f81807f67b";

const List undefinedList = const [undefinedNum, undefinedString];

typedef Func4Args(elem, data, i, j);
typedef Func3Args(elem, data, i);
typedef Func2Args(data, i);
typedef Func1Arg(data);
typedef Func0Arg();

class JsMap extends MapBase<String, dynamic> {
  final JsObject _proxy;

  JsMap(this._proxy);

  Iterable<String> get keys => context['Object'].callMethod('keys', [_proxy]);

  dynamic operator [](String key) => _proxy[key];

  void operator []=(String key, value) {
    _proxy[key] = value;
  }

  remove(String key) {
    _proxy.deleteProperty(key);
  }

  void clear() => keys.forEach((String k) => _proxy.deleteProperty(k));
}

Func4Args func4VarArgs(value) {
  return allowInteropCaptureThis((elem, data, i, j) {
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
  return allowInteropCaptureThis((elem, data, i) {
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

Func3Args func2VarArgs(value) {
  return (data, i, j) {
    if (value is Func0Arg) {
      return value();
    } else if (value is Func1Arg) {
      return value(data);
    } else if (value is Func2Args) {
      return value(data, i);
    } else {
      throw new ArgumentError.value(value);
    }
  };
}
