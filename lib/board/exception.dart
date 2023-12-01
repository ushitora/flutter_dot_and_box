import 'package:dot_and_box/board/board_model.dart';

class InvalidPointException implements Exception {
  final (int, int) point;
  final BoardModel board;
  const InvalidPointException(this.point, this.board);

  @override
  String toString() {
    return "InvalidPointException: $point is not a valid point in $board.";
  }
}

class InvalidLineException implements Exception {
  final (int, int) p1;
  final (int, int) p2;
  const InvalidLineException(this.p1, this.p2);
  @override
  String toString() {
    return "InvalidLineException: $p1 and $p2 are not next to each other.";
  }
}

class LineAlreadyDrawnException implements Exception {
  final (int, int) p1;
  final (int, int) p2;
  const LineAlreadyDrawnException(this.p1, this.p2);
  @override
  String toString() {
    // TODO: implement toString
    return "LineAlreadyDrawnException: line $p1 -- $p2 is already drawn.";
  }
}
