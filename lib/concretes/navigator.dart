import 'package:flutter/material.dart';
import 'package:gabinandobin_app_toolkit/navigator.dart';
import 'package:gabinandobin_app_toolkit/provider.dart';

class GODefaultNavigator implements GONavigator {
  static NavigatorState get state => GO.navigatorKey.currentState!;

  GODefaultNavigator._();

  static final GODefaultNavigator _instance = GODefaultNavigator._();

  factory GODefaultNavigator() => _instance;

  @override
  Future<T?> goTo<T>(Widget widget, {bool? immediate}) {
    return state.push<T>(route(widget, immediate: immediate));
  }

  @override
  Future<T?> replaceTo<T, TO>(Widget widget, {bool? immediate}) {
    return state.pushReplacement<T, TO>(route(widget, immediate: immediate));
  }

  @override
  Future<T?> removeTo<T>(Widget widget, {bool? immediate}) {
    return state.pushAndRemoveUntil<T>(route(widget, immediate: immediate), (route) => false);
  }

  @override
  void pop<T>([T? result]) {
    return state.pop(result);
  }

  @override
  Route<T> route<T>(Widget widget, {bool? immediate}) {
    if (immediate == true) {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    }

    return MaterialPageRoute(
      builder: (context) => widget,
    );
  }
}
