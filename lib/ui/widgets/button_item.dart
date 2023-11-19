import 'package:flutter/material.dart';
import 'package:space_road/audio.dart';

class ButtonItem extends StatelessWidget {
  final String title;
  final String route;

  const ButtonItem({
    super.key,
    required this.title,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.deepPurple)),
          onPressed: () {
            Navigator.of(context).pushNamed(route);
            Audio.clickSound();
          },
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
