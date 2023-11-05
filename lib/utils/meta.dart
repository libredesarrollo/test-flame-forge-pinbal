import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame/palette.dart';

BodyComponent createMeta(Forge2DGame game, {double? strokeWidth}) {
  final visibleRect = game.camera.visibleWorldRect;
  final topLeft = visibleRect.topLeft.toVector2();
  final topRight = visibleRect.topRight.toVector2();

  topLeft.x /= 6;
  topRight.x /= 6;

  return Meta(topLeft, topRight, strokeWidth: strokeWidth);
}

class Meta extends BodyComponent {
  final Vector2 start;
  final Vector2 end;
  late final Vector2 gameSize;
  final double strokeWidth;
  int fact = 50;

  Meta(this.start, this.end, {double? strokeWidth})
      : strokeWidth = strokeWidth ?? 1;

  @override
  Body createBody() {
    final shape = EdgeShape()..set(start, end);

    final fixtureDef = FixtureDef(shape, friction: 0.3);
    final bodyDef = BodyDef(
      userData: this, // To be able to determine object in collision
      position: Vector2.zero(),
    );

    paint = BasicPalette.red.paint();
    paint.strokeWidth = strokeWidth;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  Future<void> onLoad() {
    gameSize = game.screenToWorld(camera.viewport.size);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (body.position.x > gameSize.x || body.position.x < -gameSize.x)
      fact *= -1;
    body.setTransform(Vector2(body.position.x + fact * dt, body.position.y), 0);
    super.update(dt);
  }
}
