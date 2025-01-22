import 'package:flutter/material.dart';

abstract class GODialog {
  Future<void> alert({
    required String title,
    required String message,
  });

  Future<bool> confirm({
    String title = "확인",
    required String message,
    Color? okColor,
  });

  Future<String?> prompt({
    required String title,
    String? label,
    String? initialValue,
    String? hintText,
  });
}
