import 'package:dot_and_box/agent/agent.dart';
import 'package:dot_and_box/game/game_model.dart';
import 'package:dot_and_box/game/history/history_view.dart';
import 'package:dot_and_box/game/history/state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gameProvider = ChangeNotifierProvider((ref) => GameViewModel());

class GameViewModel extends ChangeNotifier {
  GameModel model;

  GameViewModel._(this.model);

  factory GameViewModel() => GameViewModel._(GameModel.init);

  void drawAndToggle(Agent agent, (int, int) p1, (int, int) p2) {
    model.drawAndToggle(agent, p1, p2, changeHistory: true);
    notifyListeners();
  }

  void loadHistory(int stateIdx) {
    model = model.load(stateIdx);
    notifyListeners();
  }
}
