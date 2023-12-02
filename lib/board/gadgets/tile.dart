import 'package:dot_and_box/agent/agent.dart';
import 'package:dot_and_box/game/game_view_model.dart';
import 'package:dot_and_box/game/settings/settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Tile extends ConsumerWidget {
  static final defaultColor = Colors.grey[200];

  final int i;
  final int j;

  const Tile(this.i, this.j, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final opacity =
        ref.watch(settingsProvider.select((value) => value.tileOpacity));
    Agent? owner = ref
        .watch(gameProvider.select((value) => value.model.board.tiles[(i, j)]));
    return Container(
      // decoration: const BoxDecoration(
      //   borderRadius: BorderRadius.all(Radius.circular(5)),
      // ),
      color: owner?.color.withOpacity(opacity) ?? defaultColor,
    );
  }
}
