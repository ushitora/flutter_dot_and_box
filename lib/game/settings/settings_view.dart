import 'dart:math';

import 'package:dot_and_box/game/settings/settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsView extends ConsumerWidget {
  static const titleStyle = TextStyle(fontSize: 25, color: Colors.black54);
  static const divider = Divider(thickness: 2, color: Colors.black12);

  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lineWidth = ref.watch(settingsProvider).lineWidth;
    final tileOpacity = ref.watch(settingsProvider).tileOpacity;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Text("Line Width", style: titleStyle),
          SizedBox(
            height: 60,
            child: Slider(
                min: 10,
                max: 100,
                divisions: 9,
                value: lineWidth,
                label: lineWidth.round().toString(),
                onChanged: (value) {
                  ref
                      .read(settingsProvider)
                      .setLineWidth(value.roundToDouble());
                }),
          ),
          divider,
          const SizedBox(height: 10),
          const Text("Tile Opacity", style: titleStyle),
          SizedBox(
            height: 60,
            child: Slider(
                min: 0,
                max: 1,
                divisions: 10,
                value: tileOpacity,
                label: tileOpacity.toString(),
                onChanged: (value) {
                  ref.read(settingsProvider).setTileOpacity(value);
                }),
          ),
        ],
      ),
    );
  }
}
