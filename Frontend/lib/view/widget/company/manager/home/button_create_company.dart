import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/core/constant/routes.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';

class ButtonCreateCompany extends StatelessWidget {
  const ButtonCreateCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.symmetric(horizontal: context.scaleConfig.scale(95)),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.scaleConfig.scale(10))),
      onPressed: () => Get.toNamed(AppRoute.companycreate),
      color: context.appTheme.colorScheme.secondary,
      child: Text(
        "84".tr,
        textAlign: TextAlign.center,
        softWrap: false,
        style: context.appTheme.textTheme.bodyMedium!.copyWith(
          color: context.appTheme.colorScheme.onSecondary,
          fontSize: context.scaleConfig.scaleText(16),
        ),
      ),
    );
  }
}
