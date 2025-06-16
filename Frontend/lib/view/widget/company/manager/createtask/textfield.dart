import 'package:flutter/material.dart';

class TaskTextField extends StatelessWidget {
  final String label;
  final String hint;
  final int maxLines;
  final Function(String) onChanged;

  TaskTextField({
    required this.label,
    required this.hint,
    this.maxLines = 1,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          maxLines: maxLines,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
