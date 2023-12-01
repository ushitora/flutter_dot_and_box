import 'package:dot_and_box/game/game_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dot-And-Box")),
      body: const GameView(),
    );
  }
}
