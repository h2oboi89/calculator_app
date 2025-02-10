import 'package:calculator_app/stack.dart';
import 'package:flutter_test/flutter_test.dart';

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

    test('push adds values to stack', () {
      final stack = Stack<int>();

      stack.push(1);
      stack.push(2);

      expect(stack.isEmpty, isFalse);
      expect(stack.toString(), '1 2');
    });

    test('pop removes values from stack', () {
      final stack = Stack<int>();

      stack.push(1);
      stack.push(2);

      expect(stack.isEmpty, isFalse);
      expect(stack.toString(), '1 2');

      expect(stack.pop(), 2);
      expect(stack.pop(), 1);
      expect(stack.isEmpty, isTrue);
    });

    test('peek does not remove values from stack', () {
      final stack = Stack<int>();

      stack.push(1);
      stack.push(2);

      expect(stack.isEmpty, isFalse);
      expect(stack.toString(), '1 2');

      expect(stack.peek(), 2);
      expect(stack.peek(), 2);
      expect(stack.isNotEmpty, isTrue);
    });

    test('clear empties the stack', () {
      final stack = Stack<int>();

      stack.push(1);
      stack.push(2);

      expect(stack.isEmpty, isFalse);
      expect(stack.toString(), '1 2');

      stack.clear();

      expect(stack.isEmpty, isTrue);
    });
  });
}
