import 'package:flutter/material.dart';
import 'package:gabinandobin_app_toolkit/bootstrapper.dart';
import 'package:gabinandobin_app_toolkit/gabinandobin_app_toolkit.dart';

class GOInitializeStartEvent {
  const GOInitializeStartEvent();
}

class GOInitialLoginFinishEvent extends GOLoginFinishEvent {
  const GOInitialLoginFinishEvent();
}

abstract class GOInitializer extends GOController {
  bool initialized = false;

  late Map<Type, bool> checklist = Map.fromEntries(finishEvents.map((e) => MapEntry(e, false)));

  List<Type> get finishEvents => [GOInitialLoginFinishEvent];

  void initialize() {
    GO.log("Initializing...");

    if (checklist.isEmpty) {
      finish();

      return;
    }

    initialized = false;

    checklist = Map.fromEntries(finishEvents.map((e) => MapEntry(e, false)));

    GO.navigator.removeTo(const GOSplashPage(), immediate: true);

    GO.dispatch(const GOInitializeStartEvent());
  }

  @override
  void onListen(dynamic event) {
    if (event is GOAppReadyEvent) {
      final bootstrapper = GO.requireOrNull<GOBootstrapper>();

      if (bootstrapper == null) {
        initialize();
      }
    }

    if (initialized) {
      return;
    }

    if (checklist.containsKey(event.runtimeType)) {
      checklist[event.runtimeType] = true;

      GO.log("${event.runtimeType} checked.");

      if (checklist.values.every((e) => e)) {
        initialized = true;

        GO.log("Initialization finished.");

        finish();
      }
    }
  }

  void finish() {}
}

class GOSplashPage extends StatefulWidget {
  const GOSplashPage({super.key});

  @override
  State<GOSplashPage> createState() => _GOSplashPageState();
}

class _GOSplashPageState extends State<GOSplashPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
