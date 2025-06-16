import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/auth/createprofile.dart';
import 'package:tasknotate/core/class/statusrequest.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/core/functions/alertexitapp.dart';
import 'package:tasknotate/core/functions/validinput.dart';
import 'package:tasknotate/view/widget/auth/shared/custom_button_auth.dart';
import 'package:tasknotate/view/widget/auth/shared/custom_text_body_auth.dart';
import 'package:tasknotate/view/widget/auth/shared/custom_text_form_auth.dart';
import 'package:tasknotate/view/widget/auth/shared/custom_text_title_auth.dart';

class SignupGoogle extends StatelessWidget {
  const SignupGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CreateprofileGoogleControllerImp());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.appTheme.scaffoldBackgroundColor,
        elevation: 0.0,
        title: Text(
          "21".tr,
          style: context.appTheme.textTheme.headlineLarge!.copyWith(
            color: context.appTheme.colorScheme.onSurface.withOpacity(0.7),
            fontSize: context.scaleConfig.scaleText(30),
          ),
        ),
      ),
      // ignore: deprecated_member_use
      body: WillPopScope(
        onWillPop: () => alertExitApp(),
        child: GetBuilder<CreateprofileGoogleControllerImp>(
          builder: (controller) =>
              controller.statusRequest == StatusRequest.loading
                  ? Center(
                      child: CircularProgressIndicator(
                          color: context.appTheme.colorScheme.primary))
                  : Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.scaleConfig.scale(40),
                          vertical: context.scaleConfig.scale(15),
                        ),
                        child: Form(
                          key: controller.formstate,
                          child: ListView(
                            children: [
                              SizedBox(height: context.scaleConfig.scale(20)),
                              CustomTextTitleAuth(text: "22".tr),
                              SizedBox(height: context.scaleConfig.scale(10)),
                              CustomTextBodyAuth(bodyText: "23".tr),
                              SizedBox(height: context.scaleConfig.scale(15)),
                              Customtextformauth(
                                isNumber: false,
                                validator: (val) =>
                                    validInput(val!, 2, 30, 'username'),
                                mycontroller: controller.username,
                                texthint: "24".tr,
                                label: "25".tr,
                                iconData: Icons.person,
                              ),
                              Customtextformauth(
                                isNumber: true,
                                validator: (val) =>
                                    validInput(val!, 5, 40, 'phone'),
                                mycontroller: controller.phone,
                                texthint: "28".tr,
                                label: "29".tr,
                                iconData: Icons.phone,
                              ),
                              CustomButtonAuth(
                                textbutton: "32".tr,
                                onPressed: controller.googlesignup,
                              ),
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
