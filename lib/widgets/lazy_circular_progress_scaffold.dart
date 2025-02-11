import 'package:flutter/material.dart';
import 'package:gabinandobin_app_toolkit/widgets/lazy_circular_progress_bar.dart';

class LazyCircularProgressScaffold extends StatelessWidget {
  final Color? backgroundColor;

  final Duration duration;

  const LazyCircularProgressScaffold({
    super.key,
    this.backgroundColor,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: LazyCircularProgressBar(duration: duration),
    );
  }
}
