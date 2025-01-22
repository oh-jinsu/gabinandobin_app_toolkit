import 'package:flutter/material.dart';

class GOLabel extends StatelessWidget {
  final String text;

  final bool isRequired;

  const GOLabel(this.text, {super.key, this.isRequired = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (isRequired)
            const Text(
              '*',
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
