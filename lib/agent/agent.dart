import 'package:dot_and_box/utils/utils.dart';
import 'package:flutter/material.dart';

class Agent {
  static final colors = [
    for (int i in range(Colors.primaries.length))
      Colors.primaries[(i * 5) % Colors.primaries.length]
  ];
  final String name;
  final Color color;

  const Agent(this.name, this.color);
}
