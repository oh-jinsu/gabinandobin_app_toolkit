import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gabinandobin_app_toolkit/provider.dart';

abstract class GOChannel {
  Stream get stream;

  void dispatch(dynamic event);

  void dispose();
}

abstract class GOSubscriber {
  void onListen(dynamic event);
}

mixin ChannelMixin<T extends StatefulWidget> on State<T> {
  final List<StreamSubscription> _subscriptions = [];

  @protected
  @mustCallSuper
  void initState() {
    super.initState();

    _subscriptions.add(GO.channel.stream.listen(onListen));
  }

  @protected
  void onListen(dynamic event) {}

  @override
  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }

    super.dispose();
  }
}
