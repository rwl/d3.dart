library d3.dsv;

//import 'dart:html';

part 'csv.dart';
part 'tsv.dart';

typedef List<String> accessorFunction(List<String> row, int i);

final reQuote = new RegExp(r'""');

class DSV {
  String delimiter, mimeType;
  RegExp reFormat;
  int delimiterCode;

  DSV(this.delimiter, this.mimeType) {
    this.reFormat = new RegExp("[\"" + delimiter + "\n]");
    this.delimiterCode = delimiter.codeUnitAt(0);
  }

  call(url, {row:null, callback:null}) {
//    if (callback == null) {
//      callback = row;
//      row = null;
//    }

    HttpRequest.request(url, method: "GET", mimeType: mimeType)
    .then((resp) {

    });
    var xhr = d3_xhr(url, mimeType, row == null ? response : typedResponse(row), callback);

    xhr.row = ([r=null]) {
      return r != null
          ? xhr.response((row = r) == null ? response : typedResponse(r))
          : row;
    };

    return xhr;
  }

  response(request) {
    return parse(request.responseText);
  }

  typedResponse(f) {
    return (request) {
      return parse(request.responseText, f);
    };
  }

  parse(text, f) {
    var o;
    return parseRows(text, (row, i) {
//      if (o) return o(row, i - 1);
//      var a = new Function("d", "return {" + row.map((name, i) {
//        return JSON.stringify(name) + ": d[" + i + "]";
//      }).join(",") + "}");
//      o = f ? (row, i) { return f(a(row), i); } : a;
    });
  }

  List<List<String>> parseRows(text, [accessorFunction f = null]) {
    final EOL = new Object(); // sentinel value for end-of-line
    final EOF = new Object(); // sentinel value for end-of-file
    final List<List<String>> rows = []; // output rows
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
        return text.substring(j + 1, i).replaceAll(reQuote, '"');
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
      List<String> a = [];
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

  format(rows) {
    if (rows[0] is List) {
      return formatRows(rows); // deprecated; use formatRows
    }
    var fieldSet = new Set(), fields = [];

    // Compute unique fields in order of discovery.
    rows.forEach((row) {
      for (var field in row) {
        if (!fieldSet.contains(field)) {
          fields.add(fieldSet.add(field));
        }
      }
    });

    return [fields.map(formatValue).join(delimiter)].concat(rows.map((row) {
      return fields.map((field) {
        return formatValue(row[field]);
      }).join(delimiter);
    })).join("\n");
  }

  String formatRows(rows) {
    return rows.map(formatRow).join("\n");
  }

  String formatRow(row) {
    return row.map(formatValue).join(delimiter);
  }

  String formatValue(text) {
    return reFormat.hasMatch(text) ? "\"" + text.replace("\""/*g*/, "\"\"") + "\"" : text;
  }
}

num codeUnitAt(final String text, int i) {
  if (i < text.length) {
    return text.codeUnitAt(i);
  }
  return double.NAN;
}