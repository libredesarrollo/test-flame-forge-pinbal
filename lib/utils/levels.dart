import 'package:flame/components.dart';

enum TypeObstacle { box, circle }

class Obstacle {
  Vector2 position;
  Vector2 size;
  TypeObstacle typeObstacle;

  Obstacle(
      {required this.position,
      required this.size,
      this.typeObstacle = TypeObstacle.circle});
}

// levels
List<Obstacle> getCurrentLevel({int level = 1}) {
  switch (level) {
    case 1:
      return [
        Obstacle(
            position: Vector2(5, 5),
            size: Vector2(5, 5),
            typeObstacle: TypeObstacle.circle),
        Obstacle(
            position: Vector2(5, 5),
            size: Vector2(5, 5),
            typeObstacle: TypeObstacle.box),
      ];
    default:
      return [];
  }
}
