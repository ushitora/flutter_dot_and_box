import 'package:dot_and_box/agent/agent.dart';
import 'package:dot_and_box/board/board_model.dart';
import 'package:dot_and_box/game/game_model.dart';
import 'package:dot_and_box/utils/utils.dart';
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

  void setBoardSize({int? width, int? height}) {
    var board = BoardModel(
      width ?? model.board.W,
      height ?? model.board.H,
    );
    model = GameModel.from(model.players, board);
    notifyListeners();
  }

  void setPlayers(List<Agent> players) {
    var board = BoardModel(model.board.W, model.board.H);
    model = GameModel.from(players, board);
    notifyListeners();
  }

  void addPlayer(Agent player) {
    var players = [...model.players, player];
    setPlayers(players);
  }

  void addAnonymousPlayer() {
    int n = model.players.length;
    var newPlayer = Agent("Player${n + 1}", Agent.colors[n]);
    addPlayer(newPlayer);
  }

  void removeLastPlayer() {
    if (model.players.length > 1) {
      var players = [
        for (int i in range(model.players.length - 1)) model.players[i]
      ];
      setPlayers(players);
    }
  }
}
