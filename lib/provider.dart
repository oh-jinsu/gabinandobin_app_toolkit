import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gabinandobin_app_toolkit/api.dart';
import 'package:gabinandobin_app_toolkit/channel.dart';
import 'package:gabinandobin_app_toolkit/config.dart';
import 'package:gabinandobin_app_toolkit/dialog.dart';
import 'package:gabinandobin_app_toolkit/navigator.dart';
import 'package:gabinandobin_app_toolkit/storage.dart';
import 'package:gabinandobin_app_toolkit/theme.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

class GO {
  static const GO _instance = GO._();

  const GO._();

  factory GO() => _instance;

  static BuildContext get context => navigatorKey.currentContext!;

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static T of<T>(BuildContext context) {
    return Provider.of<T>(context, listen: false);
  }

  static T require<T>() {
    return of<T>(context);
  }

  static T? requireOrNull<T>() {
    return of<T?>(context);
  }

  static GOConfig get config => require<GOConfig>();

  static bool get debugMode => config.debugMode;

  static GOThemeController get theme => require<GOThemeController>();

  static GODialog get dialog => config.dialog;

  static GOChannel get channel => config.channel;

  static GONavigator get navigator => config.navigator;

  static GOSecureStorage get secureStorage => config.secureStorage;

  static GOAPI get api => require<GOAPI>();

  static Future<PackageInfo> getInfo() => PackageInfo.fromPlatform();

  static Future<T?> goTo<T>(Widget page, {bool? immediate}) {
    return navigator.goTo<T>(page, immediate: immediate);
  }

  static Future<T?> replaceTo<T, TO>(Widget page, {bool? immediate}) {
    return navigator.replaceTo<T, TO>(page, immediate: immediate);
  }

  static Future<T?> removeTo<T>(Widget page, {bool? immediate}) {
    return navigator.removeTo<T>(page, immediate: immediate);
  }

  static void pop<T>([T? result]) {
    return navigator.pop<T>(result);
  }

  static dispatch(dynamic event) {
    channel.dispatch(event);
  }

  static log(Object? object) {
    final timestamp = DateTime.now().toIso8601String().split("T").last;

    if (kDebugMode) {
      developer.log("[$timestamp] $object");
    }
  }
}
