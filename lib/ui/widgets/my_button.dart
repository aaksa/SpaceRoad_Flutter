import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';

import 'package:space_road/ui/assets.dart';
import 'package:space_road/ui/widgets/my_text.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double heigh;

  const MyButton(
    this.text, {
    super.key,
    required this.onPressed,
    this.heigh = 0,
  });

  @override
  Widget build(BuildContext context) {
    return SpriteButton.future(
      sprite: Future.value(Assets.button),
      pressedSprite: Future.value(Assets.button),
      onPressed: onPressed,
      height: 95,
      width: 250,
      label: MyText(
        text,
        heigh: heigh,
        fontSize: 26,
      ),
    );
  }
}
