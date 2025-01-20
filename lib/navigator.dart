import 'package:flutter/material.dart';

abstract class GONavigator {
  Future<T?> goTo<T>(Widget widget, {bool? immediate});

  Future<T?> replaceTo<T, TO>(Widget widget, {bool? immediate});

  Future<T?> removeTo<T>(Widget widget, {bool? immediate});

  void pop<T>([T? result]);

  Route<T> route<T>(Widget widget, {bool? immediate});
}
