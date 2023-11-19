import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame/timer.dart' as tm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:space_road/game_start/objects/background.dart';
import 'package:space_road/main.dart';
import 'package:space_road/routes.dart';
import 'package:space_road/ui/game_over_menu.dart';
import 'package:space_road/ui/game_ui.dart';
import 'package:space_road/ui/pause_menu.dart';
import 'package:space_road/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

final screenSize = Vector2(455, 926);
final worldSize = Vector2(4.55, 9.26);

const styler = TextStyle(
  color: Colors.white,
  fontFamily: 'Quinque',
  fontSize: 30.0, // Change the font size here
);
final regular = TextPaint(style: styler);

enum GameState {
  running,
  dead,
}

class MyGame extends Forge2DGame with KeyboardEvents {
  late SharedPreferences prefs;
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double defaultSize = 0;
  static Orientation? orientation;
  int elapsedSecs = 1;
  late tm.Timer intervals;

  int point = 0;

  var gamestate = GameState.running;

  // Keep track of the number of bodies in the world.
  final totalBodies =
      TextComponent(position: Vector2(30, 50), textRenderer: regular);

  // Keep track of the frames per second
  final fps = FpsTextComponent(position: Vector2(5, 665));

  // Scale the screenSize by 100 and set the gravity of 15
  MyGame()
      : super(
            zoom: 100,
            cameraComponent: CameraComponent.withFixedResolution(
              width: screenSize.x,
              height: screenSize.y,
            ),
            gravity: Vector2(0, 1));

  @override
  Future<void> onLoad() async {
    // Adds a black background to the backdrop
    prefs = await SharedPreferences.getInstance();

    prefs.setInt('point', 0);

    // Size screenSize = MediaQuery.of(context).size;

// Create a backdrop with the screen size

    camera.backdrop.add(Background());

    // camera.viewport.add(fps);
    camera.viewport.add(GameUI());
    camera.viewport.add(totalBodies);

    intervals = tm.Timer(
      2,
      onTick: () => elapsedSecs -= 1,
      repeat: true,
    );

    // camera.follow(hero);
  }

  // void init(BuildContext context) {
  //   _mediaQueryData = MediaQuery.of(context);
  //   screenWidth = _mediaQueryData!.size.width;
  //   screenHeight = _mediaQueryData!.size.height;
  //   orientation = _mediaQueryData!.orientation;
  //   screenSize = Vector2(screenWidth, screenHeight);

  //      final worldSize = Vector2(
  //     screenSize.x / 100 * 0.1, // Adjust the scaling factor as needed
  //     screenSize.y / 100 * 0.1, // Adjust the scaling factor as needed
  //   );
  //   worldSize =
  // }

  @override
  void update(double dt) {
    super.update(dt);
    // Updated the number of bodies in the world
    intervals.update(dt);
    totalBodies.text = '$point';

    if (elapsedSecs <= 0) {
      elapsedSecs = 1;

      if (gamestate == GameState.running) {
        updatePoint(1);
      }
    }
  }

  void updatePoint(int number) {
    point += number;
    prefs.setInt('point', point);
  }

  @override
  KeyEventResult onKeyEvent(RawKeyEvent event, Set keysPressed) {
    if (event is RawKeyDownEvent) {
      if (keysPressed.contains(LogicalKeyboardKey.escape)) {
        navigatorKey.currentState
            ?.pushNamedAndRemoveUntil(Routes.menu, (r) => false);
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  @override
  Color backgroundColor() {
    // Paints the background red
    return Colors.black;
  }
}

// Helper component that paints a black background
// class _Background extends PositionComponent {
//   _Background({super.size});

//   @override
//   void render(Canvas canvas) {
//     canvas.drawRect(Rect.fromLTRB(0, 0, 1000, 1000), blackPaint);
//   }
// }

class MyGameWidget extends StatelessWidget {
  final MyGame game;

  const MyGameWidget({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: GameWidget(
        game: game,
        overlayBuilderMap: {
          'GameOverMenu': (context, MyGame game) {
            return GameOverMenu(game: game);
          },
          'PauseMenu': (context, MyGame game) {
            return PauseMenu(game: game);
          }
        },
      ),
    );
  }
}
