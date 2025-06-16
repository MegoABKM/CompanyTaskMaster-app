import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/manager/tasks/createtask/createtask_controller.dart';
import 'package:tasknotate/core/constant/utils/scale_confige.dart'; // Added for scaleConfig

class SendNotificationSwitch extends GetView<CreatetaskController> {
  const SendNotificationSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final scaleConfig = ScaleConfig(context);
    return SwitchListTile(
      title: Text(
        "338".tr, // Notify All Company Employees
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: scaleConfig.scaleText(16),
            ),
      ),
      value: controller.sendNotification,
      activeColor: Theme.of(context).colorScheme.primary,
      onChanged: (value) => controller.updateSendNotification(value),
      contentPadding: EdgeInsets.symmetric(horizontal: scaleConfig.scale(0)),
    );
  }
}
