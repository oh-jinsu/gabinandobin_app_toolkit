import 'package:gabinandobin_app_toolkit/bootstrapper.dart';

class GOInviteEvent {
  const GOInviteEvent();
}

class GOBootstrapFinished {
  const GOBootstrapFinished();
}

class GODefaultBootstrapper extends GOBootstrapper {
  GODefaultBootstrapper();

  @override
  void bootstrap() {
    finish();
  }
}
