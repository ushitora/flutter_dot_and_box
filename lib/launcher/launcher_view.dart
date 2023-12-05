import 'dart:math';

import 'package:dot_and_box/game/game_view.dart';
import 'package:dot_and_box/game/game_view_model.dart';
import 'package:dot_and_box/home/home_view.dart';
import 'package:dot_and_box/launcher/adjuster_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LauncherView extends ConsumerWidget {
  static const iconSize = 40.0;
  static const iconBgColor = Colors.blueGrey;
  static final iconFgColor = Colors.blueGrey[50]!;

  const LauncherView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: 500,
                  height: 400,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: iconBgColor.shade200,
                    width: 5,
                  )),
                  child: const GameView(),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: CircleAvatar(
                    backgroundColor: iconBgColor,
                    radius: iconSize - 5,
                    child: IconButton(
                      tooltip: "start game",
                      icon: FittedBox(
                          child: Icon(Icons.start,
                              size: iconSize, color: iconFgColor)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => const HomeView()));
                      },
                    ),
                  ),
                )
              ],
            ),
            Container(
              width: 400,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AdjusterView(
                    label: "num players",
                    value: ref.watch(gameProvider).model.players.length,
                    onMinusButtonPressed: () =>
                        ref.read(gameProvider).removeLastPlayer(),
                    onPlusButtonPressed: () =>
                        ref.read(gameProvider).addAnonymousPlayer(),
                  ),
                  const Divider(thickness: 2, color: Colors.black38),
                  AdjusterView(
                    label: "board width",
                    value: ref.watch(gameProvider).model.board.W,
                    onMinusButtonPressed: () => decreaseBoardWidth(ref),
                    onPlusButtonPressed: () => increaseBoardWidth(ref),
                  ),
                  AdjusterView(
                    label: "board height",
                    value: ref.watch(gameProvider).model.board.H,
                    onMinusButtonPressed: () => decreaseBoardHeight(ref),
                    onPlusButtonPressed: () => increaseBoardHeight(ref),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void increaseBoardWidth(WidgetRef ref) {
    var board = ref.read(gameProvider).model.board;
    ref.read(gameProvider).setBoardSize(width: board.W + 1, height: board.H);
  }

  void decreaseBoardWidth(WidgetRef ref) {
    var board = ref.read(gameProvider).model.board;
    ref
        .read(gameProvider)
        .setBoardSize(width: max(board.W - 1, 1), height: board.H);
  }

  void increaseBoardHeight(WidgetRef ref) {
    var board = ref.read(gameProvider).model.board;
    ref.read(gameProvider).setBoardSize(width: board.W, height: board.H + 1);
  }

  void decreaseBoardHeight(WidgetRef ref) {
    var board = ref.read(gameProvider).model.board;
    ref
        .read(gameProvider)
        .setBoardSize(width: board.W, height: max(board.H - 1, 1));
  }
}
