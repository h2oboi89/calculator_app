import "package:math_expressions/math_expressions.dart";

class Calculator {
  String equation = "";
  String result = "0";
  String expression = "";
  final Parser parser = Parser();

  void reset() {
    equation = "";
    result = "0";
    expression = "";
  }

  void update(String input) {
    // FUTURE: redo: each operation initiates calculation

    if (input == "⌫") {
      if (equation.isNotEmpty) {
        equation = equation.substring(0, equation.length - 1);
      }
    } else if (input == "+/-") {
      if (equation.isEmpty) {
        return;
      } else if (equation[0] != "-") {
        equation = "-$equation";
      } else {
        equation = equation.substring(1);
      }
    } else {
      if (equation == "") {
        equation = input;
      } else {
        equation = equation + input;
      }
    }
  }

  void calculate() {
    expression = equation;

    try {
      var exp = parser.parse(expression);

      var cm = ContextModel();
      result = "${exp.evaluate(EvaluationType.REAL, cm)}";
      if (expression.contains("/")) {
        result = _doesContainDecimal(result);
      }
    } catch (e) {
      result = "Error";
    }
  }

  // used to check if the result contains a decimal
  String _doesContainDecimal(dynamic result) {
    if (result.toString().contains(".")) {
      var splitDecimal = result.toString().split(".");
      if (!(int.parse(splitDecimal[1]) > 0)) {
        return result = splitDecimal[0].toString();
      }
    }
    return result;
  }
}
