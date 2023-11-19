import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'dart:async';
import 'dart:developer' as devLog;

import 'package:space_road/game_start/objects/asteroid.dart';
import 'package:space_road/game_start/objects/spaceship.dart';
import 'package:space_road/my_game.dart';

late SpriteAnimation explosion;

class GameStart extends MyGame with TapCallbacks {
  GameStart();

  // late Timer asteroidSpawnTimer;
  late Timer interval;
  int elapsedSecs = 2;
  late SpaceShip spaceShip; // Declare a variable to hold the instance

  @override
  Future<void> onLoad() async {
    super.onLoad();
    camera.moveTo(worldSize / 2);
    // Create an instance of the SpaceShip class
    spaceShip = SpaceShip();

    await loadSprite('asteroid.png');
    await loadSprite('Space1.png');
    await loadSprite('Space2.png');
    await loadSprite('Space3.png');
    await loadSprite('Space4.png');

    final exp1 = await loadSprite('explosion/explosion1.png');
    final exp2 = await loadSprite('explosion/explosion2.png');
    final exp3 = await loadSprite('explosion/explosion3.png');
    final exp4 = await loadSprite('explosion/explosion4.png');
    final exp5 = await loadSprite('explosion/explosion5.png');
    final exp6 = await loadSprite('explosion/explosion6.png');
    final exp7 = await loadSprite('explosion/explosion7.png');
    final exp8 = await loadSprite('explosion/explosion8.png');
    final exp9 = await loadSprite('explosion/explosion9.png');
    final exp10 = await loadSprite('explosion/explosion10.png');
    final exp11 = await loadSprite('explosion/explosion11.png');
    final exp12 = await loadSprite('explosion/explosion12.png');
    final exp13 = await loadSprite('explosion/explosion13.png');
    final exp14 = await loadSprite('explosion/explosion14.png');
    final exp15 = await loadSprite('explosion/explosion15.png');
    final exp16 = await loadSprite('explosion/explosion16.png');
    final exp17 = await loadSprite('explosion/explosion17.png');
    final exp18 = await loadSprite('explosion/explosion18.png');
    final exp19 = await loadSprite('explosion/explosion19.png');

    explosion = SpriteAnimation.spriteList([
      exp1,
      exp2,
      exp3,
      exp4,
      exp5,
      exp6,
      exp7,
      exp8,
      exp9,
      exp10,
      exp11,
      exp12,
      exp13,
      exp14,
      exp15,
      exp16,
      exp17,
      exp18,
      exp19
    ], stepTime: 0.05, loop: false);

    interval = Timer(
      1,
      onTick: () => elapsedSecs -= 1,
      repeat: true,
    );
    world.add(spaceShip);
  }

  @override
  void update(double dt) {
    // TODO: implement update
    // world.add(Asteroid());
    interval.update(dt);

    if (elapsedSecs <= 0) {
      elapsedSecs = 2;
      world.add(Asteroid());
    }

    if (spaceShip.kondisi == ShipState.dead) {
      gamestate = GameState.dead;
      overlays.add('GameOverMenu');
    }
    super.update(dt);
  }
  // Timer.periodic(Duration(seconds: 2), (timer) {
  //   world.add(Asteroid());
  // });

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);

    double screenWidth = size.x; // Assuming size represents the screen size
    double tapX = event.localPosition.x;
    // Check if the tap is on the left or right side
    if (tapX < screenWidth / 2) {
      // Tap on the left side
      spaceShip.updateAccelerationX(-1);
      // Add your left-side logic here
    } else {
      // Tap on the right side
      spaceShip.updateAccelerationX(1);
      // Add your right-side logic here
    }
    //  spaceShip.updateAccelerationX(-1);
    devLog.log(screenWidth.toString(), name: 'actualwidth');
    devLog.log(tapX.toString(), name: 'tapLocation');

    // if (Random.secure().nextBool()) {
    //   world.add(Asteroid());
    // } else {
    //   world.add(Asteroid());
    // }
  }

  @override
  void onTapUp(TapUpEvent event) {
    // TODO: implement onTapUp
    spaceShip.updateAccelerationX(0);

    super.onTapUp(event);
  }

  void spawnAsteroid() {
    if (Random.secure().nextBool()) {
      world.add(Asteroid());
    } else {
      world.add(Asteroid());
    }
  }

  @override
  void onDetach() {
    // TODO: implement onDetach
    // asteroidSpawnTimer.cancel();
    super.onDetach();
  }
}
