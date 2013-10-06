import 'package:unittest/unittest.dart';

import '../../src/core/core.dart' as d4;

void main() {
  group('csv', () {
    var csv = load('dsv/csv').expression('d3.csv').document();
    
    group('on a sample file', () {
      csv = csv('test/data/sample.csv', this.callback);
      test('invokes the callback with the parsed CSV', () {
        expect(csv, equals([{'Hello':'42','World':'"fish"'}]));
      });
      test('overrides the mime type to text/csv', () {
        expect(XMLHttpRequest._last._info.mimeType, equals('text/csv'));
      });
    });

  group('when specifying a row conversion function', () {
      csv = csv('test/data/sample.csv', (row) {
        row.Hello = -row.Hello;
        return row;
      }, this.callback);
      test('invokes the callback with the parsed CSV', () {
        assert.strictEqual(csv[0].Hello, same(-42));
      });
    });

    group('when loading a file that does not exist', () {
      var callback = this.callback;
      csv = csv('//does/not/exist.csv', (error, csv) {
        callback(null, csv);
      });
      test('invokes the callback with undefined', () {
        expect(csv, isUndefined);
      });
    });

    group('parse', () {
      var parse = csv.parse;
      test('returns an array of objects', () {
        expect(parse('a,b,c\n1,2,3\n'), equals([{a: '1', b: '2', c: '3'}]));
      });
      test('does not strip whitespace', () {
        expect(parse('a,b,c\n 1, 2,3\n'), equals([{a: ' 1', b: ' 2', c: '3'}]));
      });
      test('parses quoted values', () {
        expect(parse('a,b,c\n"1",2,3'), equals([{a: '1', b: '2', c: '3'}]));
        expect(parse('a,b,c\n"1",2,3\n'), equals([{a: '1', b: '2', c: '3'}]));
      });
      test('parses quoted values with quotes', () {
        expect(parse('a\n"""hello"""'), equals([{a: '"hello"'}]));
      });
      test('parses quoted values with newlines', () {
        expect(parse('a\n"new\nline"'), equals([{a: 'new\nline'}]));
        expect(parse('a\n"new\rline"'), equals([{a: 'new\rline'}]));
        expect(parse('a\n"new\r\nline"'), equals([{a: 'new\r\nline'}]));
      });
      test('parses unix newlines', () {
        expect(parse('a,b,c\n1,2,3\n4,5,"6"\n7,8,9'), equals([
          {a: '1', b: '2', c: '3'},
          {a: '4', b: '5', c: '6'},
          {a: '7', b: '8', c: '9'}
        ]));
      });
      test('parses mac newlines', () {
        expect(parse('a,b,c\r1,2,3\r4,5,"6"\r7,8,9'), equals([
          {a: '1', b: '2', c: '3'},
          {a: '4', b: '5', c: '6'},
          {a: '7', b: '8', c: '9'}
        ]));
      });
      test('parses dos newlines', () {
        expect(parse('a,b,c\r\n1,2,3\r\n4,5,"6"\r\n7,8,9'), equals([
          {a: '1', b: '2', c: '3'},
          {a: '4', b: '5', c: '6'},
          {a: '7', b: '8', c: '9'}
        ]));
      });
    });

    group('parse with row function', () {
      test('invokes the row function for every row in order', () {
        var rows = [];
        csv.parse('a\n1\n2\n3\n4', (d, i) { rows.push({d: d, i: i}); });
        expect(rows, equals([
          {d: {a: '1'}, i: 0},
          {d: {a: '2'}, i: 1},
          {d: {a: '3'}, i: 2},
          {d: {a: '4'}, i: 3}
        ]));
      });
      test('returns an array of the row function return values', () {
        expect(csv.parse('a,b,c\n1,2,3\n', (row) { return row; }), equals([{a: '1', b: '2', c: '3'}]));
      });
      test('skips rows if the row function returns null or undefined', () {
        expect(csv.parse('a,b,c\n1,2,3\n2,3,4', (row) { return row.a & 1 ? null : row; }), equals([{a: '2', b: '3', c: '4'}]));
        expect(csv.parse('a,b,c\n1,2,3\n2,3,4', (row) { return row.a & 1 ? undefined : row; }), equals([{a: '2', b: '3', c: '4'}]));
      });
    });

    group('parseRows', () {
      var parse = csv.parseRows;
      test('returns an array of arrays', () {
        expect(parse('a,b,c\n'), equals([['a', 'b', 'c']]));
      });
      test('parses quoted values', () {
        expect(parse('"1",2,3\n'), equals([['1', '2', '3']]));
        expect(parse('"hello"'), equals([['hello']]));
      });
      test('parses quoted values with quotes', () {
        expect(parse('"""hello"""'), equals([['"hello"']]));
      });
      test('parses quoted values with newlines', () {
        expect(parse('"new\nline"'), equals([['new\nline']]));
        expect(parse('"new\rline"'), equals([['new\rline']]));
        expect(parse('"new\r\nline"'), equals([['new\r\nline']]));
      });
      test('parses unix newlines', () {
        expect(parse('a,b,c\n1,2,3\n4,5,"6"\n7,8,9'), equals([
          ['a', 'b', 'c'],
          ['1', '2', '3'],
          ['4', '5', '6'],
          ['7', '8', '9']
        ]));
      });
      test('parses mac newlines', () {
        expect(parse('a,b,c\r1,2,3\r4,5,"6"\r7,8,9'), equals([
          ['a', 'b', 'c'],
          ['1', '2', '3'],
          ['4', '5', '6'],
          ['7', '8', '9']
        ]));
      });
      test('parses dos newlines', () {
        expect(parse('a,b,c\r\n1,2,3\r\n4,5,"6"\r\n7,8,9'), equals([
          ['a', 'b', 'c'],
          ['1', '2', '3'],
          ['4', '5', '6'],
          ['7', '8', '9']
        ]));
      });
    });

    group('format', () {
      var format = csv.format;
      test('takes an array of objects as input', () {
        expect(format([{a: 1, b: 2, c: 3}]), equals('a,b,c\n1,2,3'));
      });
      test('escapes field names containing special characters', () {
        expect(format([{'foo,bar': true}]), equals('"foo,bar"\ntrue'));
      });
      test('computes the union of all fields', () {
        expect(format([
          {a: 1},
          {a: 1, b: 2},
          {a: 1, b: 2, c: 3},
          {b: 1, c: 2},
          {c: 1}
        ]), equals('a,b,c\n1,,\n1,2,\n1,2,3\n,1,2\n,,1'));
      });
      test('orders field by first-seen', () {
        expect(format([
          {a: 1, b: 2},
          {c: 3, b: 4},
          {c: 5, a: 1, b: 2}
        ]), equals('a,b,c\n1,2,\n,4,3\n1,2,5'));
      });
    });

    group('formatRows', () {
      var format = csv.formatRows;
      test('takes an array of arrays as input', () {
        expect(format([['a', 'b', 'c'], ['1', '2', '3']]), equals('a,b,c\n1,2,3'));
      });
      test('separates lines using unix newline', () {
        expect(format([[], []]), equals('\n'));
      });
      test('does not strip whitespace', () {
        expect(format([['a ', ' b', 'c'], ['1', '2', '3 ']]), equals('a , b,c\n1,2,3 '));
      });
      test('does not quote simple values', () {
        expect(format([['a'], [1]]), equals('a\n1'));
      });
      test('escapes double quotes', () {
        expect(format([['"fish"']]), equals('"""fish"""'));
      });
      test('escapes unix newlines', () {
        expect(format([['new\nline']]), equals('"new\nline"'));
      });
      test('escapes commas', () {
        expect(format([['oxford,comma']]), equals('"oxford,comma"'));
      });
    });
  });
}
