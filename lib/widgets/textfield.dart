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

  const GOTextField({
    super.key,
    this.controller,
    this.initialValue,
    this.keyboardType,
    this.readOnly = false,
    this.onChanged,
    this.minLines,
    this.maxLines,
    this.obscureText = false,
    this.hintText,
    this.bottomPadding = 16.0,
    this.focusNode,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: TextFormField(
        inputFormatters: inputFormatters,
        focusNode: focusNode,
        controller: controller,
        style: TextStyle(
          fontSize: GO.theme.fontSize,
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
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(4.0),
          ),
          filled: true,
          fillColor: Colors.grey[50],
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(4.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        cursorColor: GO.theme.primaryColor,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }
}
