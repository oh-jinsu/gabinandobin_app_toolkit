import 'package:gabinandobin_app_toolkit/bootstrapper.dart';
import 'package:gabinandobin_app_toolkit/gabinandobin_app_toolkit.dart';

class GOInitializeStartEvent {
  const GOInitializeStartEvent();
}

class GOInitialLoginFinishEvent extends GOLoginFinishEvent {
  const GOInitialLoginFinishEvent();
}

abstract class GOInitializer extends GOController {
  Future<void> initialize();

  @override
  void onListen(dynamic event) {
    if (event is GOAppReadyEvent) {
      final bootstrapper = GO.requireOrNull<GOBootstrapper>();

      if (bootstrapper == null) {
        initialize();
      }
    }
  }
}
