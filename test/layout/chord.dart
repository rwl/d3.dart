import 'package:unittest/unittest.dart';

import '../../src/layout/layout.dart' as d4;

void main() {
  group('chord', () {
    var chord = load('layout/chord').expression('d3.layout.chord');
    group('of a simple matrix', () {
      chord = () {
        return chord()
            .padding(.05)
            .sortSubgroups((a, b) { return b - a; })
            .matrix([
              [11975,  5871, 8916, 2868],
              [ 1951, 10048, 2060, 6171],
              [ 8010, 16145, 8090, 8045],
              [ 1013,   990,  940, 6907]
            ]);
      };
      test('computes chord groups', () {
        var groups = chord.groups();
        expect(groups.length, equals(4));

        expect(groups[0].index, equals(0));
        expect(groups[0].startAngle, inDelta(0.0000000000000000, 1e-6));
        expect(groups[0].endAngle, inDelta(1.8024478065173115, 1e-6));
        expect(groups[0].value, inDelta(29630, 1e-6));

        expect(groups[1].index, equals(1));
        expect(groups[1].startAngle, inDelta(1.8524478065173116, 1e-6));
        expect(groups[1].endAngle, inDelta(3.0830761941597418, 1e-6));
        expect(groups[1].value, inDelta(20230, 1e-6));

        expect(groups[2].index, equals(2));
        expect(groups[2].startAngle, inDelta(3.1330761941597416, 1e-6));
        expect(groups[2].endAngle, inDelta(5.583991554422396, 1e-6));
        expect(groups[2].value, inDelta(40290, 1e-6));

        expect(groups[3].index, equals(3));
        expect(groups[3].startAngle, inDelta(5.6339915544223960, 1e-6));
        expect(groups[3].endAngle, inDelta(6.233185307179585, 1e-6));
        expect(groups[3].value, inDelta(9850, 1e-6));
      });
      test('computes chords', () {
        var chords = chord.chords();
        expect(chords.length, equals(10));

        expect(chords[0].source.index, equals(0));
        expect(chords[0].source.subindex, equals(0));
        expect(chords[0].source.startAngle, inDelta(0, 1e-6));
        expect(chords[0].source.endAngle, inDelta(0.7284614405347555, 1e-6));
        expect(chords[0].source.value, equals(11975));
        expect(chords[0].target.index, equals(0));
        expect(chords[0].target.subindex, equals(0));
        expect(chords[0].target.startAngle, inDelta(0, 1e-6));
        expect(chords[0].target.endAngle, inDelta(0.7284614405347555, 1e-6));
        expect(chords[0].target.value, equals(11975));

        expect(chords[1].source.index, equals(0));
        expect(chords[1].source.subindex, equals(1));
        expect(chords[1].source.startAngle, inDelta(1.2708382425228875, 1e-6));
        expect(chords[1].source.endAngle, inDelta(1.6279820519074009, 1e-6));
        expect(chords[1].source.value, equals(5871));
        expect(chords[1].target.index, equals(1));
        expect(chords[1].target.subindex, equals(0));
        expect(chords[1].target.startAngle, inDelta(2.964393248816668, 1e-6));
        expect(chords[1].target.endAngle, inDelta(3.0830761941597418, 1e-6));
        expect(chords[1].target.value, equals(1951));

        expect(chords[2].source.index, equals(0));
        expect(chords[2].source.subindex, equals(2));
        expect(chords[2].source.startAngle, inDelta(0.7284614405347555, 1e-6));
        expect(chords[2].source.endAngle, inDelta(1.2708382425228875, 1e-6));
        expect(chords[2].source.value, equals(8916));
        expect(chords[2].target.index, equals(2));
        expect(chords[2].target.subindex, equals(0));
        expect(chords[2].target.startAngle, inDelta(5.0967284113173115, 1e-6));
        expect(chords[2].target.endAngle, inDelta(5.583991554422396, 1e-6));
        expect(chords[2].target.value, equals(8010));

        expect(chords[3].source.index, equals(0));
        expect(chords[3].source.subindex, equals(3));
        expect(chords[3].source.startAngle, inDelta(1.6279820519074009, 1e-6));
        expect(chords[3].source.endAngle, inDelta(1.8024478065173115, 1e-6));
        expect(chords[3].source.value, equals(2868));
        expect(chords[3].target.index, equals(3));
        expect(chords[3].target.subindex, equals(0));
        expect(chords[3].target.startAngle, inDelta(6.05415716358929, 1e-6));
        expect(chords[3].target.endAngle, inDelta(6.115779830751019, 1e-6));
        expect(chords[3].target.value, equals(1013));

        expect(chords[4].source.index, equals(1));
        expect(chords[4].source.subindex, equals(1));
        expect(chords[4].source.startAngle, inDelta(1.8524478065173116, 1e-6));
        expect(chords[4].source.endAngle, inDelta(2.4636862661827164, 1e-6));
        expect(chords[4].source.value, equals(10048));
        expect(chords[4].target.index, equals(1));
        expect(chords[4].target.subindex, equals(1));
        expect(chords[4].target.startAngle, inDelta(1.8524478065173116, 1e-6));
        expect(chords[4].target.endAngle, inDelta(2.4636862661827164, 1e-6));
        expect(chords[4].target.value, equals(10048));

        expect(chords[5].source.index, equals(2));
        expect(chords[5].source.subindex, equals(1));
        expect(chords[5].source.startAngle, inDelta(3.1330761941597416, 1e-6));
        expect(chords[5].source.endAngle, inDelta(4.1152064620038855, 1e-6));
        expect(chords[5].source.value, equals(16145));
        expect(chords[5].target.index, equals(1));
        expect(chords[5].target.subindex, equals(2));
        expect(chords[5].target.startAngle, inDelta(2.8390796314887687, 1e-6));
        expect(chords[5].target.endAngle, inDelta(2.964393248816668, 1e-6));
        expect(chords[5].target.value, equals(2060));

        expect(chords[6].source.index, equals(1));
        expect(chords[6].source.subindex, equals(3));
        expect(chords[6].source.startAngle, inDelta(2.4636862661827164, 1e-6));
        expect(chords[6].source.endAngle, inDelta(2.8390796314887687, 1e-6));
        expect(chords[6].source.value, equals(6171));
        expect(chords[6].target.index, equals(3));
        expect(chords[6].target.subindex, equals(1));
        expect(chords[6].target.startAngle, inDelta(6.115779830751019, 1e-6));
        expect(chords[6].target.endAngle, inDelta(6.176003365292097, 1e-6));
        expect(chords[6].target.value, equals(990));

        expect(chords[7].source.index, equals(2));
        expect(chords[7].source.subindex, equals(2));
        expect(chords[7].source.startAngle, inDelta(4.1152064620038855, 1e-6));
        expect(chords[7].source.endAngle, inDelta(4.607336153354714, 1e-6));
        expect(chords[7].source.value, equals(8090));
        expect(chords[7].target.index, equals(2));
        expect(chords[7].target.subindex, 2);
        expect(chords[7].target.startAngle, inDelta(4.1152064620038855, 1e-6));
        expect(chords[7].target.endAngle, inDelta(4.607336153354714, 1e-6));
        expect(chords[7].target.value, equals(8090));

        expect(chords[8].source.index, equals(2));
        expect(chords[8].source.subindex, equals(3));
        expect(chords[8].source.startAngle, inDelta(4.607336153354714, 1e-6));
        expect(chords[8].source.endAngle, inDelta(5.0967284113173115, 1e-6));
        expect(chords[8].source.value, equals(8045));
        expect(chords[8].target.index, equals(3));
        expect(chords[8].target.subindex, equals(2));
        expect(chords[8].target.startAngle, inDelta(6.176003365292097, 1e-6));
        expect(chords[8].target.endAngle, inDelta(6.233185307179585, 1e-6));
        expect(chords[8].target.value, equals(940));

        expect(chords[9].source.index, equals(3));
        expect(chords[9].source.subindex, equals(3));
        expect(chords[9].source.startAngle, inDelta(5.633991554422396, 1e-6));
        expect(chords[9].source.endAngle, inDelta(6.05415716358929, 1e-6));
        expect(chords[9].source.value, equals(6907));
        expect(chords[9].target.index, equals(3));
        expect(chords[9].target.subindex, equals(3));
        expect(chords[9].target.startAngle, inDelta(5.633991554422396, 1e-6));
        expect(chords[9].target.endAngle, inDelta(6.05415716358929, 1e-6));
        expect(chords[9].target.value, equals(6907));
      });
    });
  });
}
