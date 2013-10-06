import 'package:unittest/unittest.dart';

import '../../src/core/core.dart' as d4;

void main() {
  group('version', () {
    var version = load('core/version').expression('d3.version');
    test('has the form major.minor.patch', () {
      expect(version, matches('^[0-9]+\.[0-9]+\.[0-9]+'));
    });
  });
}
