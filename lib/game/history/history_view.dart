import 'dart:math';

import 'package:dot_and_box/game/game_view_model.dart';
import 'package:dot_and_box/game/history/state_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

int lastSelectedState = 0;

class HistoryView extends ConsumerWidget {
  static const historyTextStyle = TextStyle(fontSize: 20);

  const HistoryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(gameProvider.select((value) => value.model.stateHistory.length));
    var stateHistory = ref.read(gameProvider).model.stateHistory;
    return Column(children: [
      Material(
        elevation: 1,
        child: ListTile(
          horizontalTitleGap: 0,
          // tileColor: Colors.blueGrey[200],
          leading: IconButton(
            // color: Colors.white,
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              lastSelectedState = max(0, lastSelectedState - 1);
              ref.read(gameProvider).loadHistory(lastSelectedState);
            },
          ),
          trailing: IconButton(
            // color: Colors.white,
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () {
              int latest = ref.read(gameProvider).model.stateHistory.length - 1;
              lastSelectedState = min(latest, lastSelectedState + 1);
              ref.read(gameProvider).loadHistory(lastSelectedState);
            },
          ),
          title: const Center(
            child: Text("History", style: historyTextStyle),
          ),
        ),
      ),
      Expanded(
        child: ListView.builder(
          itemCount: stateHistory.length,
          itemExtent: 30,
          itemBuilder: (ctx, idx) => StateView(stateHistory[idx]),
        ),
      ),
    ]);
  }
}
