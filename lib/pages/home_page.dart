import 'dart:math';

import 'package:fidibo_game/models/object.dart';
import 'package:fidibo_game/models/paper.dart';
import 'package:fidibo_game/models/rock.dart';
import 'package:fidibo_game/models/Scissors.dart';
import 'package:fidibo_game/widget/dragTargetBoard.dart';
import 'package:fidibo_game/widget/draggable_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

const APPBAR_HEIGHT = 60.0;
const PADDING_SIZE = 24.0;
const BORDER_WIDTH = 1.0;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final random = Random();
  BoxConstraints? _boxConstraints;
  List<GameObject> objectInGame = [];

  List<GameObject> objects = [
    ...List.generate(
      5,
      (index) => Rock(sx: 0, sy: 0, dx: 0, dy: 0),
    ),
    ...List.generate(
      5,
      (index) => Paper(sx: 0, sy: 0, dx: 0, dy: 0),
    ),
    ...List.generate(
      5,
      (index) => Scissors(sx: 0, sy: 0, dx: 0, dy: 0),
    )
  ];

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: APPBAR_HEIGHT,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(PADDING_SIZE),
              child: LayoutBuilder(
                builder: (context, boxConstraints) {
                  _boxConstraints = boxConstraints;
                  return DragTargetBoard(
                    objectInGame: objectInGame,
                    boxConstraints: boxConstraints,
                  );
                },
              ),
            ),
          ),
          DraggableListWidget(
            objects: objects,
            onDragCompleted: onDragCompleted,
          ),
        ],
      ),
    );
  }

  void onDragCompleted(DraggableDetails dragDetails, int index) {
    const xOffset = PADDING_SIZE + BORDER_WIDTH;
    const yOffset = PADDING_SIZE + BORDER_WIDTH + APPBAR_HEIGHT;

    if (dragDetails.offset.dx < PADDING_SIZE + BORDER_WIDTH ||
        dragDetails.offset.dx >
            xOffset + _boxConstraints!.maxWidth.toDouble() ||
        dragDetails.offset.dy < yOffset ||
        dragDetails.offset.dy >
            yOffset + _boxConstraints!.maxHeight.toDouble()) {
      return;
    }

    final obj = objects[index];
    final sx = dragDetails.offset.dx - xOffset;
    final sy = dragDetails.offset.dy - yOffset;

    final dx =
        (random.nextInt(100) + 150).toDouble() * (random.nextBool() ? 1 : -1);
    final dy =
        (random.nextInt(100) + 150).toDouble() * (random.nextBool() ? 1 : -1);

    switch (obj.runtimeType) {
      case Rock:
        setState(() {
          objects.removeAt(index);
          objectInGame.add(
            Rock(sx: sx, sy: sy, dx: dx, dy: dy),
          );
        });
        break;

      case Paper:
        setState(() {
          objects.removeAt(index);
          objectInGame.add(
            Paper(sx: sx, sy: sy, dx: dx, dy: dy),
          );
        });
        break;

      case Scissors:
        setState(() {
          objects.removeAt(index);
          objectInGame.add(
            Scissors(sx: sx, sy: sy, dx: dx, dy: dy),
          );
        });
        break;

      default:
    }
  }

  void startTimer() {
    Ticker ticker = Ticker((elapsed) {
      setState(() {
        objectInGame.toList().forEach((GameObject item) {
          item.sx += item.dx * elapsed.inSeconds / 1000;
          item.sy += item.dy * elapsed.inSeconds / 1000;

          if (item.sx < 0 || item.sx > _boxConstraints!.maxWidth - 50) {
            item.dx *= -1;
          }
          if (item.sy < 0 || item.sy > _boxConstraints!.maxHeight - 50) {
            item.dy *= -1;
          }
        });
        for (int i = 0; i < objectInGame.length; i++) {
          for (int j = i + 1; j < objectInGame.length; j++) {
            if (checkCollision(objectInGame[i], objectInGame[j])) {
              handleCollision(objectInGame[i], objectInGame[j]);
            }
          }
        }
      });
    });
    ticker.start();
  }

  bool checkCollision(GameObject item1, GameObject item2) {
    double dx = item1.sx - item2.sx;
    double dy = item1.sy - item2.sy;
    double distance = sqrt(dx * dx + dy * dy);
    return distance < 50;
  }

  void handleCollision(GameObject item1, GameObject item2) {
    if (item1.runtimeType == item2.runtimeType) {
      double tempdx = item1.dx;
      double tempdy = item1.dy;
      item1.dx = item2.dx;
      item1.dy = item2.dy;
      item2.dx = tempdx;
      item2.dy = tempdy;
    } else {
      if (item1.runtimeType == Rock && item2.runtimeType == Scissors ||
          item1.runtimeType == Paper && item2.runtimeType == Rock ||
          item1.runtimeType == Scissors && item2.runtimeType == Paper) {
        objectInGame.remove(item2);
      } else {
        objectInGame.remove(item1);
      }
    }
  }
}
