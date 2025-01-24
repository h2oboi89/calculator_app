import 'package:calculator_app/calculator_view.dart';
import 'package:calculator_app/calculator.dart';
import 'package:flutter/material.dart';

void main() {
  final calculator = Calculator();

  runApp(CalculatorApp(
    calculator: calculator,
  ));
}

class CalculatorApp extends StatelessWidget {
  final Calculator calculator;

  const CalculatorApp({required this.calculator});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: true,
      home: CalculatorView(calculator: calculator),
    );
  }
}
