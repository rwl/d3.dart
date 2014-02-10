library d3.dsv;

import 'dart:html';

part 'csv.dart';
part 'tsv.dart';

typedef dsvCallback(List<Map<String, Object>> map);

typedef Map<String, Object> accessorFunction(Map<String, String> d, int i);
typedef Object rowAccessorFunction(List<String> row, int i);

final reDblQuote = new RegExp(r'""');
final reQuote = new RegExp(r'"');

class DSV {
  final String delimiter, mimeType;
  RegExp reFormat;
  int delimiterCode;

  DSV(this.delimiter, this.mimeType) {
    this.reFormat = new RegExp('["$delimiter\n]');
    this.delimiterCode = delimiter.codeUnitAt(0);
  }

  call(url, {accessorFunction row:null, callback:null}) {
//    if (callback == null) {
//      callback = row;
//      row = null;
//    }

    HttpRequest.request(url, method: "GET", mimeType: mimeType)
      .then((HttpRequest req) {
        if (callback != null) {
          callback(parse(req.responseText, row));
        }
      })
      .catchError((Error error) {
        if (callback != null) {
          callback(null);
        }
      });
//    var xhr = d3_xhr(url, mimeType, row == null ? response : typedResponse(row), callback);
//
//    xhr.row = ([r=null]) {
//      return r != null
//          ? xhr.response((row = r) == null ? response : typedResponse(r))
//          : row;
//    };
//
//    return xhr;
  }

  response(request) {
    return parse(request.responseText);
  }

  typedResponse(f) {
    return (request) {
      return parse(request.responseText, f);
    };
  }

  /**
   * Parses the specified string, which is the contents of a CSV file,
   * returning an array of maps representing the parsed rows.
   */
  List<Map<String, Object>> parse(final String text, [accessorFunction fn = null]) {
    List<String> row0 = null;
    return parseRows(text, (final List<String> row, int i) {
      if (row0 == null) {
        row0 = row;
        return null;
      }

      final m = new Map<String, String>();
      int i = 0;
      row0.forEach((final String name) {
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

  /**
   * Parses the specified string, which is the contents of a CSV file,
   * returning an array of arrays representing the parsed rows.
   */
  List parseRows(text, [rowAccessorFunction f = null]) {
    final EOL = new Object(); // sentinel value for end-of-line
    final EOF = new Object(); // sentinel value for end-of-file
    final List rows = []; // output rows
    int N = text.length,
        I = 0, // current character index
        n = 0; // the current line number
    Object t; // the current token
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
      if (codeUnitAt(text, j) == 34) {
        var i = j;
        while (i++ < N) {
          if (codeUnitAt(text, i) == 34) {
            if (codeUnitAt(text, i + 1) != 34) {
              break;
            }
            ++i;
          }
        }
        I = i + 2;
        var c = codeUnitAt(text, i + 1);
        if (c == 13) {
          eol = true;
          if (codeUnitAt(text, i + 2) == 10) ++I;
        } else if (c == 10) {
          eol = true;
        }
        return text.substring(j + 1, i).replaceAll(reDblQuote, '"');
      }

      // common case: find next delimiter or newline
      while (I < N) {
        var c = codeUnitAt(text, I++), k = 1;
        if (c == 10) {
          eol = true; // \n
        } else if (c == 13) { // \r|\r\n
          eol = true;
          if (codeUnitAt(text, I) == 10) {
            ++I; ++k;
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

  format(final List<Map<String, Object>> rows) {
    final fieldSet = new Set();
    final fields = new List<String>();

    // Compute unique fields in order of discovery.
    rows.forEach((row) {
      row.forEach((field, _) {
        if (!fieldSet.contains(field)) {
          fieldSet.add(field);
          fields.add(field);
        }
      });
    });

    final parts = [fields.map(formatValue).join(delimiter)];

    parts.addAll(rows.map((final Map<String, Object> row) {
      return fields.map((final field) {
        final value = row[field];
        return value != null ? formatValue(value) : "";
      }).join(delimiter);
    }));

    return parts.join("\n");
  }

  String formatRows(final List<List<Object>> rows) {
    return rows.map(formatRow).join("\n");
  }

  String formatRow(final List<Object> row) {
    return row.map(formatValue).join(delimiter);
  }

  String formatValue(final Object obj) {
    final text = obj.toString();
    if (reFormat.hasMatch(text)) {
      return "\"" + text.replaceAll(reQuote, '""') + "\"";
    }
    return text;
  }
}

num codeUnitAt(final String text, int i) {
  if (i < text.length) {
    return text.codeUnitAt(i);
  }
  return double.NAN;
}