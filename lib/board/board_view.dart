import 'package:dot_and_box/board/gadgets/line.dart';
import 'package:dot_and_box/board/gadgets/tile.dart';
import 'package:dot_and_box/game/game_view_model.dart';
import 'package:dot_and_box/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoardView extends ConsumerWidget {
  static const lineWidth = 12.0;
  static const tileSize = 50.0;
  const BoardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var board = ref.watch(gameProvider.select((value) => value.model.board));
    double W = board.W * tileSize + (board.W + 1) * lineWidth;
    double H = board.H * tileSize + (board.H + 1) * lineWidth;
    var gadgets = <Widget>[];
    for (int i in range(board.H + 1)) {
      for (int j in range(board.W + 1)) {
        double top = i * (lineWidth + tileSize);
        double left = j * (lineWidth + tileSize);

        /// tile
        if (i < board.H && j < board.W) {
          gadgets.add(Positioned(
            left: left + lineWidth,
            top: top + lineWidth,
            width: tileSize,
            height: tileSize,
            child: Tile(i, j),
          ));
        }

        /// horizontal line
        if (j < board.W) {
          gadgets.add(Positioned(
            left: left + lineWidth,
            top: top,
            width: tileSize,
            height: lineWidth,
            child: Line((i, j), (i, j + 1)),
          ));
        }

        /// vertical line
        if (i < board.H) {
          gadgets.add(Positioned(
            left: left,
            top: top + lineWidth,
            width: lineWidth,
            height: tileSize,
            child: Line((i, j), (i + 1, j)),
          ));
        }
      }
    }
    return Container(
      width: W,
      height: H,
      child: Stack(children: gadgets),
    );
  }
}
