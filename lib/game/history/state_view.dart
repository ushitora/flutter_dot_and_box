import 'package:dot_and_box/game/game_view_model.dart';
import 'package:dot_and_box/game/history/history_view.dart';
import 'package:dot_and_box/game/history/state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StateView extends ConsumerWidget {
  static const radius = 10.0;
  final StateModel model;

  const StateView(this.model, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int step = ref.watch(gameProvider.select((value) => value.model.numStep));
    var color = null;
    if (model.idx == lastSelected) {
      color = Colors.blueGrey[200];
    } else if (model.idx == step) {
      color = Colors.blueGrey[100];
    }

    return MouseRegion(
      onEnter: (event) {
        ref.read(gameProvider).loadHistory(model.idx);
      },
      onExit: (event) {
        ref.read(gameProvider).loadHistory(lastSelected);
      },
      child: ListTile(
        tileColor: color,
        leading: Container(
          width: radius,
          height: radius,
          decoration: BoxDecoration(
            color: model.player.color,
            shape: BoxShape.circle,
          ),
        ),
        title: Text(model.scores.join(" - ")),
        onTap: () {
          ref.read(gameProvider).loadHistory(model.idx);
          lastSelected = model.idx;
        },
      ),
    );
  }
}
