import 'package:unittest/unittest.dart';
import 'package:d3/dsv/dsv.dart' as dsv;

void main() {
  group('tsv', () {
    group('on a sample file', () {
      dsv.tsv('../data/sample.tsv', callback: (tsv) {
        test('invokes the callback with the parsed tsv', () {
          expect(tsv, equals([{'Hello':'42','World':'"fish"'}]));
        });
      });
//      test('overrides the mime type to text/tab-separated-values', () {
//        expect(XMLHttpRequest._last._info.mimeType, equals('text/tab-separated-values'));
//      });
    });

    group('on a file that does not exist', () {
      dsv.tsv('//does/not/exist.tsv', callback: (tsv) {
        test('invokes the callback with null when an error occurs', () {
          expect(tsv, isNull);
        });
      });
    });

    group('parse', () {
      var parse = dsv.tsv.parse;
      test('returns an array of objects', () {
        expect(parse('a\tb\tc\n1\t2\t3\n'), equals([{'a': '1', 'b': '2', 'c': '3'}]));
      });
      test('does not strip whitespace', () {
        expect(parse('a\tb\tc\n 1\t 2\t3\n'), equals([{'a': ' 1', 'b': ' 2', 'c': '3'}]));
      });
      test('parses quoted values', () {
        expect(parse('a\tb\tc\n"1"\t2\t3'), equals([{'a': '1', 'b': '2', 'c': '3'}]));
        expect(parse('a\tb\tc\n"1"\t2\t3\n'), equals([{'a': '1', 'b': '2', 'c': '3'}]));
      });
      test('parses quoted values with quotes', () {
        expect(parse('a\n"""hello"""'), equals([{'a': '"hello"'}]));
      });
      test('parses quoted values with newlines', () {
        expect(parse('a\n"new\nline"'), equals([{'a': 'new\nline'}]));
        expect(parse('a\n"new\rline"'), equals([{'a': 'new\rline'}]));
        expect(parse('a\n"new\r\nline"'), equals([{'a': 'new\r\nline'}]));
      });
      test('parses unix newlines', () {
        expect(parse('a\tb\tc\n1\t2\t3\n4\t5\t"6"\n7\t8\t9'), equals([
          {'a': '1', 'b': '2', 'c': '3'},
          {'a': '4', 'b': '5', 'c': '6'},
          {'a': '7', 'b': '8', 'c': '9'}
        ]));
      });
      test('parses mac newlines', () {
        expect(parse('a\tb\tc\r1\t2\t3\r4\t5\t"6"\r7\t8\t9'), equals([
          {'a': '1', 'b': '2', 'c': '3'},
          {'a': '4', 'b': '5', 'c': '6'},
          {'a': '7', 'b': '8', 'c': '9'}
        ]));
      });
      test('parses dos newlines', () {
        expect(parse('a\tb\tc\r\n1\t2\t3\r\n4\t5\t"6"\r\n7\t8\t9'), equals([
          {'a': '1', 'b': '2', 'c': '3'},
          {'a': '4', 'b': '5', 'c': '6'},
          {'a': '7', 'b': '8', 'c': '9'}
        ]));
      });
    });

    group('parseRows', () {
      var parse = dsv.tsv.parseRows;
      test('returns an array of arrays', () {
        expect(parse('a\tb\tc\n'), equals([['a', 'b', 'c']]));
      });
      test('parses quoted values', () {
        expect(parse('"1"\t2\t3\n'), equals([['1', '2', '3']]));
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
        expect(parse('a\tb\tc\n1\t2\t3\n4\t5\t"6"\n7\t8\t9'), equals([
          ['a', 'b', 'c'],
          ['1', '2', '3'],
          ['4', '5', '6'],
          ['7', '8', '9']
        ]));
      });
      test('parses mac newlines', () {
        expect(parse('a\tb\tc\r1\t2\t3\r4\t5\t"6"\r7\t8\t9'), equals([
          ['a', 'b', 'c'],
          ['1', '2', '3'],
          ['4', '5', '6'],
          ['7', '8', '9']
        ]));
      });
      test('parses dos newlines', () {
        expect(parse('a\tb\tc\r\n1\t2\t3\r\n4\t5\t"6"\r\n7\t8\t9'), equals([
          ['a', 'b', 'c'],
          ['1', '2', '3'],
          ['4', '5', '6'],
          ['7', '8', '9']
        ]));
      });
    });

    group('format', () {
      var format = dsv.tsv.format;
      test('takes an array of objects as input', () {
        expect(format([{'a': 1, 'b': 2, 'c': 3}]), equals('a\tb\tc\n1\t2\t3'));
      });
      test('escapes field names containing special characters', () {
        expect(format([{'foo\tbar': true}]), equals('"foo\tbar"\ntrue'));
      });
      test('computes the union of all fields', () {
        expect(format([
          {'a': 1},
          {'a': 1, 'b': 2},
          {'a': 1, 'b': 2, 'c': 3},
          {'b': 1, 'c': 2},
          {'c': 1}
        ]), equals('a\tb\tc\n1\t\t\n1\t2\t\n1\t2\t3\n\t1\t2\n\t\t1'));
      });
      test('orders field by first-seen', () {
        expect(format([
          {'a': 1, 'b': 2},
          {'c': 3, 'b': 4},
          {'c': 5, 'a': 1, 'b': 2}
        ]), equals('a\tb\tc\n1\t2\t\n\t4\t3\n1\t2\t5'));
      });
    });

    group('formatRows', () {
      var format = dsv.tsv.formatRows;
      test('takes an array of arrays as input', () {
        expect(format([['a', 'b', 'c'], ['1', '2', '3']]), equals('a\tb\tc\n1\t2\t3'));
      });
      test('separates lines using unix newline', () {
        expect(format([[], []]), equals('\n'));
      });
      test('does not strip whitespace', () {
        expect(format([['a ', ' b', 'c'], ['1', '2', '3 ']]), equals('a \t b\tc\n1\t2\t3 '));
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
      test('escapes tabs', () {
        expect(format([['oxford\tcomma']]), equals('"oxford\tcomma"'));
      });
      test('does not escape commas', () {
        expect(format([['oxford,comma']]), equals('oxford,comma'));
      });
    });
  });
}