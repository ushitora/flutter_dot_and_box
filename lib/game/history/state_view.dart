import 'package:dot_and_box/game/game_view_model.dart';
import 'package:dot_and_box/game/history/history_view.dart';
import 'package:dot_and_box/game/history/state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StateView extends ConsumerWidget {
  static const radius = 12.0;
  static const scoreStyle = TextStyle(fontSize: 16, color: Colors.black);
  static const idxStyle = TextStyle(fontSize: 12, color: Colors.grey);
  final StateModel model;

  const StateView(this.model, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int step = ref.watch(gameProvider.select((value) => value.model.numStep));
    Color? color;
    if (model.idx == lastSelectedState) {
      color = Colors.blueGrey[200];
    } else if (model.idx == step) {
      color = Colors.blueGrey[100];
    }
    return MouseRegion(
      onEnter: (event) {
        ref.read(gameProvider).loadHistory(model.idx);
      },
      onExit: (event) {
        ref.read(gameProvider).loadHistory(lastSelectedState);
      },
      child: ListTile(
        minVerticalPadding: 0,
        dense: true,
        tileColor: color,
        leading: Container(
          width: radius,
          height: radius,
          decoration: BoxDecoration(
            color: model.player.color,
            shape: BoxShape.circle,
          ),
        ),
        trailing: Text("${model.idx}", style: idxStyle),
        title: Text(model.scores.join(" - "), style: scoreStyle),
        // visualDensity: VisualDensity(vertical: .1),
        onTap: () {
          ref.read(gameProvider).loadHistory(model.idx);
          lastSelectedState = model.idx;
        },
      ),
    );
  }
}
