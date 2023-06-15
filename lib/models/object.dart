// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fidibo_game/widget/object_widget.dart';
import 'package:flutter/material.dart';

abstract class GameObject {
  final double height;
  final double width;
  final String image;

  double sx; // Start x
  double sy; // Start y
  double dx; // Destination Point x
  double dy; // Destination Point y

  GameObject({
    this.height = 50,
    this.width = 50,
    required this.image,
    required this.sx,
    required this.sy,
    required this.dx,
    required this.dy,
  });

  Widget get widget => Positioned(
        top: sy,
        left: sx,
        child: GameObjectWidget(
          key: UniqueKey(),
          object: this,
        ),
      );
}
