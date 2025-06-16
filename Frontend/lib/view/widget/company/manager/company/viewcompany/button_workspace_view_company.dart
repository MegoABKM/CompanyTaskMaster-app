import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/manager/crudcompany/viewcompany_controller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';

class ButtonWorkspaceViewCompany extends GetView<ViewcompanyController> {
  const ButtonWorkspaceViewCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.scaleConfig.scale(10))),
        color: context.appTheme.colorScheme.secondary,
        padding: EdgeInsets.symmetric(
            horizontal: context.scaleConfig.scale(100),
            vertical: context.scaleConfig.scale(15)),
        onPressed: () => controller.goToWorkspace(),
        child: Text(
          "230".tr, // Go To Workspace
          style: context.appTheme.textTheme.bodyLarge!.copyWith(
              color: context.appTheme.colorScheme.onSecondary,
              fontSize: context.scaleConfig.scaleText(16)),
        ),
      )
    ]);
  }
}
