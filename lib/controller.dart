import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gabinandobin_app_toolkit/provider.dart';
import 'package:provider/provider.dart';

abstract class GOController extends ChangeNotifier {
  void init() {}

  void onListen(dynamic event) {}
}

class GOControllerProvider<T extends GOController> extends StatefulWidget {
  final T controller;

  final Widget? child;

  const GOControllerProvider({super.key, required this.controller, this.child});

  @override
  State<GOControllerProvider<T>> createState() => _GOControllerProviderState<T>();
}

class _GOControllerProviderState<T extends GOController> extends State<GOControllerProvider<T>> {
  StreamSubscription? subscription;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.init();
    });

    super.initState();

    subscription = GO.channel.stream.listen(onData);
  }

  void onData(dynamic event) {
    widget.controller.onListen(event);
  }

  @override
  void dispose() {
    subscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (c) => widget.controller,
      child: widget.child,
    );
  }
}
