import 'package:flutter/material.dart';

class GODropDown extends StatefulWidget {
  final String? initialValue;

  final List<String> values;

  final void Function(String?)? onChanged;

  const GODropDown({super.key, required this.values, this.initialValue, this.onChanged});

  @override
  State<GODropDown> createState() => _GODropDownState();
}

class _GODropDownState extends State<GODropDown> {
  late String? value = widget.initialValue ?? widget.values.first;

  @override
  Widget build(BuildContext context) {
    widget.onChanged?.call(value);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey[50],
        ),
        child: DropdownButtonFormField(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          value: value,
          elevation: 1,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          items: widget.values.map((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              this.value = value;
            });

            widget.onChanged?.call(value);
          },
          isExpanded: true,
        ),
      ),
    );
  }
}
