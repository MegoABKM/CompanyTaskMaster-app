import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/auth/verifyforgetpassword_controller.dart';
import 'package:tasknotate/core/class/handlingdataview.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/view/widget/auth/shared/custom_text_body_auth.dart';
import 'package:tasknotate/view/widget/auth/shared/custom_text_title_auth.dart';

class VerifyCodePassword extends StatelessWidget {
  const VerifyCodePassword({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VerifyPasswordControllerImp());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.appTheme.scaffoldBackgroundColor,
        elevation: 0.0,
        title: Text(
          "41".tr,
          style: context.appTheme.textTheme.headlineLarge!.copyWith(
            color: context.appTheme.colorScheme.onSurface.withOpacity(0.7),
            fontSize: context.scaleConfig.scaleText(24),
          ),
        ),
      ),
      body: GetBuilder<VerifyPasswordControllerImp>(
        builder: (controller) => Handlingdataview(
          statusRequest: controller.statusRequest,
          widget: Center(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.scaleConfig.scale(40),
                vertical: context.scaleConfig.scale(40),
              ),
              child: ListView(
                children: [
                  SizedBox(height: context.scaleConfig.scale(20)),
                  CustomTextTitleAuth(text: "42".tr),
                  SizedBox(height: context.scaleConfig.scale(10)),
                  CustomTextBodyAuth(bodyText: "43".tr),
                  SizedBox(height: context.scaleConfig.scale(15)),
                  OtpTextField(
                    borderRadius:
                        BorderRadius.circular(context.scaleConfig.scale(20)),
                    borderWidth: context.scaleConfig.scale(5),
                    fieldWidth: context.scaleConfig.scale(50),
                    numberOfFields: 5,
                    borderColor: context.appTheme.colorScheme.primary,
                    showFieldAsBox: true,
                    textStyle:
                        TextStyle(fontSize: context.scaleConfig.scaleText(16)),
                    onCodeChanged: (String code) {},
                    onSubmit: (String verificationCode) {
                      controller.verifycode = verificationCode;
                      controller.checkCode();
                    },
                  ),
                  Icon(
                    Icons.arrow_forward,
                    size: context.scaleConfig.scale(40),
                    color: context.appTheme.colorScheme.primary,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
