import 'package:calculator_app/calculator.dart';
import 'package:test/test.dart';

void main() {
  group("calculator tests", () {
    test('0 = 0', () {
      final calculator = Calculator();

      calculator.update("0");
      calculator.update("=");

      expect(calculator.expression, '0 =');
      expect(calculator.entry, '0');
    });
  });
}
