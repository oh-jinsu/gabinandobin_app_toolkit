import 'package:flutter/material.dart';
import 'package:gabinandobin_app_toolkit/api.dart';
import 'package:gabinandobin_app_toolkit/auth_api.dart';
import 'package:gabinandobin_app_toolkit/bootstrapper.dart';
import 'package:gabinandobin_app_toolkit/channel.dart';
import 'package:gabinandobin_app_toolkit/dialog.dart';
import 'package:gabinandobin_app_toolkit/initializer.dart';
import 'package:gabinandobin_app_toolkit/navigator.dart';
import 'package:gabinandobin_app_toolkit/storage.dart';
import 'package:gabinandobin_app_toolkit/theme.dart';
import 'package:provider/single_child_widget.dart';

class GOConfig {
  final bool debugMode;

  final Widget? home;

  final GOBootstrapper? bootstrapper;

  final GOInitializer? initializer;

  final GONavigator navigator;

  final GOSecureStorage secureStorage;

  final GOAPI? api;

  final GOAuthAPI? authAPI;

  final GOChannel channel;

  final GOTheme theme;

  final String? cdnOrigin;

  final List<SingleChildWidget> providers;

  final GODialog dialog;

  const GOConfig({
    required this.debugMode,
    required this.home,
    required this.bootstrapper,
    required this.initializer,
    required this.navigator,
    required this.secureStorage,
    required this.api,
    required this.authAPI,
    required this.channel,
    required this.theme,
    required this.cdnOrigin,
    required this.providers,
    required this.dialog,
  });
}
