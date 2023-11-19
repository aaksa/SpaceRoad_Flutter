import 'package:flutter/material.dart';
import 'package:space_road/audio.dart';
import 'package:space_road/my_game.dart';
import 'package:space_road/routes.dart';
import 'package:space_road/ui/widgets/my_button.dart';
import 'package:space_road/ui/widgets/my_text.dart';

class PauseMenu extends StatelessWidget {
  final MyGame game;

  const PauseMenu({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Material(
      color: Colors.black38,
      child: Center(
        child: AspectRatio(
          aspectRatio: 9 / 19.5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: height * .25),
                const MyText(
                  'Pause',
                  fontSize: 40,
                  color: Color.fromARGB(255, 94, 255, 99),
                ),
                const SizedBox(height: 40),
                MyButton(
                  'Resume',
                  heigh: -0.01,
                  onPressed: () {
                    Audio.clickSound();
                    game.overlays.remove('PauseMenu');
                    game.paused = false;
                  },
                ),
                const SizedBox(height: 40),
                MyButton(
                  'Menu',
                  heigh: -0.01,
                  onPressed: () {
                    Audio.clickSound();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.menu,
                      (route) =>
                          false, // This predicate removes all previous routes
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
