import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/tasks/viewtask_controller.dart';
import 'package:companymanagment/core/constant/utils/scale_confige.dart'; // Added for scaleConfig

class DescriptionSection extends GetView<ViewTaskCompanyManagerController> {
  final ThemeData theme;

  const DescriptionSection({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    final scaleConfig = ScaleConfig(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "276".tr, // Description
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: scaleConfig.scaleText(20),
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        SizedBox(height: scaleConfig.scale(8)),
        Container(
          padding: EdgeInsets.all(scaleConfig.scale(16)),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(scaleConfig.scale(12)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: scaleConfig.scale(6),
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Text(
            controller.taskcompanydetail.description ?? "318".tr, // N/A
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: scaleConfig.scaleText(16),
              color: theme.colorScheme.onSurface,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
