import 'package:calculator_app/stack.dart';
import 'package:test/test.dart';

void main() {
  group("stack tests", () {
    test('starts empty', () {
      final stack = Stack<int>();

      expect(stack.isEmpty, isTrue);
      expect(stack.isNotEmpty, isFalse);
      expect(stack.toString(), '');
    });

    test('pop on empty throws', () {
      final stack = Stack<int>();

      expect(() {
        stack.pop();
      },
          throwsA(isA<RangeError>().having(
              (e) => e.message, 'message', 'Cannot pop from an empty stack')));
    });

    test('peek on empty throws', () {
      final stack = Stack<int>();

      expect(() {
        stack.peek();
      },
          throwsA(isA<RangeError>().having(
              (e) => e.message, 'message', 'Cannot peek an empty stack')));
    });

    test('clear on empty does nothing', () {
      final stack = Stack<int>();

      expect(stack.isEmpty, isTrue);
      stack.clear();
      expect(stack.isEmpty, isTrue);
    });
  });
}
