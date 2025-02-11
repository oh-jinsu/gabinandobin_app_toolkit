import 'package:gabinandobin_app_toolkit/controller.dart';
import 'package:gabinandobin_app_toolkit/event.dart';

abstract class GOBootstrapper extends GOController {
  @override
  void onListen(event) {
    if (event is GOAppReadyEvent) {
      bootstrap();
    }

    super.onListen(event);
  }

  void bootstrap();
}
