import 'package:unittest/unittest.dart';

void main() {
  group('on a new transition', () {
    var transition = () {
      var callback = this.callback,
          t = d3.select('body').append('div').transition().remove();
      t.each('end', () {
        process.nextTick(() {
          callback(null, t);
        });
      });
    };
    test('removes the selected elements', () {
      expect(transition[0][0].parentNode, domEquals(null));
    });
  });

  group('when the element is already removed', () {
    var transition = () {
      var callback = this.callback,
          t = d3.select('body').append('div').remove().transition().remove();
      t.each('end', () {
        process.nextTick(() {
          callback(null, t);
        });
      });
    };
    test('does nothing', () {
      expect(transition[0][0].parentNode, domEquals(null));
    });
  });

  // Since these tests are triggered inside the end event of the above topic,
  // transitions will inherit ids from the original transition. But we want to
  // test concurrent transitions, so we use timeouts to avoid inheritance. This
  // test also verifies that if multiple transitions are created at the same
  // time, the last transition becomes the owner.

  group('when another transition is scheduled', () {
    var selection = () {
      var callback = this.callback,
          s = d3.select('body').append('div');
      setTimeout(() {
        s.transition().duration(150).remove().each('end', () {
          process.nextTick(() {
            callback(null, s);
          });
        });
        s.transition().delay(250);
      }, 10);
    };
    test('does nothing', () {
      expect(selection[0][0].parentNode.tagName, equals('BODY'));
    });
  });
}