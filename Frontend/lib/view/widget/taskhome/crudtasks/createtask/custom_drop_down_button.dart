import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/tasks/taskcreate_controller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';

class CustomDropDownButton extends GetView<TaskcreateController> {
  final String? value;
  final List<String> items;
  final Function(String?)? onChanged;
  final String type; // "priority", "status", or "category"

  const CustomDropDownButton(
    this.value,
    this.items, {
    super.key,
    this.onChanged,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,
      items: items.map((String item) {
        String displayText;
        if (type == "priority") {
          displayText = controller.priorityTranslations[item]?.tr ?? item;
        } else if (type == "status") {
          displayText = controller.statusTranslations[item]?.tr ?? item;
        } else {
          // For categories, use item directly ("None" or category name)
          displayText = item.tr; // Use .tr in case "None" is translated
        }
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            displayText,
            style: context.appTheme.textTheme.bodyLarge?.copyWith(
              fontSize: context.scaleConfig.scaleText(16),
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      underline: Container(),
      isExpanded: true,
      style: context.appTheme.textTheme.bodyLarge?.copyWith(
        fontSize: context.scaleConfig.scaleText(16),
      ),
      hint: Text(
        "Select Category".tr,
        style: context.appTheme.textTheme.bodyLarge?.copyWith(
          fontSize: context.scaleConfig.scaleText(16),
          color: context.appTheme.colorScheme.onSurface.withOpacity(0.6),
        ),
      ),
    );
  }
}
