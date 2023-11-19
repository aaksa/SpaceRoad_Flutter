import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:space_road/game_start/objects/object_state.dart';
import 'package:space_road/my_game.dart';

import '../game_start.dart';

class Asteroid extends BodyComponent with ContactCallbacks {
  final size = Vector2(.6, .6);
  ObjectState state = ObjectState.normal;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
    final sprite = Sprite(game.images.fromCache('asteroid.png'));

    add(SpriteComponent(
      sprite: sprite,
      size: Vector2(.8, .8),
      anchor: Anchor.center,
    ));
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (state == ObjectState.explode) {
      world.destroyBody(body);
      game.world.remove(this);
    }

    // Check if the asteroid is below the screen
    if (state != ObjectState.explode && body.position.y > worldSize.y) {
      world.destroyBody(body);
      game.world.remove(this);
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

  @override
  Body createBody() {
    final randomX = Random().nextDouble() * worldSize.x;

    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(randomX, 0),
      type: BodyType.dynamic,
    );

    final shape = CircleShape()..radius = .25;
    final fixtureDef = FixtureDef(shape)
      ..density = 5
      ..friction = .5
      ..restitution = .5;
    return world.createBody(bodyDef)
      ..createFixture(fixtureDef)
      ..angularVelocity = radians(180);
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is Asteroid) {
      hit();
    }
  }
}
