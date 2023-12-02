import 'package:dot_and_box/agent/agent.dart';
import 'package:dot_and_box/board/board_model.dart';
import 'package:dot_and_box/game/history/history_view.dart';
import 'package:dot_and_box/game/history/play_model.dart';
import 'package:dot_and_box/game/history/state_model.dart';
import 'package:dot_and_box/utils/utils.dart';
import 'package:flutter/material.dart';

class GameModel {
  Agent currentPlayer;
  final List<Agent> players;
  BoardModel board;
  List<PlayModel> playHistory;
  List<StateModel> stateHistory;

  int get numStep => board.lines.length;

  GameModel(this.currentPlayer, this.players, this.board, this.playHistory,
      this.stateHistory);

  static GameModel get init {
    final players = [
      const Agent("Player1", Colors.red),
      const Agent("Player2", Colors.blue),
      // const Agent("Player3", Colors.green),
    ];
    final board = BoardModel(7, 5);
    final first = players.first;
    final scores = [for (var p in players) 0];
    return GameModel(
        first, players, board, [], [(idx: 0, player: first, scores: scores)]);
  }

  /// return if some tiles were filled by drawing
  bool _drawLine(Agent agent, (int, int) p1, (int, int) p2) {
    try {
      bool updated = board.draw(agent, p1, p2);
      return updated;
    } catch (e, stackTrace) {
      rethrow;
    }
  }

  void drawAndToggle(
    Agent agent,
    (int, int) p1,
    (int, int) p2, {
    bool changeHistory = false,
  }) {
    int step = numStep;
    try {
      bool toToggle = !_drawLine(agent, p1, p2);
      if (toToggle) {
        int idx = players.indexOf(agent);
        int num = players.length;
        currentPlayer = players[(idx + 1) % num];
      }
      if (changeHistory) {
        _addHistory(step, agent, p1, p2);
        lastSelectedState = step + 1;
      }
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
    }
  }

  void _addHistory(int step, Agent agent, (int, int) p1, (int, int) p2) {
    PlayModel play = (idx: step, player: agent, p1: p1, p2: p2);
    if (step != playHistory.length) {
      playHistory.removeRange(step, playHistory.length);
      stateHistory.removeRange(step + 1, stateHistory.length);
    }
    // history.add(state);
    playHistory.add(play);
    stateHistory.add((
      idx: step + 1,
      player: currentPlayer,
      scores: [for (var p in players) board.score(p)]
    ));
  }

  GameModel load(int stateIdx) {
    var b = BoardModel(board.W, board.H);
    var model = GameModel(players.first, players, b, [], [stateHistory.first]);

    for (int i in range(stateIdx)) {
      model.drawAndToggle(
        playHistory[i].player,
        playHistory[i].p1,
        playHistory[i].p2,
      );
    }
    model.playHistory = playHistory;
    model.stateHistory = stateHistory;
    return model;
  }
}
