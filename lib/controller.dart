import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gabinandobin_app_toolkit/channel.dart';
import 'package:gabinandobin_app_toolkit/provider.dart';
import 'package:provider/provider.dart';

abstract class GOController extends ChangeNotifier implements GOSubscriber {
  late BuildContext context;

  final List<StreamSubscription> _subscriptions = [];

  @protected
  @mustCallSuper
  void init() {
    _subscriptions.add(GO.channel.stream.listen(onListen));
  }

  @protected
  @override
  void onListen(dynamic event) {}

  @override
  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }

    super.dispose();
  }
}

class GOControllerProvider<T extends GOController> extends ChangeNotifierProvider<T> {
  final T controller;

  final Widget? child;

  GOControllerProvider({
    super.key,
    required this.controller,
    this.child,
  }) : super(
          lazy: false,
          create: (context) {
            controller.context = context;

            WidgetsBinding.instance.addPostFrameCallback((_) {
              GO.log("Creating controller...$T");
              controller.init();
            });

            return controller;
          },
          child: child,
        );
}
