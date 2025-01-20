import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gabinandobin_app_toolkit/api.dart';
import 'package:gabinandobin_app_toolkit/channel.dart';
import 'package:gabinandobin_app_toolkit/navigator.dart';
import 'package:gabinandobin_app_toolkit/storage.dart';
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

  static bool debugMode = false;

  static GOChannel get channel => require<GOChannel>();

  static GOAPI get api => require<GOAPI>();

  static GONavigator get navigator => require<GONavigator>();

  static GOSecureStorage get secureStorage => require<GOSecureStorage>();

  static dispatch(dynamic event) {
    channel.dispatch(event);
  }

  static trace(Object? object) {
    if (kDebugMode) {
      print(object);
    }
  }

  static Future<void> alert({required String title, required String message}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("확인"),
            ),
          ],
        );
      },
    );
  }

  static Future<bool> confirm({String title = "확인", required String message}) async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("취소"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("확인"),
            ),
          ],
        );
      },
    );

    return result == true;
  }
}
