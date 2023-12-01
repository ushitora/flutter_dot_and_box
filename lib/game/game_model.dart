import 'package:dot_and_box/agent/agent.dart';
import 'package:dot_and_box/board/board_model.dart';
import 'package:dot_and_box/game/history/state_model.dart';
import 'package:dot_and_box/utils/utils.dart';
import 'package:flutter/material.dart';

class GameModel {
  Agent currentPlayer;
  final List<Agent> players;
  BoardModel board;
  List<StateModel> history;

  int get numStep => board.lines.length;

  GameModel(this.currentPlayer, this.players, this.board, this.history);

  static GameModel get init {
    final players = [
      const Agent("Player1", Colors.red),
      const Agent("Player2", Colors.blue),
      // const Agent("Player3", Colors.green),
    ];
    final board = BoardModel(7, 5);
    return GameModel(players.first, players, board, []);
  }

  void addHistory(int step, Agent agent, (int, int) p1, (int, int) p2) {
    var scores = [for (var p in players) board.score(p)];
    var state = StateModel(step, agent, scores, p1, p2);
    if (step != history.length) {
      history.removeRange(step, history.length);
    }
    // history.add(state);
    history = [...history, state];
  }

  void load(int historyIndex) {
    var b = BoardModel(board.W, board.H);
    for (int i in range(historyIndex)) {
      b.draw(history[i].player, history[i].p1, history[i].p2);
    }
    var player = history[historyIndex].player;

    currentPlayer = player;
    board = b;
  }
}
