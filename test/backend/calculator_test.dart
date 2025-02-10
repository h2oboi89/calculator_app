import 'package:calculator_app/calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('clear tests', () {
    test('C resets the calculator', () {
      final calculator = Calculator();

      calculator.update("1");
      calculator.update("2");

      expect(calculator.expression, '');
      expect(calculator.entry, '12');

      calculator.update("C");

      expect(calculator.expression, '');
      expect(calculator.entry, '0');
    });

    test('CE resets the entry', () {
      final calculator = Calculator();

      calculator.update("1");
      calculator.update("+");
      calculator.update("2");

      expect(calculator.entry, '2');
      expect(calculator.expression, '1 +');

      calculator.update("CE");

      expect(calculator.expression, '1 +');
      expect(calculator.entry, '0');
    });

    test('CE resets the calculator in result state', () {
      final calculator = Calculator();

      calculator.update("1");
      calculator.update("+");
      calculator.update("2");
      calculator.update("=");

      expect(calculator.entry, '3');
      expect(calculator.expression, '1 + 2 =');

      calculator.update("CE");

      expect(calculator.expression, '');
      expect(calculator.entry, '0');
    });
  });

  group('initial state tests', () {
    test('= pushes default 0 to expression', () {
      final calculator = Calculator();

      calculator.update("=");

      expect(calculator.entry, '0');
      expect(calculator.expression, '0 =');
    });

    test('+ pushes default 0 to expression', () {
      final calculator = Calculator();

      calculator.update("+");

      expect(calculator.entry, '0');
      expect(calculator.expression, '0 +');
    });

    test('- pushes default 0 to expression', () {
      final calculator = Calculator();

      calculator.update("-");

      expect(calculator.entry, '0');
      expect(calculator.expression, '0 -');
    });

    test('/ pushes default 0 to expression', () {
      final calculator = Calculator();

      calculator.update("/");

      expect(calculator.entry, '0');
      expect(calculator.expression, '0 /');
    });

    test('* pushes default 0 to expression', () {
      final calculator = Calculator();

      calculator.update("*");

      expect(calculator.entry, '0');
      expect(calculator.expression, '0 *');
    });

    test('% pushes default 0 to expression', () {
      final calculator = Calculator();

      calculator.update("%");

      expect(calculator.entry, '0');
      expect(calculator.expression, '0 %');
    });

    test('0 cannot be negated', () {
      final calculator = Calculator();

      calculator.update("0");
      calculator.update("negate");

      expect(calculator.entry, '0');
      expect(calculator.expression, '');
    });

    test('values can be entered', () {
      final calculator = Calculator();

      calculator.update("1");

      expect(calculator.entry, '1');
      expect(calculator.expression, '');
    });
  });

  group('a state tests', () {
    test('= pushes value to expression', () {
      final calculator = Calculator();

      calculator.update("1");
      calculator.update("=");

      expect(calculator.entry, '1');
      expect(calculator.expression, '1 =');
    });

    test('numbers can be negated', () {
      final calculator = Calculator();

      calculator.update("1");
      calculator.update("negate");

      expect(calculator.entry, '-1');
      expect(calculator.expression, '');
    });

    test('leading zeroes are replaced with values', (){
      final calculator = Calculator();

      calculator.update("0");
      calculator.update("1");

      expect(calculator.entry, '1');
      expect(calculator.expression, '');
    });

    test('backspace sets single digit values to 0', (){
      final calculator = Calculator();

      calculator.update("1");

      expect(calculator.entry, '1');
      expect(calculator.expression, '');

      calculator.update("⌫");

      expect(calculator.entry, '0');
      expect(calculator.expression, '');
    });

    test('backspace removes last digit from multi-digit values', (){
      final calculator = Calculator();

      calculator.update("10");

      expect(calculator.entry, '10');
      expect(calculator.expression, '');

      calculator.update("⌫");

      expect(calculator.entry, '1');
      expect(calculator.expression, '');
    });
  });

  group('transition state tests', () {
    test('operations replace previous operation', (){
      final calculator = Calculator();

      calculator.update("1");
      calculator.update("+");
      calculator.update("-");

      expect(calculator.entry, '1');
      expect(calculator.expression, '1 -');
    });

    test('numbers replace existing entry', () {
      final calculator = Calculator();

      calculator.update("1");
      calculator.update("+");
      calculator.update("2");

      expect(calculator.entry, '2');
      expect(calculator.expression, '1 +');
    });
  });

  group('b state tests', () {
    test('= pushes previous value to stack', () {
      final calculator = Calculator();

      calculator.update("1");
      calculator.update("+");
      calculator.update("=");

      expect(calculator.entry, '2');
      expect(calculator.expression, '1 + 1 =');
    });

    test('operations trigger calculations', () {
      final calculator = Calculator();

      calculator.update("1");
      calculator.update("+");
      calculator.update("2");
      calculator.update("*");

      expect(calculator.entry, '3');
      expect(calculator.expression, '3 *');
    });

    test('numbers modify existing entry', () {
      final calculator = Calculator();

      calculator.update("1");
      calculator.update("+");
      calculator.update("2");
      calculator.update("3");

      expect(calculator.entry, '23');
      expect(calculator.expression, '1 +');
    });
  });

  group('result state tests', () {
    test('calculations can be repeated', () {
      final calculator = Calculator();

      calculator.update("1");
      calculator.update("+");
      calculator.update("2");
      calculator.update("=");

      expect(calculator.entry, '3');
      expect(calculator.expression, '1 + 2 =');

      calculator.update("=");

      expect(calculator.entry, '5');
      expect(calculator.expression, '3 + 2 =');

      calculator.update("=");

      expect(calculator.entry, '7');
      expect(calculator.expression, '5 + 2 =');
    });

    test('operations reset stack with previous result', (){
      final calculator = Calculator();

      calculator.update("5");
      calculator.update("+");
      calculator.update("6");
      calculator.update("=");

      expect(calculator.entry, '11');
      expect(calculator.expression, '5 + 6 =');

      calculator.update("/");

      expect(calculator.entry, '11');
      expect(calculator.expression, '11 /');
    });

    test('numbers clear the stack and set the entry', () {
      final calculator = Calculator();

      calculator.update("7");
      calculator.update("%");
      calculator.update("4");
      calculator.update("=");

      expect(calculator.entry, '3');
      expect(calculator.expression, '7 % 4 =');

      calculator.update("8");

      expect(calculator.entry, '8');
      expect(calculator.expression, '');
    });

    test('negate clears the stack and negates the entry', (){
      final calculator = Calculator();

      calculator.update("0");
      calculator.update("-");
      calculator.update("6");
      calculator.update("=");

      expect(calculator.entry, '-6');
      expect(calculator.expression, '0 - 6 =');

      calculator.update("negate");

      expect(calculator.entry, '6');
      expect(calculator.expression, '');
    });

    test('decimal clears the stack and sets value to 0.', (){
      final calculator = Calculator();

      calculator.update("1");
      calculator.update("/");
      calculator.update("5");
      calculator.update("=");

      expect(calculator.entry, '0.2');
      expect(calculator.expression, '1 / 5 =');

      calculator.update(".");

      expect(calculator.entry, '0.');
      expect(calculator.expression, '');
    });

    test('backspace sets single digit values to 0', (){
      final calculator = Calculator();

      calculator.update("1");
      calculator.update("+");
      calculator.update("2");
      calculator.update("=");

      expect(calculator.entry, '3');
      expect(calculator.expression, '1 + 2 =');

      calculator.update("⌫");

      expect(calculator.entry, '0');
      expect(calculator.expression, '');
    });

    test('backspace removes last digit from multi-digit values', (){
      final calculator = Calculator();

      calculator.update("10");
      calculator.update("+");
      calculator.update("2");
      calculator.update("=");

      expect(calculator.entry, '12');
      expect(calculator.expression, '10 + 2 =');

      calculator.update("⌫");

      expect(calculator.entry, '1');
      expect(calculator.expression, '');
    });
  });

  test('multiple decimals are ignored', () {
    final calculator = Calculator();

    calculator.update("1");
    calculator.update(".");
    calculator.update("1");

    expect(calculator.entry, '1.1');
    expect(calculator.expression, '');

    calculator.update(".");

    expect(calculator.entry, '1.1');
    expect(calculator.expression, '');
  });

  test('errors set value to "NaN"', () {
    final calculator = Calculator();

    calculator.update("1");
    calculator.update("/");
    calculator.update("0");
    calculator.update("=");

    expect(calculator.entry, 'Error');
    expect(calculator.expression, '');
  });
}
