import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: TextFormField(
        inputFormatters: inputFormatters,
        focusNode: focusNode,
        controller: controller,
        style: const TextStyle(
          fontSize: 16.0,
        ),
        scrollPadding: const EdgeInsets.symmetric(vertical: 0.0),
        keyboardType: keyboardType,
        initialValue: initialValue,
        readOnly: readOnly,
        minLines: minLines,
        maxLines: maxLines,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: Colors.grey[50],
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        cursorColor: Theme.of(context).colorScheme.primary,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }
}
