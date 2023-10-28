import 'package:flame/events.dart';
import 'package:flutter/services.dart';

import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class BallBody extends BodyComponent with ContactCallbacks {
  // sprite
  // late PlayerComponent _playerComponent;

  BallBody() : super() {
    renderBody = true;
  }

  @override
  Future<void> onLoad() async {
    // _playerComponent = PlayerComponent();
    // add(_playerComponent);

    await super.onLoad();
  }

  @override
  Body createBody() {
    final shape = CircleShape()..radius = 3;
    final bodyDef = BodyDef(
        position: Vector2(0, 0), type: BodyType.dynamic, userData: this);
    FixtureDef fixtureDef =
        FixtureDef(shape, friction: 1, density: 5, restitution: 0);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void update(double dt) {
    // if (body.linearVelocity.y < 0) {
    //   body.linearVelocity *= 10;
    // }

    super.update(dt);
  }

  @override
  void beginContact(Object other, Contact contact) {
    // body.linearVelocity *= 1000;
    super.beginContact(other, contact);
  }
}
