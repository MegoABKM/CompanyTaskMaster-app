import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/onboarding_controller.dart';
import 'package:tasknotate/core/constant/utils/scale_confige.dart';
import 'package:tasknotate/core/localization/changelocal.dart';

class CustombuttonOnBoarding extends GetView<OnBoardingControllerImp> {
  const CustombuttonOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    final scaleConfig = ScaleConfig(context);
    final theme = Theme.of(context);
    final localController = Get.find<LocalController>();

    return Container(
      margin: EdgeInsets.only(
        bottom: scaleConfig.scale(20),
        top: scaleConfig.scale(10),
      ),
      height: scaleConfig.scale(50),
      width: Get.width * 0.5,
      child: Directionality(
        textDirection: localController.language.languageCode == 'ar'
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: MaterialButton(
          padding: EdgeInsets.symmetric(
            horizontal: scaleConfig.scale(20),
            vertical: scaleConfig.scale(10),
          ),
          textColor: theme.colorScheme.onPrimary,
          onPressed: () {
            controller.next();
          },
          color: theme.colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(scaleConfig.scale(12)),
          ),
          child: Text(
            "continue".tr,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onPrimary,
              fontSize: scaleConfig.scaleText(18),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
