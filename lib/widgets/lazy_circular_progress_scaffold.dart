import 'package:flutter/material.dart';
import 'package:gabinandobin_app_toolkit/widgets/lazy_circular_progress_bar.dart';

class LazyCircularProgressScaffold extends StatelessWidget {
  final Color? backgroundColor;

  final PreferredSizeWidget? appBar;

  final Widget? bottomNavigationBar;

  final Duration duration;

  const LazyCircularProgressScaffold({
    super.key,
    this.appBar,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor,
      bottomNavigationBar: bottomNavigationBar,
      body: LazyCircularProgressBar(duration: duration),
    );
  }
}
