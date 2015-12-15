library d3.src.js.dsv;
/*
import 'dart:js';
import 'd3.dart';

JsObject _d3 = context['d3'];

Dsv dsv(String delimiter, String mimeType) {
  return new Dsv._(_d3.callMethod('dsv', [delimiter, mimeType]));
}

class Dsv {
  final JsObject _proxy;

  Dsv._(this._proxy);

  factory Dsv(String delimiter, String mimeType) => dsv(delimiter, mimeType);

  /// Create a parser/formatter for the specified delimiter and mime type.
  call(String url, [accessor = undefined, callback = undefined]) {
    var args = [_proxy, url];
    if (accessor != undefined) {
      args.add(accessor);
    }
    if (callback != undefined) {
      args.add(callback);
    }
    return _proxy.callMethod('call', args);
  }

  List parse(String string, [accessor = undefined]) {
    var args = [string];
    if (accessor != undefined) {
      args.add(accessor);
    }
    return _proxy.callMethod('parse', args);
  }

  List<List> parseRows(String string, [accessor = undefined]) {
    var args = [string];
    if (accessor != undefined) {
      args.add(accessor);
    }
    return _proxy.callMethod('parseRows', args);
  }

  String format(List rows) {
    return _proxy.callMethod('format', [new JsObject.jsify(rows)]);
  }

  String formatRows(List<List> rows) {
    return _proxy.callMethod('formatRows', [new JsObject.jsify(rows)]);
  }
}
*/

import 'dart:html';

typedef Map<String, dynamic> accessorFunction(Map<String, String> d, int i);
typedef dynamic rowAccessorFunction(List<String> row, int i);

final _reDblQuote = new RegExp(r'""');
final _reQuote = new RegExp(r'"');

class Dsv {
  final String delimiter;
  final String mimeType;
  RegExp reFormat;
  int delimiterCode;

  Dsv(this.delimiter, this.mimeType) {
    reFormat = new RegExp('["$delimiter\n]');
    delimiterCode = delimiter.codeUnitAt(0);
  }

  call(url, {accessorFunction row, callback(err, res)}) {
    HttpRequest
        .request(url, method: "GET", mimeType: mimeType)
        .then((HttpRequest req) {
      if (callback != null) {
        callback(null, parse(req.responseText, row));
      }
    }).catchError((error) {
      if (callback != null) {
        callback(error, null);
      }
    });
  }

  /// Parses the specified string, which is the contents of a CSV file,
  /// returning an array of maps representing the parsed rows.
  List<Map<String, dynamic>> parse(String text, [accessorFunction fn]) {
    List<String> row0 = null;
    return parseRows(text, (List<String> row, int i) {
      if (row0 == null) {
        row0 = row;
        return null;
      }

      var m = new Map<String, String>();
      int i = 0;
      row0.forEach((String name) {
        if (i < row.length) {
          m[name] = row[i];
        }
        i++;
      });
      if (fn != null) {
        return fn(m, i - 1);
      }
      return m;
    });
  }

  /// Parses the specified string, which is the contents of a CSV file,
  /// returning an array of arrays representing the parsed rows.
  List parseRows(String text, [rowAccessorFunction f = null]) {
    const EOL = const Object(); // sentinel value for end-of-line
    const EOF = const Object(); // sentinel value for end-of-file
    var rows = []; // output rows
    int N = text.length;
    int I = 0; // current character index
    int n = 0; // the current line number
    var t; // the current token
    bool eol = false; // is the current token followed by EOL?

    Object token() {
      if (I >= N) {
        return EOF; // special case: end of file
      }
      if (eol) {
        eol = false;
        return EOL; // special case: end of line
      }

      // special case: quotes
      var j = I;
      if (_codeUnitAt(text, j) == 34) {
        var i = j;
        while (i++ < N) {
          if (_codeUnitAt(text, i) == 34) {
            if (_codeUnitAt(text, i + 1) != 34) {
              break;
            }
            ++i;
          }
        }
        I = i + 2;
        var c = _codeUnitAt(text, i + 1);
        if (c == 13) {
          eol = true;
          if (_codeUnitAt(text, i + 2) == 10) ++I;
        } else if (c == 10) {
          eol = true;
        }
        return text.substring(j + 1, i).replaceAll(_reDblQuote, '"');
      }

      // common case: find next delimiter or newline
      while (I < N) {
        var c = _codeUnitAt(text, I++), k = 1;
        if (c == 10) {
          eol = true; // \n
        } else if (c == 13) {
          // \r|\r\n
          eol = true;
          if (_codeUnitAt(text, I) == 10) {
            ++I;
            ++k;
          }
        } else if (c != delimiterCode) {
          continue;
        }
        return text.substring(j, I - k);
      }

      // special case: last token before EOF
      return text.substring(j);
    }

    while ((t = token()) != EOF) {
      var a = [];
      while (t != EOL && t != EOF) {
        a.add(t);
        t = token();
      }
      if (f != null) {
        a = f(a, n++);
        if (a == null) {
          continue;
        }
      }
      rows.add(a);
    }

    return rows;
  }

  format(List<Map<String, dynamic>> rows) {
    var fieldSet = new Set();
    var fields = new List<String>();

    // Compute unique fields in order of discovery.
    rows.forEach((row) {
      row.forEach((field, _) {
        if (!fieldSet.contains(field)) {
          fieldSet.add(field);
          fields.add(field);
        }
      });
    });

    var parts = [fields.map(formatValue).join(delimiter)];

    parts.addAll(rows.map((Map<String, dynamic> row) {
      return fields.map((field) {
        var value = row[field];
        return value != null ? formatValue(value) : "";
      }).join(delimiter);
    }));

    return parts.join("\n");
  }

  String formatRows(List<List> rows) {
    return rows.map(formatRow).join("\n");
  }

  String formatRow(List row) {
    return row.map(formatValue).join(delimiter);
  }

  String formatValue(Object obj) {
    var text = obj.toString();
    if (reFormat.hasMatch(text)) {
      return "\"" + text.replaceAll(_reQuote, '""') + "\"";
    }
    return text;
  }
}

num _codeUnitAt(final String text, int i) {
  if (i < text.length) {
    return text.codeUnitAt(i);
  }
  return double.NAN;
}

final Dsv csv = new Dsv(",", "text/csv");

final Dsv tsv = new Dsv("\t", "text/tab-separated-values");
