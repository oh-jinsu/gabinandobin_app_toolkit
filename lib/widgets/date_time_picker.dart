import 'package:flutter/material.dart';

class GODateTimePicker extends StatefulWidget {
  final DateTime? initialDate;

  final void Function(DateTime)? onChanged;

  const GODateTimePicker({super.key, this.onChanged, this.initialDate});

  @override
  State<GODateTimePicker> createState() => _GODateTimePickerState();
}

class _GODateTimePickerState extends State<GODateTimePicker> {
  late DateTime selectedDate = widget.initialDate ?? DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () {
          showDatePicker(
            locale: const Locale("ko", "KR"),
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          ).then((value) {
            if (value != null) {
              setState(() {
                selectedDate = value;

                widget.onChanged?.call(selectedDate);
              });
            }
          });
        },
        child: Ink(
          height: 48.0,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            border: Border.all(
              color: Colors.grey[300]!,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일",
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.calendar_today,
                size: 16.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
