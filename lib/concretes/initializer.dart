import 'package:flutter/material.dart';
import 'package:gabinandobin_app_toolkit/gabinandobin_app_toolkit.dart';
import 'package:gabinandobin_app_toolkit/initializer.dart';
import 'package:gabinandobin_app_toolkit/login_strategy/abstract.dart';

class GODefaultInitializer implements GOSubscriber {
  final List<dynamic> startEvents;

  final Map<Type, bool> checklist;

  final Widget? home;

  final void Function()? onFinished;

  bool initialized = false;

  GODefaultInitializer({
    this.startEvents = const [GOAppReadyEvent, GOInitializeRequestEvent],
    required List<dynamic> finishEvents,
    this.home,
    this.onFinished,
  }) : checklist = Map.fromEntries(finishEvents.map((e) => MapEntry(e, false)));

  @override
  void onListen(dynamic event) {
    if (startEvents.contains(event.runtimeType)) {
      initialized = true;

      GO.trace("Initializing...");

      GO.navigator.removeTo(const GOSplashPage(), immediate: true);

      GO.dispatch(const GOInitialLoginRequestedEvent());
    }

    if (checklist.containsKey(event.runtimeType)) {
      checklist[event.runtimeType] = true;

      if (checklist.values.every((e) => e)) {
        GO.trace("Initialization finished.");

        initialized = true;

        if (onFinished != null) {
          onFinished!();
        }

        if (home != null) {
          GO.navigator.removeTo(home!, immediate: true);
        }
      }
    }
  }
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
