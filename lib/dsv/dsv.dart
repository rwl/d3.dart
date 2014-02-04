library d3.dsv;

part 'csv.dart';
part 'tsv.dart';

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
      if (o) return o(row, i - 1);
      var a = new Function("d", "return {" + row.map((name, i) {
        return JSON.stringify(name) + ": d[" + i + "]";
      }).join(",") + "}");
      o = f ? (row, i) { return f(a(row), i); } : a;
    });
  }

  parseRows(text, f) {
    var EOL = {}, // sentinel value for end-of-line
        EOF = {}, // sentinel value for end-of-file
        rows = [], // output rows
        N = text.length,
        I = 0, // current character index
        n = 0, // the current line number
        t, // the current token
        eol; // is the current token followed by EOL?

    token() {
      if (I >= N) return EOF; // special case: end of file
      if (eol) {
        eol = false;
        return EOL; // special case: end of line
      }

      // special case: quotes
      var j = I;
      if (text.codeUnitAt(j) == 34) {
        var i = j;
        while (i++ < N) {
          if (text.codeUnitAt(i) == 34) {
            if (text.codeUnitAt(i + 1) != 34) break;
            ++i;
          }
        }
        I = i + 2;
        var c = text.codeUnitAt(i + 1);
        if (c == 13) {
          eol = true;
          if (text.codeUnitAt(i + 2) == 10) ++I;
        } else if (c == 10) {
          eol = true;
        }
        return text.substring(j + 1, i).replace(r'""'/*g*/, "\"");
      }

      // common case: find next delimiter or newline
      while (I < N) {
        var c = text.codeUnitAt(I++), k = 1;
        if (c == 10) eol = true; // \n
        else if (c == 13) { eol = true; if (text.codeUnitAt(I) == 10) {++I; ++k;} } // \r|\r\n
        else if (c != delimiterCode) continue;
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
      if (f && !(a = f(a, n++))) continue;
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