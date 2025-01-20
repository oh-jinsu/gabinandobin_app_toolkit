import 'package:flutter/material.dart';
import 'package:gabinandobin_app_toolkit/channel.dart';
import 'package:gabinandobin_app_toolkit/event.dart';
import 'package:gabinandobin_app_toolkit/initializer.dart';
import 'package:gabinandobin_app_toolkit/login_strategy/abstract.dart';
import 'package:gabinandobin_app_toolkit/provider.dart';

class GODefaultInitializer implements GOSubscriber {
  final Widget home;

  const GODefaultInitializer({required this.home});

  @override
  void onListen(dynamic event) {
    if (event is GOAppReadyEvent || event is GOInitializeRequestEvent) {
      GO.navigator.removeTo(const GOSplashPage(), immediate: true);

      GO.dispatch(const GOInitialLoginRequestedEvent());
    }

    if (event is GOInitialLoginFinishEvent) {
      GO.navigator.removeTo(home, immediate: true);
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
