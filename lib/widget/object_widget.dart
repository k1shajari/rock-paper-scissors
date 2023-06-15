import 'package:fidibo_game/models/object.dart';
import 'package:flutter/material.dart';

class GameObjectWidget extends StatelessWidget {
  const GameObjectWidget({
    super.key,
    required this.object,
  });

  final GameObject object;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: object.width,
      height: object.height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: Image.asset(object.image),
    );
  }
}
