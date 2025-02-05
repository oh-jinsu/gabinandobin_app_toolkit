import 'package:flutter/material.dart';
import 'package:gabinandobin_app_toolkit/gabinandobin_app_toolkit.dart';

class GODefaultInitializer extends GOInitializer {
  final Widget home;

  GODefaultInitializer({required this.home});

  @override
  void finish() {
    GO.navigator.removeTo(home, immediate: true);
  }
}
