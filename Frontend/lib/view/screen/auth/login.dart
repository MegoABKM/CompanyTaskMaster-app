import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/auth/login_controller.dart';
import 'package:tasknotate/core/class/handlingdataauthview.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/core/functions/alertexitapp.dart';
import 'package:tasknotate/view/widget/auth/shared/custom_text_body_auth.dart';
import 'package:tasknotate/view/widget/auth/google_sign_in.dart';
import 'package:tasknotate/view/widget/auth/shared/logo_auth.dart';
import 'package:tasknotate/view/widget/auth/sign_in_button_trigger.dart';
import 'package:tasknotate/view/widget/auth/sign_in_email_password.dart';
import 'package:tasknotate/view/widget/auth/shared/terms_and_condition.dart';
import 'package:tasknotate/view/widget/auth/shared/text_span_title.dart';

class Login extends StatelessWidget {
  const Login({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerImp());
    return Scaffold(
      // ignore: deprecated_member_use
      body: WillPopScope(
        onWillPop: alertExitApp,
        child: GetBuilder<LoginControllerImp>(
          builder: (controller) => HandlingDataAuthview(
            statusRequest: controller.statusRequest,
            widget: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    context.theme.colorScheme.primary.withOpacity(0.1),
                    context.theme.colorScheme.surface,
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
                    CustomTextBodyAuth(
                      bodyText: "12".tr,
                    ),
                    SizedBox(height: context.scaleConfig.scale(20)),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            context.scaleConfig.scale(15)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(context.scaleConfig.scale(12)),
                        child: Column(
                          children: [
                            SignInButtonTrigger(),
                            if (controller.emailstatus)
                              const SignInEmailPassword(),
                            SizedBox(height: context.scaleConfig.scale(15)),
                            GoogleSignIn(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: context.scaleConfig.scale(20)),
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
