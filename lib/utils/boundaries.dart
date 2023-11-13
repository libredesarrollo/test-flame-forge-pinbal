import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:testpinball/components/bar_body.dart';
import 'package:testpinball/utils/meta.dart';

List<BodyComponent> createBoundaries(Forge2DGame game,
    {double? strokeWidth, int type = 1}) {
  final visibleRect = game.camera.visibleWorldRect;
  final topLeft = visibleRect.topLeft.toVector2();
  final topRight = visibleRect.topRight.toVector2();
  final bottomRight = visibleRect.bottomRight.toVector2();
  final bottomLeft = visibleRect.bottomLeft.toVector2();

  switch (type) {
    case 1:
      return [
        Wall(topRight, bottomRight, strokeWidth: strokeWidth),
        Wall(Vector2(bottomLeft.x, bottomLeft.y - 10),
            Vector2(bottomRight.x * .7, bottomRight.y),
            strokeWidth: strokeWidth),
        Wall(topLeft, bottomLeft, strokeWidth: strokeWidth),
        BarBody(Vector2(bottomRight.x * .7, bottomRight.y), Vector2(2, 14)),
        createMeta(game, strokeWidth: 2),
      ];
    default:
      return [
        Wall(topRight, bottomRight, strokeWidth: strokeWidth),
        Wall(Vector2(bottomLeft.x, bottomLeft.y - 10),
            Vector2(/*-20*/ bottomLeft.x / 3, bottomRight.y),
            strokeWidth: strokeWidth), // side left
        Wall(Vector2(/*20*/ bottomRight.x / 3, bottomLeft.y),
            Vector2(bottomRight.x, bottomRight.y - 10),
            strokeWidth: strokeWidth), // side right
        Wall(topLeft, bottomLeft, strokeWidth: strokeWidth),
        BarBody(Vector2(0, bottomRight.y), Vector2(2, bottomRight.x * .3)),
        createMeta(game, strokeWidth: 2),
      ];
  }
}

class Wall extends BodyComponent {
  final Vector2 start;
  final Vector2 end;
  final double strokeWidth;

  Wall(this.start, this.end, {double? strokeWidth})
      : strokeWidth = strokeWidth ?? 1;

  @override
  Body createBody() {
    final shape = EdgeShape()..set(start, end);
    final fixtureDef = FixtureDef(shape, friction: 0.3);
    final bodyDef = BodyDef(
      userData: this, // To be able to determine object in collision
      position: Vector2.zero(),
    );
    paint.strokeWidth = strokeWidth;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
