import 'package:calculator_app/calculator.dart';
import 'package:calculator_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Calculator starts off initialized with 0 and no expression',
      (tester) async {
    final (calculator, app) = await givenEverythingIsInitialized(tester);

    expect(calculator.entry, "0");
    expect(calculator.expression, "");
  });

  testWidgets('Calculator can perform simple addition', (tester) async {
    final (calculator, app) = await givenEverythingIsInitialized(tester);

    await givenTheFollowingButtonsArePushed(tester, "1 2 + 3 4 =");

    expect(calculator.entry, "46");
    expect(calculator.expression, "12 + 34 =");
  });

  testWidgets('Calculator can perform simple subtraction', (tester) async {
    final (calculator, app) = await givenEverythingIsInitialized(tester);

    await givenTheFollowingButtonsArePushed(tester, "6 9 - 4 2 =");

    expect(calculator.entry, "27");
    expect(calculator.expression, "69 - 42 =");
  });

  testWidgets('Calculator can perform simple multiplication', (tester) async {
    final (calculator, app) = await givenEverythingIsInitialized(tester);

    await givenTheFollowingButtonsArePushed(tester, "5 x 8 =");

    expect(calculator.entry, "40");
    expect(calculator.expression, "5 * 8 =");
  });

  testWidgets('Calculator can perform simple division', (tester) async {
    final (calculator, app) = await givenEverythingIsInitialized(tester);

    await givenTheFollowingButtonsArePushed(tester, "2 4 . 5 ÷ 7 =");

    expect(calculator.entry, "3.5");
    expect(calculator.expression, "24.5 / 7 =");
  });

  testWidgets('Calculator can perform simple modulo', (tester) async {
    final (calculator, app) = await givenEverythingIsInitialized(tester);

    await givenTheFollowingButtonsArePushed(tester, "3 6 1 % 5 =");

    expect(calculator.entry, "1");
    expect(calculator.expression, "361 % 5 =");
  });

  testWidgets('Calculator can be reset using C', (tester) async {
    final (calculator, app) = await givenEverythingIsInitialized(tester);

    await givenTheFollowingButtonsArePushed(tester, "1 + 2 =");

    expect(calculator.entry, "3");
    expect(calculator.expression, "1 + 2 =");

    await givenTheFollowingButtonsArePushed(tester, "C");

    expect(calculator.entry, "0");
    expect(calculator.expression, "");
  });

  testWidgets('Calculator can reset entries using CE', (tester) async {
    final (calculator, app) = await givenEverythingIsInitialized(tester);

    await givenTheFollowingButtonsArePushed(tester, "1 + 2 0 CE 3 =");

    expect(calculator.entry, "4");
    expect(calculator.expression, "1 + 3 =");
  });

  testWidgets('Calculator can edit entries using ⌫', (tester) async {
    final (calculator, app) = await givenEverythingIsInitialized(tester);

    await givenTheFollowingButtonsArePushed(tester, "9 ⌫");

    expect(calculator.entry, "0");
    expect(calculator.expression, "");
  });

  testWidgets('Calculator can negate entries using ⁺∕₋', (tester) async {
    final (calculator, app) = await givenEverythingIsInitialized(tester);

    await givenTheFollowingButtonsArePushed(tester, "9 ⁺∕₋");

    expect(calculator.entry, "-9");
    expect(calculator.expression, "");
  });
}

Future<(Calculator, CalculatorApp)> givenEverythingIsInitialized(
    WidgetTester tester) async {
  tester.view.physicalSize = const Size(1000, 2500);

  final calculator = Calculator();
  final app = CalculatorApp(calculator: calculator);

  await tester.pumpWidget(app);

  return (calculator, app);
}

Future givenTheFollowingButtonsArePushed(
    WidgetTester tester, String buttons) async {
  for (var button in buttons.split(" ")) {
    await tester.tap(find.text(button));
    await tester.pump();
  }
}
