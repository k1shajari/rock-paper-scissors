import 'package:fidibo_game/models/object.dart';
import 'package:fidibo_game/widget/object_widget.dart';
import 'package:flutter/material.dart';

class DraggableListWidget extends StatelessWidget {
  const DraggableListWidget({
    super.key,
    required this.objects,
    required this.onDragCompleted,
  });

  final List<GameObject> objects;
  final Function(DraggableDetails dragDetails, int index) onDragCompleted;

  List<Widget> renderListWidget() {
    List<Widget> widgets = [];

    for (var index = 0; index < objects.length; index++) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Draggable<Type>(
            data: objects[index].runtimeType,
            feedback: GameObjectWidget(
              object: objects[index],
            ),
            childWhenDragging: Container(
              width: 50,
              height: 50,
              color: Colors.grey,
            ),
            child: GameObjectWidget(
              object: objects[index],
            ),
            onDragEnd: (DraggableDetails dragDetails) =>
                onDragCompleted(dragDetails, index),
          ),
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.black26)),
        ),
        child: Wrap(
          children: renderListWidget(),
        ),
      ),
    );
  }
}
