import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/auth/forget_controller.dart';
import 'package:tasknotate/core/class/handlingdataview.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/core/functions/validinput.dart';
import 'package:tasknotate/view/widget/auth/shared/custom_button_auth.dart';
import 'package:tasknotate/view/widget/auth/shared/custom_text_body_auth.dart';
import 'package:tasknotate/view/widget/auth/shared/custom_text_form_auth.dart';
import 'package:tasknotate/view/widget/auth/shared/custom_text_title_auth.dart';

class Forgetpassword extends StatelessWidget {
  const Forgetpassword({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ForgetControllerImp());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.appTheme.scaffoldBackgroundColor,
        elevation: 0.0,
        title: Text(
          "35".tr,
          style: context.appTheme.textTheme.headlineLarge!.copyWith(
            color: context.appTheme.colorScheme.onSurface.withOpacity(0.7),
            fontSize: context.scaleConfig.scaleText(24),
          ),
        ),
      ),
      body: GetBuilder<ForgetControllerImp>(
        builder: (controller) => Handlingdataview(
          statusRequest: controller.statusRequest,
          widget: Center(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.scaleConfig.scale(40),
                vertical: context.scaleConfig.scale(40),
              ),
              child: Form(
                key: controller.formstate,
                child: ListView(
                  children: [
                    SizedBox(height: context.scaleConfig.scale(20)),
                    CustomTextTitleAuth(text: "36".tr),
                    SizedBox(height: context.scaleConfig.scale(10)),
                    CustomTextBodyAuth(bodyText: "37".tr),
                    SizedBox(height: context.scaleConfig.scale(15)),
                    Customtextformauth(
                      isNumber: false,
                      validator: (val) => validInput(val!, 5, 100, 'email'),
                      mycontroller: controller.email,
                      texthint: "38".tr,
                      label: "39".tr,
                      iconData: Icons.email_outlined,
                    ),
                    CustomButtonAuth(
                      textbutton: "40".tr,
                      onPressed: controller.checkemail,
                    ),
                    SizedBox(height: context.scaleConfig.scale(30)),
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
