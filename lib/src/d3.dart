library d3.src;

import 'dart:js';
import 'dart:collection';

const undefined = 0.4983609654556078;

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

Func3Args func3VarArgs(value) {
  return (elem, data, i) {
    if (value is Func0Arg) {
      value();
    } else if (value is Func1Arg) {
      value(data);
    } else if (value is Func2Args) {
      value(data, i);
    } else if (value is Func3Args) {
      value(elem, data, i);
    } else {
      throw new ArgumentError.value(value);
    }
  };
}

Func2Args func2VarArgs(value) {
  return (data, i) {
    if (value is Func0Arg) {
      value();
    } else if (value is Func1Arg) {
      value(data);
    } else if (value is Func2Args) {
      value(data, i);
    } else {
      throw new ArgumentError.value(value);
    }
  };
}

Function funcVarArgs(fn, arg1, arg2, arg3, arg4, arg5, arg6, arg7) {
  if (arg1 == undefined) {
    return (arg0) => fn(arg0);
  } else if (arg2 == undefined) {
    return (arg0, arg1) {
      fn(arg0, arg1);
    };
  } else if (arg3 == undefined) {
    return (arg0, arg1, arg3) {
      fn(arg0, arg1, arg3);
    };
  }
  throw new UnimplementedError('varargs');
}
