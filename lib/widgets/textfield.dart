import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gabinandobin_app_toolkit/gabinandobin_app_toolkit.dart';

class GOTextField extends StatelessWidget {
  final TextEditingController? controller;

  final TextInputType? keyboardType;

  final String? initialValue;

  final bool readOnly;

  final void Function(String)? onChanged;

  final int? minLines;

  final int? maxLines;

  final bool obscureText;

  final String? hintText;

  final double bottomPadding;

  final FocusNode? focusNode;

  final void Function(String)? onFieldSubmitted;

  final List<TextInputFormatter>? inputFormatters;

  final EdgeInsets? contentPadding;

  final InputBorder? border;

  final BorderRadius? borderRadius;

  final Color? backgroundColor;

  final double? fontSize;

  const GOTextField({
    super.key,
    this.controller,
    this.initialValue,
    this.keyboardType,
    this.readOnly = false,
    this.onChanged,
    this.minLines,
    this.maxLines = 1,
    this.obscureText = false,
    this.hintText,
    this.bottomPadding = 16.0,
    this.focusNode,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.contentPadding,
    this.border,
    this.backgroundColor,
    this.borderRadius,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final border = this.border ??
        OutlineInputBorder(
          borderSide: BorderSide(color: GO.theme.dividerColor),
          borderRadius: this.borderRadius ?? BorderRadius.circular(4.0),
        );

    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: TextFormField(
        inputFormatters: inputFormatters,
        focusNode: focusNode,
        controller: controller,
        style: TextStyle(
          fontSize: fontSize ?? GO.theme.fontSize,
        ),
        scrollPadding: const EdgeInsets.symmetric(vertical: 0.0),
        keyboardType: keyboardType,
        initialValue: initialValue,
        readOnly: readOnly,
        minLines: minLines,
        maxLines: maxLines,
        obscureText: obscureText,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          border: border,
          filled: true,
          fillColor: backgroundColor ?? Colors.grey[50],
          enabledBorder: border,
          focusedBorder: border,
        ),
        cursorColor: GO.theme.primaryColor,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }
}
