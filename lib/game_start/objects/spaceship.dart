import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:space_road/audio.dart';
import 'package:space_road/game_start/game_start.dart';
import 'package:space_road/game_start/objects/object_state.dart';
import 'package:space_road/high_scores.dart';
import 'package:space_road/my_game.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flame/events.dart';

enum ShipState {
  running,
  dead,
}

class SpaceShip extends BodyComponent<GameStart> with ContactCallbacks {
  final size = Vector2(.8, .8);
  ObjectState state = ObjectState.normal;

  double accelerationX = 0;
  var kondisi = ShipState.running;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
    final SharedPreferences prefs = await _prefs;

    final int shipnumber = prefs.getInt('currentShips') ?? 1;

    final sprite = Sprite(game.images.fromCache('Space$shipnumber.png'));

    add(SpriteComponent(
      sprite: sprite,
      size: Vector2(.8, .8),
      anchor: Anchor.center,
    ));
  }

  void updateAcc(double angka) {
    accelerationX = angka;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (state == ObjectState.explode) {
      world.destroyBody(body);
      game.world.remove(this);
    }

    final velocity = body.linearVelocity;
    final position = body.position;

    velocity.x = accelerationX * 5;
    body.linearVelocity = velocity;

    if (position.x > worldSize.x) {
      position.x = 0;
      body.setTransform(position, 0);
    } else if (position.x < 0) {
      position.x = worldSize.x;
      body.setTransform(position, 0);
    }
  }

  void hit() {
    if (state == ObjectState.normal) {
      state = ObjectState.explode;
      game.world.add(SpriteAnimationComponent(
        position: body.position,
        animation: explosion.clone(),
        anchor: Anchor.center,
        size: size,
        removeOnFinish: true,
      ));
    }
  }

  void updateAccelerationX(double newAccelerationX) {
    // Update the accelerationX variable
    accelerationX = newAccelerationX;
  }

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(worldSize.x / 2, worldSize.y - 1),
      type: BodyType.dynamic,
      gravityOverride: Vector2(0, 0),
    );

    final shape = PolygonShape()..setAsBoxXY(.25, .25);

    final fixtureDef = FixtureDef(shape)
      ..density = 5
      ..friction = .5
      ..restitution = .5;

    return world.createBody(bodyDef)
      ..createFixture(fixtureDef)
      ..angularVelocity = radians(0)
      ..setFixedRotation(true);
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is SpaceShip) {
    } else {
      hit();
      HighScores.saveNewScore(game.point);
      kondisi = ShipState.dead;
      Audio.failSound();
    }
  }
}
