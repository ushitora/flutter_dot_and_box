import 'package:dot_and_box/agent/agent.dart';

class StateModel {
  final int idx;
  final Agent player;
  final List<int> scores;
  final (int, int) p1;
  final (int, int) p2;

  const StateModel(this.idx, this.player, this.scores, this.p1, this.p2);
}
