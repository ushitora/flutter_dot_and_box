import 'package:dot_and_box/board/board_view.dart';
import 'package:dot_and_box/game/info/info_view.dart';
import 'package:flutter/material.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: FittedBox(
            child: BoardView(),
          ),
        ),
        Padding(
            padding: EdgeInsets.all(30),
            child: FittedBox(
              child: InfoView(),
            )),
      ],
    );
  }
}
