import 'package:fidibo_game/models/object.dart';

class Paper extends GameObject {
  Paper({
    super.image = 'paper.jpg',
    required super.sx,
    required super.sy,
    required super.dx,
    required super.dy,
  });
}
