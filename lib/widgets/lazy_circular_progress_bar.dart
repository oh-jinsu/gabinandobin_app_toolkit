import 'package:flutter/material.dart';

class LazyCircularProgressBar extends StatefulWidget {
  final Duration duration;

  const LazyCircularProgressBar({super.key, this.duration = const Duration(milliseconds: 100)});

  @override
  State<LazyCircularProgressBar> createState() => _LazyCircularProgressBarState();
}

class _LazyCircularProgressBarState extends State<LazyCircularProgressBar> {
  bool _isLong = false;

  Future? future;

  @override
  void initState() {
    future = Future.delayed(widget.duration, () {
      setState(() {
        _isLong = true;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    future?.ignore();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLong) {
      return const SizedBox();
    }

    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
