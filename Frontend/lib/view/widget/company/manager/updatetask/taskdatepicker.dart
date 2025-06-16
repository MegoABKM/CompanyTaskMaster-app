import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/manager/tasks/updatetask/updatetask_controller.dart';
import 'package:tasknotate/core/constant/utils/scale_confige.dart'; // Added for scaleConfig

class TaskDatePickerUpdate extends GetView<UpdatetaskCompanyController> {
  const TaskDatePickerUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    final scaleConfig = ScaleConfig(context);
    final TextEditingController dateController =
        TextEditingController(text: controller.dueDate);

    Future<void> pickDate() async {
      final DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: controller.dueDate.isNotEmpty
            ? DateTime.tryParse(controller.dueDate) ?? DateTime.now()
            : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );

      if (selectedDate != null) {
        dateController.text =
            "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
        controller.updateDueDate(dateController.text);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "286".tr, // Estimated Completion Date
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: scaleConfig.scaleText(16),
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: scaleConfig.scale(8)),
        TextField(
          controller: dateController,
          readOnly: true,
          onTap: pickDate,
          decoration: InputDecoration(
            hintText: "319".tr, // Select a date
            hintStyle: TextStyle(
              fontSize: scaleConfig.scaleText(14),
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(scaleConfig.scale(8)),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: scaleConfig.scale(12),
              vertical: scaleConfig.scale(10),
            ),
            suffixIcon: Icon(
              Icons.calendar_today,
              size: scaleConfig.scale(20),
              color: Theme.of(context).colorScheme.primary,
            ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          style: TextStyle(fontSize: scaleConfig.scaleText(16)),
        ),
      ],
    );
  }
}
