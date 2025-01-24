import 'package:math_expressions/math_expressions.dart';

class Calculator {
  String equation = "0";
  String result = "0";
  String expression = "";
  Parser parser = Parser();

  void reset() {
    equation = "0";
    result = "0";
    expression = "";
  }

  void update(String input) {
    if (input == "⌫") {
      equation = equation.substring(0, equation.length - 1);
      if (equation == "") {
        equation = "0";
      }
    } else if (input == "+/-") {
      if (equation[0] != '-') {
        equation = '-$equation';
      } else {
        equation = equation.substring(1);
      }
    } else {
      if (equation == "0") {
        equation = input;
      } else {
        equation = equation + input;
      }
    }
  }

  void calculate() {
    expression = equation;
    expression = expression.replaceAll('x', '*');
    expression = expression.replaceAll('÷', '/');
    expression = expression.replaceAll('%', '%');

    try {
      var exp = parser.parse(expression);

      var cm = ContextModel();
      result = '${exp.evaluate(EvaluationType.REAL, cm)}';
      if (expression.contains('%')) {
        result = _doesContainDecimal(result);
      }
    } catch (e) {
      result = "Error";
    }
  }

  // used to check if the result contains a decimal
  String _doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      var splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) {
        return result = splitDecimal[0].toString();
      }
    }
    return result;
  }
}
