Iterable<int> range(int startOrStop, [int? stop]) sync* {
  int l = stop == null ? 0 : startOrStop;
  int r = stop == null ? startOrStop : stop;
  for (int i = l; i < r; i++) {
    yield i;
  }
}
