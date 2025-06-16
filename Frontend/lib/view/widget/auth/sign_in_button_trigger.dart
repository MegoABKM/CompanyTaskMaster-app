import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/auth/login_controller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';

class SignInButtonTrigger extends GetView<LoginControllerImp> {
  const SignInButtonTrigger({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: context.appTheme.colorScheme.primary,
        foregroundColor: context.appTheme.colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.scaleConfig.scale(12)),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: context.scaleConfig.scale(16),
          vertical: context.scaleConfig.scale(14),
        ),
        minimumSize: Size(double.infinity, context.scaleConfig.scale(50)),
      ),
      onPressed: () => controller.switcher("email"),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        textDirection: Get.locale?.languageCode == "ar"
            ? TextDirection.rtl
            : TextDirection.ltr,
        children: [
          Icon(
            Icons.email,
            size: context.scaleConfig.scale(24),
            color: context.appTheme.colorScheme.onPrimary,
          ),
          SizedBox(width: context.scaleConfig.scale(12)),
          Expanded(
            child: Text(
              "68".tr,
              style: context.textTheme.labelLarge?.copyWith(
                color: context.appTheme.colorScheme.onPrimary,
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
