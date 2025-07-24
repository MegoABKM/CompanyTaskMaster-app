// lib/view/widget/company/manager/createtask/taskdatepicker.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/constant/utils/scale_confige.dart';

class TaskDatePicker extends StatelessWidget {
  final String label;
  final String hint;
  final Function(String) onDateSelected;

  const TaskDatePicker({
    super.key,
    required this.label,
    required this.hint,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final scaleConfig = ScaleConfig(context);
    final TextEditingController dateController = TextEditingController();

    Future<void> _pickDate() async {
      final DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2101),
      );

      if (selectedDate != null) {
        dateController.text =
            "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
        onDateSelected(dateController.text);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: scaleConfig.scaleText(16),
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: scaleConfig.scale(8)),
        TextField(
          controller: dateController,
          readOnly: true,
          onTap: _pickDate,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(scaleConfig.scale(8)),
            ),
            suffixIcon: Icon(Icons.calendar_today, size: scaleConfig.scale(20)),
          ),
        ),
      ],
    );
  }
}
