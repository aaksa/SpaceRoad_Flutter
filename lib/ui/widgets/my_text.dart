import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final double? heigh;

  const MyText(
    this.text, {
    super.key,
    this.fontSize = 28,
    this.color = Colors.white,
    this.heigh = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        height: heigh,
        fontWeight: FontWeight.w800,
        fontFamily: 'Quinque',
      ),
    );
  }
}
