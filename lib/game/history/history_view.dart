import 'package:dot_and_box/game/game_view_model.dart';
import 'package:dot_and_box/game/history/state_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

int lastSelected = 0;

class HistoryView extends ConsumerWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history =
        ref.watch(gameProvider.select((value) => value.model.history));
    return ListView.builder(
      itemCount: history.length,
      itemBuilder: (ctx, idx) => StateView(history[idx]),
    );
  }
}
