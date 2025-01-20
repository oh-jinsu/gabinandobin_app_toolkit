import 'package:flutter/material.dart';
import 'package:gabinandobin_app_toolkit/auth_api.dart';
import 'package:gabinandobin_app_toolkit/channel.dart';
import 'package:gabinandobin_app_toolkit/initializer.dart';
import 'package:gabinandobin_app_toolkit/login_strategy/abstract.dart';
import 'package:gabinandobin_app_toolkit/provider.dart';

class GOAutoInitialLoginStrategy implements GOSubscriber {
  final Widget loginPage;

  const GOAutoInitialLoginStrategy({
    required this.loginPage,
  });

  @override
  void onListen(dynamic event) async {
    if (event is GOInitialLoginRequestedEvent) {
      try {
        final refreshToken = await GO.secureStorage.findRefreshToken();

        if (refreshToken == null) {
          throw Exception("REFRESH_TOKEN_NOT_FOUND");
        }

        final authApi = GO.require<GOAuthAPI>();

        final newAccessToken = await authApi.refresh(refreshToken);

        GO.secureStorage.saveAccessToken(newAccessToken);

        GO.dispatch(const GOInitialLoginFinishEvent());

        return;
      } catch (e) {
        GO.trace("Auto login failed: $e");

        await GO.navigator.goTo(loginPage, immediate: true);

        GO.dispatch(const GOInitialLoginRequestedEvent());

        return;
      }
    }
  }
}
