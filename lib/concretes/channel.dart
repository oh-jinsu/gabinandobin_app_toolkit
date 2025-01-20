import 'dart:async';

import 'package:gabinandobin_app_toolkit/channel.dart';

class GODefaultChannel implements GOChannel {
  final _controller = StreamController.broadcast();

  @override
  Stream get stream => _controller.stream;

  @override
  void dispatch(dynamic event) {
    _controller.add(event);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
