import 'package:flutter/material.dart';
import 'package:space_road/audio.dart';
import 'package:space_road/high_scores.dart';
import 'package:space_road/my_game.dart';
import 'package:space_road/routes.dart';
import 'package:space_road/ui/widgets/my_button.dart';
import 'package:space_road/ui/widgets/my_text.dart';

class GameOverMenu extends StatelessWidget {
  final MyGame game;

  const GameOverMenu({
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
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                SizedBox(height: height * .15),
                const MyText(
                  'Game Over',
                  fontSize: 40,
                  color: Colors.green,
                ),
                const SizedBox(height: 45),
                Table(
                  // border: TableBorder.all(),
                  columnWidths: const {
                    0: FlexColumnWidth(.1),
                    1: FlexColumnWidth(.5),
                    2: FlexColumnWidth(.2),
                    3: FlexColumnWidth(.1),
                  },
                  children: [
                    TableRow(
                      children: [
                        const SizedBox(),
                        const MyText('Score'),
                        MyText(game.point.toString()),
                        const SizedBox(),
                      ],
                    ),
                    const TableRow(
                      children: [
                        const SizedBox(),
                        const MyText(' '),
                        const MyText(' '),
                        const SizedBox(),
                      ],
                    ),
                    TableRow(
                      children: [
                        const SizedBox(),
                        const MyText('Best'),
                        MyText('${HighScores.highScore}'),
                        const SizedBox(),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 50),
                MyButton('Again', heigh: -0.01, onPressed: () {
                  Audio.clickSound();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.game,
                    (route) =>
                        false, // This predicate removes all previous routes
                  );
                }),
                const SizedBox(height: 20),
                MyButton('Home', heigh: -0.01, onPressed: () {
                  Audio.clickSound();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.menu,
                    (route) =>
                        false, // This predicate removes all previous routes
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
