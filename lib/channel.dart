import 'dart:async';

abstract class GOChannel {
  Stream get stream;

  void dispatch(dynamic event);

  void dispose();
}

abstract class GOSubscriber {
  void onListen(dynamic event);
}
