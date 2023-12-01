import 'package:dot_and_box/agent/agent.dart';
import 'package:dot_and_box/board/exception.dart';
import 'package:dot_and_box/utils/utils.dart';

class BoardModel {
  final int W;
  final int H;

  final Map<(int, int), Agent> tiles;
  final Map<((int, int), (int, int)), Agent> lines;

  BoardModel._(this.W, this.H, this.lines, this.tiles);

  factory BoardModel(int W, int H) {
    return BoardModel._(W, H, {}, {});
  }

  bool _isValidPoint((int, int) p) {
    final (i, j) = p;
    return 0 <= i && i <= H && 0 <= j && j <= W;
  }

  bool _nextToEachOther((int, int) p1, (int, int) p2) {
    var (i1, j1) = p1;
    var (i2, j2) = p2;
    return (i1 == i2 && (j1 - j2).abs() == 1) ||
        ((i1 - i2).abs() == 1 && j1 == j2);
  }

  bool _circled((int, int) tile) {
    var (i, j) = tile;
    return lines[((i, j), (i, j + 1))] != null &&
        lines[((i, j), (i + 1, j))] != null &&
        lines[((i, j + 1), (i + 1, j + 1))] != null &&
        lines[((i + 1, j), (i + 1, j + 1))] != null;
  }

  bool _fillInBlankTile(Agent agent) {
    bool updated = false;
    for (int i in range(H)) {
      for (int j in range(W)) {
        if (_circled((i, j)) && tiles[(i, j)] == null) {
          tiles[(i, j)] = agent;
          updated = true;
        }
      }
    }
    return updated;
  }

  bool draw(Agent agent, (int, int) p1, (int, int) p2) {
    if (!_isValidPoint(p1)) throw InvalidPointException(p1, this);
    if (!_isValidPoint(p2)) throw InvalidPointException(p2, this);
    if (!_nextToEachOther(p1, p2)) throw InvalidLineException(p1, p2);
    if (lines[(p1, p2)] != null) throw LineAlreadyDrawnException(p1, p2);
    lines[(p1, p2)] = agent;
    bool updated = _fillInBlankTile(agent);
    return updated;
  }

  int score(Agent agent) {
    int cnt = 0;
    for (int i in range(H)) {
      for (int j in range(W)) {
        if (tiles[(i, j)] == agent) {
          cnt += 1;
        }
      }
    }
    return cnt;
  }

  bool allFilled() {
    for (int i in range(H)) {
      for (int j in range(W)) {
        if (tiles[(i, j)] == null) {
          return false;
        }
      }
    }
    return true;
  }

  BoardModel clone() {
    return BoardModel._(W, H, {...lines}, {...tiles});
  }
}
