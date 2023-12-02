import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsProvider = ChangeNotifierProvider((ref) => SettingsViewModel());

class SettingsViewModel extends ChangeNotifier {
  double lineWidth = 20;
  double tileSize = 100;
  double tileOpacity = .6;

  SettingsViewModel();

  void setLineWidth(double lineWidth) {
    this.lineWidth = lineWidth;
    notifyListeners();
  }

  void setTileOpacity(double tileOpacity) {
    this.tileOpacity = tileOpacity;
    notifyListeners();
  }
}
