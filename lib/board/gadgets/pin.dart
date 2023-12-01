import 'package:flutter/material.dart';

class Pin extends StatelessWidget {
  static const color = Colors.orange;

  final double radius;
  const Pin(this.radius, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      decoration: const BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
