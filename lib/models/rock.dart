import 'package:fidibo_game/models/object.dart';

class Rock extends GameObject {
  Rock({
    super.image = 'rock.jpg',
    required super.sx,
    required super.sy,
    required super.dx,
    required super.dy,
  });
}
