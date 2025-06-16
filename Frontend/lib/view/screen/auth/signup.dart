import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/auth/signup_controller.dart';
import 'package:tasknotate/core/class/handlingdataauthview.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/core/functions/alertexitapp.dart';
import 'package:tasknotate/view/widget/auth/shared/custom_text_body_auth.dart';
import 'package:tasknotate/view/widget/auth/shared/logo_auth.dart';
import 'package:tasknotate/view/widget/auth/shared/terms_and_condition.dart';
import 'package:tasknotate/view/widget/auth/text_form_fields_signup.dart';
import 'package:tasknotate/view/widget/auth/shared/text_span_title.dart';
import 'package:tasknotate/view/widget/auth/text_sign_up.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignupControllerImp());
    return Scaffold(
      // ignore: deprecated_member_use
      body: WillPopScope(
        onWillPop: alertExitApp,
        child: GetBuilder<SignupControllerImp>(
          builder: (controller) => HandlingDataAuthview(
            statusRequest: controller.statusRequest,
            widget: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    context.appTheme.colorScheme.primary.withOpacity(0.1),
                    context.appTheme.colorScheme.surface,
                  ],
                ),
              ),
              child: SafeArea(
                child: ListView(
                  padding: EdgeInsets.all(context.scaleConfig.scale(24)),
                  children: [
                    TextSpanTitle(),
                    SizedBox(height: context.scaleConfig.scale(30)),
                    LogoAuth(),
                    SizedBox(height: context.scaleConfig.scale(30)),
                    CustomTextBodyAuth(bodyText: "23".tr),
                    SizedBox(height: context.scaleConfig.scale(20)),
                    TextFormFieldsSignup(),
                    CustomTextSignupOrSignin(
                      text: "33".tr,
                      textbutton: "34".tr,
                      onTap: () => controller.goToLogin,
                    ),
                    Termsandcondition()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
