import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/tasks/taskcreate_controller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/view/widget/taskhome/crudtasks/createtask/custom_drop_down_button.dart';

class StatusOfTask extends StatelessWidget {
  const StatusOfTask({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskcreateController>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "275".tr,
            style: context.appTheme.textTheme.titleMedium?.copyWith(
              fontSize: context.scaleConfig.scaleText(16),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: context.scaleConfig.scale(8)),
          CustomDropDownButton(
            type: "status",
            controller.status!,
            controller.statuses,
            onChanged: (String? newValue) {
              if (newValue != null) {
                controller.status = newValue;
                controller.update();
              }
            },
          ),
        ],
      ),
    );
  }
}
