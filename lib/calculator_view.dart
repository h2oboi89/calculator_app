import 'package:calculator_app/calc_button.dart';
import 'package:calculator_app/calculator.dart';
import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  final Calculator calculator;

  CalculatorView({required this.calculator});

  @override
  State<CalculatorView> createState() => CalculatorViewState(calculator);
}

class CalculatorViewState extends State<CalculatorView> {
  String equation = "0";
  String result = "0";

  late Calculator _calculator;

  CalculatorViewState(Calculator calculator) {
    _calculator = calculator;
  }

  buttonPressed(String buttonText) {
    switch (buttonText) {
      case 'AC':
        _calculator.reset();
        break;
      case '=':
        _calculator.calculate();
        break;
      default:
        _calculator.update(buttonText);
        break;
    }

    setState(() {
      equation = _calculator.equation;
      result = _calculator.result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black54,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black54,
          leading: const Icon(Icons.settings, color: Colors.orange),
          actions: const [
            Padding(
              padding: EdgeInsets.only(top: 18.0),
              child: Text("DEG", style: TextStyle(color: Colors.white38)),
            ),
            SizedBox(width: 20),
          ],
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                  alignment: Alignment.bottomRight,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(result,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 80))),
                              const Icon(Icons.more_vert,
                                  color: Colors.orange, size: 30),
                              const SizedBox(width: 20),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(equation,
                                    style: const TextStyle(
                                      fontSize: 40,
                                      color: Colors.white38,
                                    )),
                              ),
                              IconButton(
                                icon: const Icon(Icons.backspace_outlined,
                                    color: Colors.orange, size: 30),
                                onPressed: () {
                                  buttonPressed("⌫");
                                },
                              ),
                              const SizedBox(width: 20),
                            ],
                          )
                        ],
                      ))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcButton('AC', Colors.white10, () => buttonPressed('AC')),
                  calcButton('%', Colors.white10, () => buttonPressed('%')),
                  calcButton('÷', Colors.white10, () => buttonPressed('÷')),
                  calcButton("x", Colors.white10, () => buttonPressed('x')),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcButton('7', Colors.white24, () => buttonPressed('7')),
                  calcButton('8', Colors.white24, () => buttonPressed('8')),
                  calcButton('9', Colors.white24, () => buttonPressed('9')),
                  calcButton('-', Colors.white10, () => buttonPressed('-')),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcButton('4', Colors.white24, () => buttonPressed('4')),
                  calcButton('5', Colors.white24, () => buttonPressed('5')),
                  calcButton('6', Colors.white24, () => buttonPressed('6')),
                  calcButton('+', Colors.white10, () => buttonPressed('+')),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround
                    children: [
                      Row(
                        children: [
                          calcButton(
                              '1', Colors.white24, () => buttonPressed('1')),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04),
                          calcButton(
                              '2', Colors.white24, () => buttonPressed('2')),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04),
                          calcButton(
                              '3', Colors.white24, () => buttonPressed('3')),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          calcButton('+/-', Colors.white24,
                              () => buttonPressed('+/-')),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04),
                          calcButton(
                              '0', Colors.white24, () => buttonPressed('0')),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04),
                          calcButton(
                              '.', Colors.white24, () => buttonPressed('.')),
                        ],
                      ),
                    ],
                  ),
                  calcButton('=', Colors.orange, () => buttonPressed('=')),
                ],
              )
            ],
          ),
        ));
  }
}
