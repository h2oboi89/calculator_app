import 'package:flutter/material.dart';

Widget calcButton(
    String buttonText, Color buttonColor, void Function()? buttonPressed) {
  if (buttonText == "") {
    return SizedBox(
      width: 80,
      height: 75,
    );
  }

  return Container(
      width: 80,
      height: 75,
      padding: const EdgeInsets.all(0),
      child: ElevatedButton(
        onPressed: buttonPressed,
        style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            backgroundColor: buttonColor),
        child: Text(buttonText,
            style: const TextStyle(fontSize: 25, color: Colors.white)),
      ));
}
