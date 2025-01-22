import 'package:flutter/material.dart';
import 'package:gabinandobin_app_toolkit/auth_api.dart';
import 'package:gabinandobin_app_toolkit/controller.dart';
import 'package:gabinandobin_app_toolkit/initializer.dart';
import 'package:gabinandobin_app_toolkit/provider.dart';

class GOAutoInitialLoginer extends GOController {
  final Widget loginPage;

  bool isRunning = false;

  GOAutoInitialLoginer({
    required this.loginPage,
  });

  run() async {
    isRunning = true;

    try {
      final refreshToken = await GO.secureStorage.findRefreshToken();

      if (refreshToken == null) {
        throw Exception("REFRESH_TOKEN_NOT_FOUND");
      }

      final authApi = GO.require<GOAuthAPI>();

      final newAccessToken = await authApi.refresh(refreshToken);

      GO.secureStorage.saveAccessToken(newAccessToken);

      GO.dispatch(const GOInitialLoginFinishEvent());

      isRunning = false;
    } catch (e) {
      GO.log(e);

      GO.goTo(loginPage, immediate: true);
    }
  }

  @override
  void onListen(event) {
    if (event is GOInitializeStartEvent) {
      run();
    }

    if (isRunning && event is GOLoginFinishEvent) {
      run();
    }

    super.onListen(event);
  }
}
