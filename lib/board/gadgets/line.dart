import 'package:dot_and_box/agent/agent.dart';
import 'package:dot_and_box/game/game_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Line extends ConsumerWidget {
  static const defaultColor = Colors.grey;

  final (int, int) p1;
  final (int, int) p2;

  const Line(this.p1, this.p2, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Agent? owner = ref.watch(
        gameProvider.select((value) => value.model.board.lines[(p1, p2)]));
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: owner?.color,
        backgroundColor: defaultColor,
      ),
      onPressed: owner == null
          ? () {
              var agent = ref.read(gameProvider).model.currentPlayer;
              ref.read(gameProvider).drawAndToggle(agent, p1, p2);
            }
          : null,
      child: Container(),
    );
  }
}
