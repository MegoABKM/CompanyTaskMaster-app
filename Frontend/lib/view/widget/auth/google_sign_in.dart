import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/auth/login_controller.dart';
import 'package:tasknotate/core/constant/imageasset.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';

class GoogleSignIn extends GetView<LoginControllerImp> {
  const GoogleSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: context.appTheme.colorScheme.secondary,
        foregroundColor: context.appTheme.colorScheme.onSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.scaleConfig.scale(12)),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: context.scaleConfig.scale(16),
          vertical: context.scaleConfig.scale(14),
        ),
        minimumSize: Size(double.infinity, context.scaleConfig.scale(50)),
      ),
      onPressed: () => controller.signInWithGoogle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        textDirection: Get.locale?.languageCode == "ar"
            ? TextDirection.rtl
            : TextDirection.ltr,
        children: [
          Image.asset(
            AppImageAsset.google,
            height: context.scaleConfig.scale(24),
            width: context.scaleConfig.scale(24),
          ),
          SizedBox(width: context.scaleConfig.scale(12)),
          Expanded(
            child: Text(
              "69".tr,
              style: context.appTheme.textTheme.labelLarge?.copyWith(
                color: context.appTheme.colorScheme.onSecondary,
                fontSize: context.scaleConfig.scaleText(18),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
