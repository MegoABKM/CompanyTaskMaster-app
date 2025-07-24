import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/crudcompany/createcompany_controller.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/view/widget/company/manager/company/shared/worker_count_company.dart';

class StepFinalize extends GetView<CreatecompanyController> {
  const StepFinalize({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = context.scaleConfig;
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: scale.scale(24)),
      children: [
        Text(
          "377".tr, // Company Size
          textAlign: TextAlign.center,
          style: context.textTheme.headlineSmall,
        ),
        SizedBox(height: scale.scale(8)),
        Text(
          "how_big_is_team".tr, // Add to translations
          style: context.textTheme.bodyLarge?.copyWith(
              color: context.theme.colorScheme.onSurface.withOpacity(0.6)),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: scale.scale(32)),

        // --- THE FIX IS HERE ---
        // Wrap the widget in a GetBuilder to listen for controller updates
        GetBuilder<CreatecompanyController>(builder: (controller) {
          return WorkerCountCompany(controller: controller);
        }),
      ],
    );
  }
}
