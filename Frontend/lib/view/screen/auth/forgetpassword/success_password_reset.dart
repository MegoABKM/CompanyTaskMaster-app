import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/auth/successpassword_controller.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/view/widget/auth/shared/custom_button_auth.dart';
import 'package:companymanagment/view/widget/auth/shared/custom_text_body_auth.dart';
import 'package:companymanagment/view/widget/auth/shared/custom_text_title_auth.dart';

class SuccessPasswordReset extends StatelessWidget {
  const SuccessPasswordReset({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SuccessPasswordControllerImp());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.appTheme.scaffoldBackgroundColor,
        elevation: 0.0,
        title: Text(
          "51".tr,
          style: context.appTheme.textTheme.headlineLarge!.copyWith(
            color: context.appTheme.colorScheme.onSurface.withOpacity(0.7),
            fontSize: context.scaleConfig.scaleText(24),
          ),
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.scaleConfig.scale(40),
            vertical: context.scaleConfig.scale(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: context.scaleConfig.scale(200),
              ),
              SizedBox(height: context.scaleConfig.scale(20)),
              CustomTextTitleAuth(text: "52".tr),
              SizedBox(height: context.scaleConfig.scale(10)),
              CustomTextBodyAuth(bodyText: "53".tr),
              SizedBox(height: context.scaleConfig.scale(15)),
              CustomButtonAuth(
                textbutton: "54".tr,
                onPressed: () =>
                    Get.find<SuccessPasswordControllerImp>().goToLogin(),
              ),
              SizedBox(height: context.scaleConfig.scale(30)),
            ],
          ),
        ),
      ),
    );
  }
}
