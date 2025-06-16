// lib/view/screen/auth/login.dart (continued)
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/core/functions/validinput.dart';
import 'package:tasknotate/view/widget/auth/shared/custom_button_auth.dart';
import 'package:tasknotate/view/widget/auth/shared/custom_text_form_auth.dart';
import 'package:tasknotate/view/widget/auth/text_sign_up.dart';

import '../../../controller/auth/login_controller.dart';

class SignInEmailPassword extends GetView<LoginControllerImp> {
  const SignInEmailPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formstate,
      child: Column(
        children: [
          SizedBox(height: context.scaleConfig.scale(15)),
          Customtextformauth(
            isNumber: false,
            validator: (val) => validInput(val!, 5, 100, 'email'),
            mycontroller: controller.email,
            texthint: "13".tr,
            label: "14".tr,
            iconData: Icons.email_outlined,
          ),
          GetBuilder<LoginControllerImp>(
            builder: (controller) => Customtextformauth(
              onTapIcon: () => controller.changeObsecure(),
              obscureText: controller.valuebool,
              isNumber: false,
              validator: (val) => validInput(val!, 5, 30, "password"),
              mycontroller: controller.password,
              texthint: "15".tr,
              label: "16".tr,
              iconData: Icons.lock_outlined,
            ),
          ),
          Container(
            alignment: Get.locale?.languageCode == "ar"
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: InkWell(
              onTap: controller.goToForgetPassword,
              child: Text(
                "17".tr,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.appTheme.colorScheme.primary,
                  fontSize: context.scaleConfig.scaleText(14),
                ),
              ),
            ),
          ),
          CustomButtonAuth(
            textbutton: "18".tr,
            onPressed: () {
              controller.login();
            },
          ),
          SizedBox(height: context.scaleConfig.scale(30)),
          CustomTextSignupOrSignin(
            text: "19".tr,
            textbutton: "20".tr,
            onTap: controller.goToSignup,
          ),
          SizedBox(height: context.scaleConfig.scale(10)),
        ],
      ),
    );
  }
}
