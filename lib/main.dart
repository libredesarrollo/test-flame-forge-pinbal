import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:testpinball/components/ball_body.dart';
import 'package:testpinball/components/bar_body.dart';

void main() {
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends Forge2DGame
    with TapDetector, HasKeyboardHandlerComponents {
  MyGame() : super(gravity: Vector2(0, 20));

  @override
  FutureOr<void> onLoad() {
    world.add(BarBody());
    world.add(BallBody());

    return super.onLoad();
  }
}
