import 'dart:math' as math;

import 'package:flame/events.dart';
import 'package:flutter/services.dart';

import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class BarBody extends BodyComponent with ContactCallbacks, KeyboardHandler {
  // sprite
  // late PlayerComponent _playerComponent;

  double _elapseTimeToHit = 0;
  final double _timeToHit = 1;
  final double _speedBar = 5;
  int _barDirection = 1;
  bool _hit = false;
  bool _barBack = false;

  Vector2 position;
  Vector2 size;

  BarBody(this.position, this.size) : super() {
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
    final shape = PolygonShape()..setAsBoxXY(size.x, size.y);
    final bodyDef =
        BodyDef(position: position, type: BodyType.kinematic, userData: this);
    FixtureDef fixtureDef =
        FixtureDef(shape, friction: 1, density: 1, restitution: 0);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (!_hit && keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      _hit = true;
      _barDirection = 1;
      // body.setTransform(body.position, math.pi / 2);
    }
    if (!_hit && keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      _hit = true;
      _barDirection = -1;
      // body.setTransform(body.position, math.pi / 2);
    }

    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void update(double dt) {
    /*
    
    if (_elapseTimeToHit < _timeToHit && _hit && !_barBack) {
      _elapseTimeToHit += dt * _speedBar;
      body.angularVelocity = math.pi * 3;
      // body.setTransform(body.position, math.pi * _elapseTimeToHit / 2);

      if (_elapseTimeToHit >= _timeToHit) {
        _barBack = true;
      }
    } else if (body.angle > 0 && _barBack) {
      _barBack = true;
      _elapseTimeToHit -= dt * _speedBar;
      body.angularVelocity = -math.pi * 3;
      // body.setTransform(body.position, math.pi * _elapseTimeToHit / 2);
    } else if (body.angle <= 0 && _hit) {
      _hit = false;
      _barBack = false;
      _elapseTimeToHit = 0;
      body.setTransform(body.position, 0);
      body.angularVelocity = 0;
    }
     */
    // if (_hit) {
    // print(body.angle);
    if (_elapseTimeToHit < _timeToHit && _hit && !_barBack) {
      _elapseTimeToHit += dt * _speedBar;
      body.angularVelocity = math.pi * 3 * _barDirection;
      // body.setTransform(body.position, math.pi * _elapseTimeToHit / 2);

      if (_elapseTimeToHit >= _timeToHit) {
        _barBack = true;
      }
    } else if (body.angle * _barDirection > 0 && _barBack) {
      // XXXXX
      _barBack = true;

      if (_barDirection == -1) {
        _elapseTimeToHit -= dt * _speedBar;
        body.angularVelocity = math.pi * 3;

        // // // //         _elapseTimeToHit -= dt * _speedBar;
        // // // // body.angularVelocity = -math.pi * 3;
      } else {
        _elapseTimeToHit -= dt * _speedBar;
        body.angularVelocity = -math.pi * 3;
      }
      // body.setTransform(body.position, math.pi * _elapseTimeToHit / 2);
    } else if (body.angle != 0 && _hit) {
      _hit = false;
      _barBack = false;
      _elapseTimeToHit = 0;
      body.setTransform(body.position, 0);
      body.angularVelocity = 0;
    }
    // }

    //else if (_elapseTimeToHit > _timeToHit) {}

    super.update(dt);
  }
}
