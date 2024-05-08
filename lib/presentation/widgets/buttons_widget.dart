import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  String text;
  double fontSize;
  VoidCallback function;
  Color color;
  double rounded;
  Size size;
  double padding;
  ButtonWidget(
      {super.key,
      required this.text,
      required this.size,
      required this.color,
      required this.rounded,
      required this.function,
      required this.fontSize,
      required this.padding});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      style: TextButton.styleFrom(
        alignment: Alignment.center,
        backgroundColor: color,
        fixedSize: size,
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(rounded))),
        padding: EdgeInsets.all(padding),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize, color: Colors.black),
      ),
    );
  }
}
