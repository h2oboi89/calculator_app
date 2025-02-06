import "package:calculator_app/stack.dart";
import "package:math_expressions/math_expressions.dart";

// Initial and transition states exist to enable user input replacing the existing entry
// instead of merely updating it like it does in state a and b
enum CalculatorState {
  initial, // initial state
  a, // get first operand
  transition, // a -> b
  b, // get second operand
  result // have result
}

class Calculator {
  final Stack<String> _stack = Stack<String>();
  final Parser parser = Parser();
  late String entry;
  late CalculatorState _state;

  Calculator() {
    _reset();
  }

  String get expression {
    if (_stack.isEmpty) {
      return "";
    } else {
      return '$_stack';
    }
  }

  void update(String input) {
    if (input == "C") {
      _reset();
      return;
    }

    if (input == "CE") {
      _resetEntry();
      return;
    }

    switch (_state) {
      case CalculatorState.initial:
        _updateStateInitial(input);
        break;
      case CalculatorState.a:
        _updateStateA(input);
        break;
      case CalculatorState.transition:
        _updateTransition(input);
        break;
      case CalculatorState.b:
        _updateStateB(input);
        break;
      case CalculatorState.result:
        _updateStateResult(input);
        break;
    }
  }

  void _reset() {
    _resetState();
    _resetEntry();
  }

  void _resetState() {
    _stack.clear();
    _state = CalculatorState.initial;
  }

  void _resetEntry() {
    entry = "0";

    if (_state == CalculatorState.result) {
      _resetState();
    }
  }

  void _updateStateInitial(String input) {
    entry = "0";

    if (_isEquals(input)) {
      _stack.push(entry);
      _calculate();
      return;
    }

    if (_isOperation(input)) {
      _stack.push(entry);
      _stack.push(input);
      _state = CalculatorState.transition;
      return;
    }

    _setEntry(input);
    _state = CalculatorState.a;
  }

  void _updateStateA(String input) {
    if (_isEquals(input)) {
      _stack.push(entry);
      _calculate();
      return;
    }

    if (_isOperation(input)) {
      _stack.push(entry);
      _stack.push(input);
      _state = CalculatorState.transition;
      return;
    }

    _modifyEntry(input);
  }

  void _updateTransition(String input) {
    if (_isEquals(input)) {
      _stack.push(entry);
      _calculate();
      return;
    }

    if (_isOperation(input)) {
      _stack.pop();
      _stack.push(input);
      return;
    }

    _setEntry(input);
    _state = CalculatorState.b;
  }

  void _updateStateB(String input) {
    if (_isEquals(input)) {
      _stack.push(entry);
      _calculate();
      return;
    }

    if (_isOperation(input)) {
      _stack.push(entry);
      _calculate();
      _stack.clear();
      _stack.push(entry);
      _stack.push(input);
      _state = CalculatorState.transition;
      return;
    }

    _modifyEntry(input);
  }

  void _updateStateResult(String input) {
    if (_isEquals(input)) {
      _stack.pop(); // '='
      var b = _stack.pop();
      var op = _stack.pop();
      _stack.pop(); // clear out previous a
      _stack.push(entry);
      _stack.push(op);
      _stack.push(b);
      _calculate();
      return;
    }

    if (_isOperation(input)) {
      _stack.clear();
      _stack.push(entry);
      _stack.push(input);
      _state = CalculatorState.transition;
      return;
    }

    _stack.clear();
    _setEntry(input);
    _state = CalculatorState.a;
  }

  void _setEntry(String input) {
    switch (input) {
      case "negate":
        _modifyEntry(input);
        break;
      case ".":
        entry = "0";
        _addDecimal();
        break;
      case "⌫":
        _backspace();
        break;
      default:
        entry = input;
    }
  }

  void _modifyEntry(String input) {
    switch (input) {
      case "negate":
        _negate();
        break;
      case ".":
        _addDecimal();
        break;
      case "⌫":
        _backspace();
        break;
      default:
        if (entry == "0") {
          entry = input;
        } else {
          entry = entry + input;
        }
    }
  }

  void _negate() {
    if (entry == "0") {
      return;
    }

    if (entry[0] == "-") {
      entry = entry.substring(1);
    } else {
      entry = "-$entry";
    }
  }

  void _addDecimal() {
    if (_hasDecimal(entry)) {
      return;
    }

    entry = "$entry.";
  }

  void _backspace() {
    if (entry.length == 1) {
      entry = "0";
      return;
    }

    entry = entry.substring(0, entry.length - 1);
  }

  bool _isOperation(String value) {
    switch (value) {
      case '+':
      case '-':
      case '*':
      case '/':
      case '%':
        return true;
      default:
        return false;
    }
  }

  bool _isEquals(String value) {
    return value == "=";
  }

  bool _hasDecimal(String entry) {
    return entry.contains(".");
  }

  void _calculate() {
    try {
      var expression = "$_stack";
      var exp = parser.parse(expression);
      var cm = ContextModel();

      final result = exp.evaluate(EvaluationType.REAL, cm);

      if (result.floor() == result) {
        entry = "${result.toInt()}";
      } else {
        entry = "$result";
      }

      _stack.push("=");
      _state = CalculatorState.result;
    } catch (e) {
      _reset();
      entry = "Error";
    }
  }
}
