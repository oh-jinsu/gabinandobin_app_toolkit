import 'package:flutter/material.dart';
import 'package:gabinandobin_app_toolkit/gabinandobin_app_toolkit.dart';

class GOSubmitButton extends StatelessWidget {
  final bool safeArea;

  final void Function() onPressed;

  final bool enabled;

  final bool isPending;

  final Widget child;

  final Widget? pendingChild;

  final Widget? disabledChild;

  final Size? minimumSize;

  final Color? foregroundColor;

  final Color? backgroundColor;

  final Color? disabledBackgroundColor;

  final Color? progressColor;

  final bool outlined;

  const GOSubmitButton({
    super.key,
    this.safeArea = false,
    this.pendingChild,
    this.disabledChild,
    this.enabled = true,
    this.isPending = false,
    this.minimumSize,
    this.foregroundColor,
    this.backgroundColor,
    this.disabledBackgroundColor,
    this.progressColor,
    required this.onPressed,
    required this.child,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: safeArea,
      bottom: safeArea,
      left: safeArea,
      right: safeArea,
      child: ElevatedButton(
        onPressed: () async {
          if (!enabled || isPending) {
            return;
          }

          onPressed();
        },
        style: ElevatedButton.styleFrom(
          minimumSize: minimumSize ?? const Size(double.infinity, 48.0),
          backgroundColor: outlined
              ? Colors.white
              : enabled
                  ? backgroundColor
                  : disabledBackgroundColor ?? Colors.grey[400],
          shape: outlined
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                    color: enabled
                        ? foregroundColor ?? GO.theme.primaryColor
                        : disabledBackgroundColor ?? Colors.grey[400]!,
                  ),
                )
              : null,
          foregroundColor: outlined ? (foregroundColor ?? GO.theme.primaryColor) : Colors.white,
        ),
        child: isPending
            ? pendingChild ??
                SizedBox(
                  width: 18.0,
                  height: 18.0,
                  child: Center(
                    child: CircularProgressIndicator.adaptive(
                      strokeWidth: 3.0,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          progressColor ?? (outlined ? (foregroundColor ?? GO.theme.primaryColor) : Colors.white)),
                    ),
                  ),
                )
            : enabled
                ? child
                : disabledChild ?? child,
      ),
    );
  }
}
