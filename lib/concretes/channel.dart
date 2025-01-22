import 'dart:async';

import 'package:gabinandobin_app_toolkit/channel.dart';
import 'package:gabinandobin_app_toolkit/provider.dart';

class GODefaultChannel implements GOChannel {
  final _controller = StreamController.broadcast();

  @override
  Stream get stream => _controller.stream;

  @override
  void dispatch(dynamic event) {
    GO.log("Dispatch ${event.runtimeType}");

    _controller.add(event);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
