import 'package:dot_and_box/game/game_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InfoView extends ConsumerWidget {
  static const radius = 20.0;
  static const scoreStyle = TextStyle(fontSize: 40);

  const InfoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(gameProvider).model;
    var scores = <Widget>[];

    for (var p in model.players) {
      var nameStyle = TextStyle(
        fontSize: 20,
        color: p == model.currentPlayer ? Colors.black : Colors.grey,
      );
      scores.add(Column(
        children: [
          Text("${model.board.score(p)}", style: scoreStyle),
          Row(
            children: [
              Container(
                width: radius,
                height: radius,
                decoration: BoxDecoration(
                  color: p.color,
                  shape: BoxShape.circle,
                ),
              ),
              Container(width: 10),
              Text(p.name, style: nameStyle),
            ],
          )
        ],
      ));
      if (p != model.players.last) {
        scores.add(
          Column(
            children: [
              Container(width: 30, height: 6, color: Colors.black),
              Container(height: 30),
            ],
          ),
        );
      }
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: scores,
        ),
        if (model.board.allFilled()) const Text("Finish!", style: scoreStyle),
      ],
    );
  }
}
