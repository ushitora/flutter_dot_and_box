import 'package:dot_and_box/agent/agent.dart';
import 'package:dot_and_box/game/game_model.dart';
import 'package:dot_and_box/game/history/history_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gameProvider = ChangeNotifierProvider((ref) => GameViewModel());

class GameViewModel extends ChangeNotifier {
  final GameModel model;

  GameViewModel._(this.model);

  factory GameViewModel() => GameViewModel._(GameModel.init);

  /// return [true] if some tile filled or catch exception
  bool drawLine(Agent agent, (int, int) p1, (int, int) p2) {
    try {
      int step = model.numStep;
      bool updated = model.board.draw(agent, p1, p2);
      model.addHistory(step, agent, p1, p2);
      lastSelected = step;
      notifyListeners();
      return updated;
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
      return true;
    }
  }

  void drawAndToggle(Agent agent, (int, int) p1, (int, int) p2) {
    bool toToggle = !drawLine(agent, p1, p2);
    if (toToggle) {
      int idx = model.players.indexOf(agent);
      int num = model.players.length;
      var nextAgent = model.players[(idx + 1) % num];
      model.currentPlayer = nextAgent;
      notifyListeners();
    }
  }

  void loadHistory(int historyIdx) {
    model.load(historyIdx);
    notifyListeners();
  }
}
