import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/tasks/taskcreate_controller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';

class PickDateAndTime extends GetView<TaskcreateController> {
  final String type;
  const PickDateAndTime(this.type, {super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.pickDateTime(context, type),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.scaleConfig.scale(10),
          vertical: context.scaleConfig.scale(15),
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: context.appTheme.colorScheme.primary,
            width: context.scaleConfig.scale(1),
          ),
          borderRadius: BorderRadius.circular(context.scaleConfig.scale(10)),
        ),
        child: GetBuilder<TaskcreateController>(
          builder: (controller) => Text(
            textAlign: TextAlign.center,
            controller.getFormattedDateTime(type),
            style: context.appTheme.textTheme.bodyMedium!.copyWith(
              color: context.appTheme.colorScheme.onSurface,
              fontSize: context.scaleConfig.scaleText(16),
            ),
          ),
        ),
      ),
    );
  }
}
