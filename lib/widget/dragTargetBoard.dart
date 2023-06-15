import 'package:fidibo_game/models/object.dart';
import 'package:flutter/material.dart';

class DragTargetBoard extends StatelessWidget {
  const DragTargetBoard({
    super.key,
    required this.objectInGame,
    required this.boxConstraints,
  });

  final List<GameObject> objectInGame;
  final BoxConstraints? boxConstraints;

  @override
  Widget build(BuildContext context) {
    return DragTarget<Type>(
      builder: (context, candidateData, rejectedData) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: Stack(
            children: [
              ...objectInGame.map<Widget>(
                (GameObject e) => e.widget,
              ),
            ],
          ),
        );
      },
    );
  }
}
