import 'package:flutter/material.dart';
import 'package:get/get.dart';
// FIX: Change the import to the new, correct controller
import 'package:companymanagment/controller/company/manager/tasks/updatetask/updatetask_controller.dart';
import 'package:companymanagment/core/constant/utils/scale_confige.dart';

// FIX: Change the GetView type to the correct controller
class TaskDatePickerUpdate extends GetView<UpdatetaskCompanyController> {
  const TaskDatePickerUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    final scaleConfig = ScaleConfig(context);

    // FIX: Use the controller's own TextEditingController
    final TextEditingController dateController = controller.dueDateController;

    Future<void> pickDate() async {
      final DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: controller.dueDateController.text.isNotEmpty
            ? DateTime.tryParse(controller.dueDateController.text) ??
                DateTime.now()
            : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );

      if (selectedDate != null) {
        String formattedDate =
            "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
        // Update the controller's TextEditingController, which will automatically update the UI
        dateController.text = formattedDate;
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
        TextFormField(
          // Use TextFormField to listen to controller changes
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
