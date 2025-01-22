import 'package:flutter/material.dart';
import 'package:gabinandobin_app_toolkit/dialog.dart';
import 'package:gabinandobin_app_toolkit/provider.dart';
import 'package:gabinandobin_app_toolkit/widgets/label.dart';
import 'package:gabinandobin_app_toolkit/widgets/textfield.dart';

class GODefaultDialog implements GODialog {
  @override
  Future<void> alert({required String title, required String message}) async {
    await showDialog(
      context: GO.context,
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

  @override
  Future<bool> confirm({String title = "확인", required String message, Color? okColor}) async {
    final result = await showDialog(
      context: GO.context,
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
              child: Text(
                "확인",
                style: TextStyle(color: okColor),
              ),
            ),
          ],
        );
      },
    );

    return result == true;
  }

  @override
  Future<String?> prompt({
    required String title,
    String? label,
    String? initialValue,
    String? hintText,
  }) {
    return showDialog<String>(
      context: GO.context,
      builder: (context) {
        String result = initialValue ?? '';

        return AlertDialog(
          title: Text(title),
          content: Wrap(
            children: [
              if (label != null) GOLabel(label),
              GOTextField(
                bottomPadding: 0.0,
                hintText: hintText,
                onChanged: (value) {
                  result = value;
                },
                initialValue: initialValue,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context, result);
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }
}
