import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/auth/resetpassword_controller.dart';
import 'package:companymanagment/core/class/handlingdataview.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/core/functions/validinput.dart';
import 'package:companymanagment/view/widget/auth/shared/custom_button_auth.dart';
import 'package:companymanagment/view/widget/auth/shared/custom_text_body_auth.dart';
import 'package:companymanagment/view/widget/auth/shared/custom_text_form_auth.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ResetControllerImp());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.appTheme.scaffoldBackgroundColor,
        elevation: 0.0,
        title: Text(
          "44".tr,
          style: context.appTheme.textTheme.headlineLarge!.copyWith(
            color: context.appTheme.colorScheme.onSurface.withOpacity(0.7),
            fontSize: context.scaleConfig.scaleText(24),
          ),
        ),
      ),
      body: GetBuilder<ResetControllerImp>(
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
                    CustomTextBodyAuth(bodyText: "45".tr),
                    SizedBox(height: context.scaleConfig.scale(25)),
                    Customtextformauth(
                      isNumber: false,
                      validator: (val) => validInput(val!, 5, 30, 'password'),
                      mycontroller: controller.password,
                      texthint: "46".tr,
                      label: "47".tr,
                      iconData: Icons.lock_outline,
                    ),
                    Customtextformauth(
                      isNumber: false,
                      validator: (val) => validInput(val!, 5, 30, 'password'),
                      mycontroller: controller.repassword,
                      texthint: "48".tr,
                      label: "49".tr,
                      iconData: Icons.lock_outline,
                    ),
                    CustomButtonAuth(
                      textbutton: "50".tr,
                      onPressed: controller.resetpassword,
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
