import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/view/screen/company/employee/tasks/workspace_employee.dart';

class WorkspaceNavigateCompany extends StatelessWidget {
  const WorkspaceNavigateCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.scaleConfig.scale(10))),
        color: context.appTheme.colorScheme.secondary,
        padding:
            EdgeInsets.symmetric(horizontal: context.scaleConfig.scale(100)),
        onPressed: () {
          Get.to(WorkspaceEmployee);
        },
        child: Text(
          "230".tr, // Go To Workspace
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: context.appTheme.colorScheme.onSecondary,
              fontSize: context.scaleConfig.scaleText(16)),
        ),
      ),
    );
  }
}
